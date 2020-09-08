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

public class Layer: TiledDecodable, Propertied{
    public let name    : String
    public let visible : Bool
    public let opacity : Float
    public let x       : Int
    public let y       : Int
    
    public let parent  : LayerContainer
    
    public var properties = [String : Literal]()
    
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
            fatalError("No DecodingContext")
        }
        
        if let containedBy = decoderContext.currentContainer {
            parent = containedBy
        } else {
            #warning("Should throw instead")
            fatalError("No container for layer")
        }
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            name = try container.decode(String.self, forKey: .name)
            print("Decoding \(name) with path \(decoderContext.layerPath.map({$0.name}))")
            
            x = (try? container.decode(Int.self, forKey: .x)) ?? 0
            y = (try? container.decode(Int.self, forKey: .y)) ?? 0
            
            visible = (try? container.decode(Bool.self, forKey: .visible)) ?? true
            opacity = (try? container.decode(Float.self, forKey: .opacity)) ?? 1.0
                    
            properties = try decode(from: decoder)
        } catch {
            print("Whilst building \(Swift.type(of: Self.self)) encountered decoding error: \(error.localizedDescription)")
            throw error
        }
    }
}

public extension Layer {
    subscript(_ property:String)->Literal?{
        return self[property, defaultingTo:nil]
    }
    
    subscript(_ property:String, defaultingTo defaultValue:Literal?)->Literal?{
        if let onSelf = properties[property]{
            return onSelf
        }
        return parent[property, defaultingTo:defaultValue]
    }
}

public extension LayerContainer{
    subscript(_ property:String)->Literal?{
        return self[property, defaultingTo:nil]
    }
    
    subscript(_ property:String, defaultingTo defaultValue:Literal?)->Literal?{
        if let propertiedSelf = self as? Propertied, let onSelf = propertiedSelf.properties[property]{
            return onSelf
        }
        
        if !(self is Level){
            return parent[property, defaultingTo: defaultValue]
        }
        
        return nil
    }
}

public enum LayerDataEncoding : String, Codable {
    case none
    case csv
}

public class LayerData : Decodable {
    public let contents : String
    public let encoding : LayerDataEncoding
    
    enum CodingKeys : String, CodingKey {
        case encoding, contents = ""
    }
    
    var tiles : [Int] {
        #warning("Needs to be implemented")
        return [0]
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
    
    public required init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            fatalError("No DecodingContext")
        }

        try super.init(from: decoder)
        
        decoderContext.layerPath.append(self)
        objects = try decodeObjects(from: try decoder.container(keyedBy: CodingKeys.self).nestedUnkeyedContainer(forKey: .objects), in: decoderContext)
        
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
    let offsetx : Double = 0.0
    let offsety : Double = 0.0

    public required init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            fatalError("No DecodingContext")
        }
        try super.init(from: decoder)
        #warning("Image Layers not implemented")
    }
}
