//    Copyright 2020 Swift Studies
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

import Foundation

@dynamicMemberLookup
public class Layer: TiledDecodable, Propertied{
    public let name    : String
    public let visible : Bool
    public let opacity : Double
    public var x       : Int
    public var y       : Int
    
    public let parent  : LayerContainer
    
    public var properties = [String : PropertyValue]()
    
    public var level : Level {
        return parent.level
    }
    
    enum CodingKeys : String, CodingKey {
        case name, visible, opacity, x, y, objects = "objectgroup", layers = "layer", group = "group", imagelayer = "imagelayer"
        case tileData  = "data"
        case tileWidth = "width"
        case tileHeight = "height"
    }
    
    public required init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            throw TiledDecodingError.missingDecoderContext
        }
        
        if let containedBy = decoderContext.currentContainer {
            parent = containedBy
        } else {
            throw TiledDecodingError.noContainerForLayer(layerPath: decoderContext.layerPath)
        }
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            name = try container.decode(String.self, forKey: .name)
            
            x = (try? container.decode(Int.self, forKey: .x)) ?? 0
            y = (try? container.decode(Int.self, forKey: .y)) ?? 0
            
            visible = (try? container.decode(Bool.self, forKey: .visible)) ?? true
            opacity = (try? container.decode(Double.self, forKey: .opacity)) ?? 1.0
                    
            if let properties = try? decode(from: decoder) {
                self.properties = properties
            }
        } catch {
            throw error
        }
    }
}

public extension Layer {
    subscript(_ property:String)->PropertyValue?{
        return self[property, defaultingTo:nil]
    }
    
    subscript(_ property:String, defaultingTo defaultValue:PropertyValue?)->PropertyValue?{
        if let onSelf = properties[property]{
            return onSelf
        }
        return parent[property, defaultingTo:defaultValue]
    }
}

public extension LayerContainer{
    subscript(_ property:String)->PropertyValue?{
        return self[property, defaultingTo:nil]
    }
    
    subscript(_ property:String, defaultingTo defaultValue:PropertyValue?)->PropertyValue?{
        if let propertiedSelf = self as? Propertied, let onSelf = propertiedSelf.properties[property]{
            return onSelf
        }
        
        if !(self is Level){
            return parent[property, defaultingTo: defaultValue]
        }
        
        return nil
    }
}

private class LayerData : Decodable {
    enum Encoding : String, Decodable {
        case csv
        
        func decode(mapFrom string:String)->[Int]{
            let string = string.replacingOccurrences(of: "\n", with: "")
            return string.split(separator: ",").map({Int($0) ?? 0})
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case encoding, data = ""
    }
    
    let encoding : Encoding
    let data : String
    
    var tiles : [Int] {
        
        #warning("Needs to be implemented")
        return encoding.decode(mapFrom: data)
    }
}

public class TileLayer : Layer{
    public let width : Int
    public let height : Int
    public let tiles : [Int]
    public let offset : (x:Int, y:Int)
    
    enum TiledCodingKeys : String, CodingKey {
        case tiles = "data", width, height,offsetx, offsety
    }
    
    required public init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: TiledCodingKeys.self)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        let data = try container.decode(LayerData.self, forKey: .tiles)
        
        tiles = data.tiles
        
        let offsetx = (try? container.decode(Int.self, forKey: .offsetx)) ?? 0
        let offsety = (try? container.decode(Int.self, forKey: .offsety)) ?? 0
        offset = (offsetx, offsety)
        try super.init(from: decoder)
    }
    
    public subscript(_ x:Int, _ y:Int)->Int{
        return tiles[x+y*width]
    }
}

public class ObjectLayer : Layer{
    public var objects = [Object] ()
    
    public enum ObjectLayerCodingKeys : String, CodingKey {
        case object, offsetx, offsety
    }
    
    public subscript(id:Int)->Object? {
        return objects.filter({$0.id == id}).first
    }
    
    public subscript(name:String)->[Object] {
        return objects.filter({$0.name ?? "" == name})
    }

    
    public required init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            throw TiledDecodingError.missingDecoderContext
        }

        try super.init(from: decoder)
        
        decoderContext.layerPath.append(self)
        
        let container = try decoder.container(keyedBy: ObjectLayerCodingKeys.self)
        x = try Int(container.decodeIfPresent(Double.self, forKey: .offsetx) ?? 0)
        y = try Int(container.decodeIfPresent(Double.self, forKey: .offsety) ?? 0)
        
        objects = try decodeObjects(from: decoder)
        
        for tileObject in objects.compactMap({$0 as? TileObject}){
            tileObject.tile = decoderContext.level?.tiles[tileObject.gid]
        }
        
        decoderContext.layerPath.removeLast()
    }
}

public final class GroupLayer : Layer, LayerContainer{
    
    public var layers = [Layer]()
    
    enum LayerCodingKeys : String, CodingKey {
        case layers = "layer"
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        decoder.userInfo.decodingContext?.layerPath.append(self)

        let layers : [Layer] = try Level.decodeLayers(decoder.container(keyedBy: Level.CodingKeys.self))
        self.layers.append(contentsOf: layers)
        
        decoder.userInfo.decodingContext?.layerPath.removeLast()
    }
}

public final class ImageLayer : Layer {
    private struct ImageTag : Codable {
        let path : String
        let width : Int
        let height : Int
        
        enum CodingKeys : String, CodingKey {
            case path = "source", width, height
        }
    }
    
    private enum CodingKeys : String, CodingKey{
        case offsetx, offsety, image
    }
    
    public var url : URL
    public var width : Int
    public var height : Int
    
    public required init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            throw TiledDecodingError.missingDecoderContext
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let imageTag = try container.decode(ImageTag.self, forKey: .image)
        width = imageTag.width
        height = imageTag.height
        
        if imageTag.path.hasPrefix("..") {
            if let originUrl = decoderContext.originUrl {
                url = originUrl.appendingPathComponent(imageTag.path)
            } else {
                url = URL(fileURLWithPath: imageTag.path)
            }
        } else {
            url = URL(fileURLWithPath: imageTag.path)
        }
        
        try super.init(from: decoder)


        let offsetX = try container.decodeIfPresent(Double.self, forKey: .offsetx) ?? 0
        let offsetY = try container.decodeIfPresent(Double.self, forKey: .offsety) ?? 0
        
        x = Int(offsetX)
        y = Int(offsetY)

    }
}
