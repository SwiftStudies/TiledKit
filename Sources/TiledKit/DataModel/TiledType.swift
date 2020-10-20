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

/// Enables the definition or identification of the type of any of the core Tiled objects such as maps, layers, etc.
public struct TiledType : OptionSet, CustomStringConvertible {
    /// The bitmask
    public let rawValue : Int
    
    /// Create a new instance
    /// - Parameter rawValue: The bit value to use
    public init(rawValue:Int){
        self.rawValue = rawValue
    }
    
    /// The object is or must be a tiled map
    public static let map                       = TiledType(rawValue: 1 << 0)
    /// The object is or must be a tiled tile layer
    public static let tileLayer                 = TiledType(rawValue: 1 << 1)
    /// The object is or must be a tiled image layer
    public static let imageLayer                = TiledType(rawValue: 1 << 2)
    /// The object is or must be a tiled group layer
    public static let groupLayer                = TiledType(rawValue: 1 << 3)
    /// The object is or must be a tiled object layer
    public static let objectLayer               = TiledType(rawValue: 1 << 4)
    /// The object is or must be a point object
    public static let pointObject               = TiledType(rawValue: 1 << 5)
    /// The object is or must be a rectangle object
    public static let rectangleObject           = TiledType(rawValue: 1 << 6)
    /// The object is or must be a ellipse object
    public static let ellipseObject             = TiledType(rawValue: 1 << 7)
    /// The object is or must be a polyline object
    public static let polylineObject            = TiledType(rawValue: 1 << 8)
    /// The object is or must be a polygon object
    public static let polygonObject             = TiledType(rawValue: 1 << 9)
    /// The object is or must be a tile object
    public static let tileObject                = TiledType(rawValue: 1 << 10)
    /// The object is or must be a text object
    public static let textObject                = TiledType(rawValue: 1 << 11)
    /// The object is or must be a tile object from a tile set
    public static let tile                      = TiledType(rawValue: 1 << 12)

    /// Used for conditionals where the object must be a layer
    public static let anyLayer : TiledType     = [
        .tileLayer, .imageLayer, .groupLayer, .objectLayer
    ]
    
    /// Used for conditionals where the object must be an tiled object
    public static let anyObject : TiledType    = [
        .pointObject, .rectangleObject, ellipseObject, .polylineObject, .polygonObject, .tileObject, .textObject
    ]

    /// Used for conditionals where the object must be a geometric (point, rectangle, ellipse, polyline, or polygon)
    public static let anyShape : TiledType    = [
        .rectangleObject, ellipseObject, .polylineObject, .polygonObject
    ]
    
    internal func nameFor(rawValue:Int)->String?{
        switch TiledType(rawValue: rawValue){
        case .map:
            return "Map"
        case .tileLayer:
            return "Tile Layer"
        case .imageLayer:
            return "Image Layer"
        case .groupLayer:
            return "Group"
        case .objectLayer:
            return "Object Layer"
        case .pointObject:
            return "Point"
        case .rectangleObject:
            return "Rectangle"
        case .ellipseObject:
            return "Ellipse"
        case .polylineObject:
            return "Polyline"
        case .polygonObject:
            return "Polygon"
        case .tileObject:
            return "Tile Instance"
        case .textObject:
            return "Text"
        case .tile:
            return "Tile Defintion"
        default:
            return "Unknown Type \(rawValue)"
        }
    }
    
    /// Describes the condition or type
    public var description: String {
        var types = [String]()
        for i in 0..<Int.bitWidth {
            if let name = nameFor(rawValue: 1 << i), rawValue & (1 << i) != 0 {
                types.append(name)
            }
        }
        return types.joined(separator: "/")
    }
}

/// Enables any propertied Tiled object to have its type determined
public extension Propertied {
    
    /// Determines if the type of the propertied object matches the type supplied
    /// - Parameter type: The type(s) to be tested
    /// - Returns: `true` if it matches, false otherwise
    func `is`(a type:TiledType)->Bool{
        return type.contains(tiledType)
    }
    
    /// The type of the Propertied object
    var tiledType : TiledType {
        if let object = self as? Object {
            switch object.kind {
            case.point:
                return .pointObject
            case .rectangle:
                return .rectangleObject
            case .ellipse:
                return .ellipseObject
            case .polyline:
                return .polylineObject
            case .polygon:
                return .polygonObject
            case .text:
                return .textObject
            case .tile:
                return .tileObject
            }
        } else if let layer = self as? Layer {
            switch layer.kind {
            case .group:
                return .groupLayer
            case .image:
                return .imageLayer
            case .tile:
                return .tileLayer
            case .objects:
                return .objectLayer
            }
        } else if self is Map {
            return .map
        } else if self is Tile {
            return .tile
        } else {
            return []
        }
    }
}
