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

#warning("Don't think this needs to be tiled decodable, would mean I can also get read of the initiatizer")
public class Object : Propertied{
    internal enum ObjectDecodingError : Error {
        case notMyType      // A specialisation cannot decode
        case unknownType    // No specialisation can decode
    }
    private enum CodingKeys : String, CodingKey {
        case id, name, visible, x, y, type
    }
    
    public let id          : Int
    public let name        : String?
    public let visible     : Bool
    public let x           : Float
    public let y           : Float
    public let parent      : ObjectLayer
    
    public var properties  = [String:Literal]()
    
    public var level       : Level {
        return parent.level 
    }
    
    init(id:Int, name:String, visible:Bool, x:Double, y:Double, in parent:ObjectLayer, with properties:[String:Literal]){
        self.id = id
        self.name = name
        self.visible = visible
        self.x = Float(x)
        self.y = Float(y)
        self.parent = parent
        self.properties = properties
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

public class PointObject : Object {
}

public class RectangleObject : Object{
    public let width       : Float
    public let height      : Float
    public let rotation    : Float
    
    init(id: Int, name: String, visible: Bool, x: Double, y: Double, width:Double, height:Double, in parent: ObjectLayer, with properties: [String : Literal]) {
        self.width = Float(width)
        self.height = Float(height)
        self.rotation = Float(rotation)
        super.init(id: id, name: name, visible: visible, x: x, y: y, in: parent, with: properties)
    }
}

public class EllipseObject : RectangleObject{
    
}

public class TileObject : RectangleObject{

    public let gid : Int
    public var tile    : TileSet.Tile? = nil
    
    init(id: Int, tileGid gid:Int, name: String, visible: Bool, x: Double, y: Double, width: Double, height: Double, in parent: ObjectLayer, with properties: [String : Literal]) {
        
        self.gid = gid
        self.tile = parent.level.tiles[gid]
        
        super.init(id: id, name: name, visible: visible, x: x, y: y, width: width, height: height, in: parent, with: properties)
    }
}

public class TextObject : RectangleObject{
    public struct TextProperties {
        public let fontName : String
        public let fontSize : Int
        public let text     : String
        public let color    : Color
    }
    
    public let text : TextProperties
    
    init(id: Int, name: String, visible: Bool, x: Double, y: Double, width: Double, height: Double, text:TextProperties, in parent: ObjectLayer, with properties: [String : Literal]) {
        
        self.text = text
        super.init(id: id, name: name, visible: visible, x: x, y: y, width: width, height: height, in: parent, with: properties)
    }
}


public class PolygonObject : Object{
    public let points : [Position]
    
    
    init(id: Int, name: String, visible: Bool, x: Double, y: Double, points:[Position], in parent: ObjectLayer, with properties: [String : Literal]) {
        self.points = points
        super.init(id: id, name: name, visible: true, x: x, y: y, in: parent, with: properties)
    }
}

public class PolylineObject : PolygonObject{
}

fileprivate struct LoadableObject : Decodable {
    let id : Int
    let name : String
    let x : Double
    let y : Double
    let width: Double?
    let height : Double?
    let rotation : Double
    let kind : Kind
    let visible : Bool
    let properties : [String:Literal]
    let parent : ObjectLayer

    enum Kind {
        case tile(gid:Int), point, ellipse, rectangle, polyline(points:[(x:Double,y:Double)]), text(wrap:Bool, string:String),polygon(points:[(x:Double,y:Double)])
    }
    
    struct PolygonPoints : Decodable {
        var points : String
        
        var pointsArray : [(x:Double,y:Double)] {
            return points.split(separator: " ").map{
                let xy = $0.split(separator: ",")
                #warning("Remove forced unwrap")
                return (x:Double(xy[0])!,y:Double(xy[1])!)
            }
        }
    }
    
    struct TextDefinition : Decodable {
        var wrap : Bool
        var string : String
        
        enum CodingKeys : String, CodingKey {
            case wrap, string = ""
        }
        
    }
    
    enum CodingKeys : String, CodingKey {
        case id, name, x, y, width, height, gid, rotation, ellipse, point, polygon, text, visible, polyline
    }
    
    init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            fatalError("No decoder context")
        }
        
        guard let objectLayer : ObjectLayer = decoderContext.currentContainer as? ObjectLayer else {
            fatalError("Current container is not an object layer")
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode((String.self), forKey: .name)
        x = try container.decode(Double.self, forKey: .x)
        y = try container.decode(Double.self, forKey: .y)
        width = try container.decodeIfPresent(Double.self, forKey: .width)
        height = try container.decodeIfPresent(Double.self, forKey: .height)
        rotation = try container.decodeIfPresent(Double.self, forKey: .rotation) ?? 0.0
        visible = try container.decodeIfPresent(Bool.self, forKey: .visible) ?? true
        #warning("Does not load properties")
        properties = [String:Literal]()
        parent = objectLayer
        
        
        
        if container.allKeys.contains(.ellipse){
            kind = .ellipse
        } else if container.allKeys.contains(.point){
            kind = .point
        } else if container.allKeys.contains(.gid){
            kind = .tile(gid: try container.decode(Int.self, forKey: .gid))
        } else if container.allKeys.contains(.text){
            let definition = try container.decode(TextDefinition.self, forKey: .text)
            kind = .text(wrap: definition.wrap, string: definition.string)
        } else if container.allKeys.contains(.polygon){
            let polygonPoints = try container.decode(PolygonPoints.self, forKey: .polygon)
            kind = .polyline(points: polygonPoints.pointsArray)
        } else {
            kind = .rectangle
        }
        
    }
    
    #warning("Lots of forced unwrapping")
    var objectInstance : Object {
        switch kind {
        case .tile(gid: let gid):
            return TileObject(id: id, tileGid: gid, name: name, visible: visible, x: x, y: y, width: width!, height: height!, in: parent, with: properties)
        case .point:
            return PointObject(id: id, name: name, visible: visible, x: x, y: y, in: parent, with: properties)
        case .ellipse:
            return EllipseObject(id: id, name: name, visible: visible, x: x, y: y, width: width!, height: height!, in: parent, with: properties
        case .rectangle:
            return RectangleObject(id: id, name: name, visible: visible, x: x, y: y, width: width!, height: height!, in: parent, with: properties
        case .polyline(points: let points):
            return PolylineObject(id: id, name: name, visible: visible, x: x, y: y, points: kind, in: <#T##ObjectLayer#>, with: <#T##[String : Literal]#>)
        case .text(wrap: let wrap, string: let string):
            #warning("Lots of things not read, create failing test")
            let text = TextObject.TextProperties(fontName: "", fontSize: 12, text: string, color: Color(r: 255, g: 255, b: 255))
            return TextObject(id: id, name: name, visible: visible, x: x, y: y, width: width!, height: height!, text: text, in: parent, with: properties)
        }
    }
}

extension ObjectLayer {
    func decodeObjects(from decoder: Decoder) throws -> [Object] {
        let container = try decoder.container(keyedBy: ObjectLayerCodingKeys.self)
        
        let objects = try container.decode([LoadableObject].self, forKey: .object).map{
            $0.objectInstance
        }

        return objects
    }
}

