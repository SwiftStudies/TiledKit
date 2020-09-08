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

public protocol CustomObject {
    static var identifier : String { get }
    init?(for object: Object)
}

fileprivate var registeredCustomObjectTypes = [CustomObject.Type]()

enum CustomObjectFactory {
    static func make(for object:Object, with customObjectTypes:[CustomObject.Type])->CustomObject? {
        for type in customObjectTypes {
            if type.identifier == object.rawType ?? "" {
                return type.init(for: object)
            }
        }
        return nil
    }
}

public class Object : TiledDecodable, Propertied{
    internal enum ObjectDecodingError : Error {
        case notMyType      // A specialisation cannot decode
        case unknownType    // No specialisation can decode
    }
    private enum CodingKeys : String, CodingKey {
        case id, name, visible, x, y, type
    }
    
    public let id          : Int
    public let name        : String?
    public var type        : CustomObject?
    fileprivate let rawType : String?
    public let visible     : Bool
    public let x           : Float
    public let y           : Float
    public let parent      : ObjectLayer
    
    public var properties  = [String:Literal]()
    
    public var level       : Level {
        return parent.level 
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //Standard stuff
        id      = try container.decode(Int.self, forKey: .id)
        name    = try container.decodeIfPresent(String.self, forKey: .name)
        visible = try container.decode(Bool.self, forKey: .visible)
        x       = try container.decode(Float.self, forKey: .x)
        y       = try container.decode(Float.self, forKey: .y)
        rawType = try container.decodeIfPresent(String.self, forKey: .type)
        
        parent = decoder.userInfo.levelDecodingContext(originatingFrom: nil).layerPath.last! as! ObjectLayer
        
        // Properties
        properties = try decode(from: decoder)
    }
}

public extension Object {
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

class PointObject : Object {
    private enum CodingKeys : String, CodingKey {
        case point
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if try container.decodeIfPresent(Bool.self, forKey: .point) ?? false != true {
            throw ObjectDecodingError.notMyType
        }
        
        try super.init(from: decoder)
    }
}

public class RectangleObject : Object{
    private enum CodingKeys : String, CodingKey {
        case width, height, rotation
    }

    public let width       : Float
    public let height      : Float
    public let rotation    : Float
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if !(container.contains(.width) && container.contains(.height) && container.contains(.rotation)) {
            throw ObjectDecodingError.notMyType
        }
        
        width       = try container.decode(Float.self, forKey: .width)
        height      = try container.decode(Float.self, forKey: .height)
        rotation    = try container.decode(Float.self, forKey: .rotation)

        try super.init(from: decoder)
    }
}

class EllipseObject : RectangleObject{
    private enum CodingKeys : String, CodingKey {
        case ellipse
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if try container.decodeIfPresent(Bool.self, forKey: .ellipse) ?? false != true {
            throw ObjectDecodingError.notMyType
        }
        
        try super.init(from: decoder)
    }
}

public class TileObject : RectangleObject{
    private enum CodingKeys : String, CodingKey {
        case gid, tile
    }
    
    public let gid : Int
    public var tile    : TileSet.Tile? = nil
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if !container.contains(.gid) {
            throw ObjectDecodingError.notMyType
        }
        
        gid = try container.decode(Int.self, forKey: .gid)
        
        try super.init(from: decoder)
    }
}

public class TextObject : RectangleObject{
    public struct TextProperties : Decodable{
        public let fontName : String
        public let fontSize : Int
        public let text     : String
        public let color    : Color
        
        enum CodingKeys : String, CodingKey {
            case    fontName = "fontfamily",
            fontSize = "pixelsize",
            text,color
        }
    }
    
    
    private enum CodingKeys : String, CodingKey {
        case text
    }
    
    public let text : TextProperties
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if !container.contains(.text) {
            throw ObjectDecodingError.notMyType
        }
        
        text = try container.decode(TextProperties.self, forKey: .text)
        
        try super.init(from: decoder)
    }
}


public class PolygonObject : Object{
    private enum CodingKeys : String, CodingKey {
        case polygon
    }
    
    public let points : [Position]
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if !container.contains(.polygon) {
            throw ObjectDecodingError.notMyType
        }
        
        points = try container.decode([Position].self, forKey: .polygon)
        
        try super.init(from: decoder)
    }
}

public class PolylineObject : Object{
    private enum CodingKeys : String, CodingKey {
        case polyline
    }
    
    public let points : [Position]
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if !container.contains(.polyline) {
            throw ObjectDecodingError.notMyType
        }
        
        points = try container.decode([Position].self, forKey: .polyline)
        
        try super.init(from: decoder)
    }
}

extension ObjectLayer {
    func decodeObjects(from container: UnkeyedDecodingContainer, in context:DecodingContext) throws -> [Object] {
        var container = container
        let objectKinds = [PolylineObject.self, PolygonObject.self, PointObject.self, TextObject.self, TileObject.self, EllipseObject.self, RectangleObject.self]
        
        var objects = [Object]()

        ontoNextObject: while !container.isAtEnd {
            for objectKind in objectKinds {
                do {
                    objects.append(try container.decode(objectKind))
                    
                    continue ontoNextObject
                } catch let error as DecodingError {
                    throw error
                } catch _ as Object.ObjectDecodingError {
                    continue
                }
            }

        }
        
        return objects
    }
}

public extension LayerContainer {
    func customObjects<T>(traverseGroups:Bool = false)->[T]{
        var objects = [T]()
        
        for layer in getObjectLayers(recursively: traverseGroups) as [ObjectLayer]{
            objects.append(contentsOf: layer.objects.compactMap({$0.type as? T}))
        }
        
        return objects
    }
}
