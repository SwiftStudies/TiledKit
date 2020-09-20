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
    public let x           : Double
    public let y           : Double
    public let parent      : ObjectLayer
    
    public var properties  = [String:PropertyValue]()
    
    public var level       : Level {
        return parent.level 
    }
    
    init(id:Int, name:String, visible:Bool, x:Double, y:Double, in parent:ObjectLayer, with properties:[String:PropertyValue]){
        self.id = id
        self.name = name
        self.visible = visible
        self.x = x
        self.y = y
        self.parent = parent
        self.properties = properties
    }
}

public extension Object {
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

public class PointObject : Object {
}

public class RectangleObject : Object{
    public let width       : Double
    public let height      : Double
    public let rotation    : Double
    
    init(id: Int, name: String, visible: Bool, x: Double, y: Double, width:Double, height:Double, rotatedTo:Double, in parent: ObjectLayer, with properties: [String : PropertyValue]) {
        self.width = width
        self.height = height
        self.rotation = rotatedTo
        super.init(id: id, name: name, visible: visible, x: x, y: y, in: parent, with: properties)
    }
}

public class EllipseObject : RectangleObject{
    
}

public class TileObject : RectangleObject{

    public let gid : Int
    public var tile    : TileSet.Tile? = nil
    
    init(id: Int, tileGid gid:Int, name: String, visible: Bool, x: Double, y: Double, width: Double, height: Double, rotation: Double, in parent: ObjectLayer, with properties: [String : PropertyValue]) {
        
        self.gid = gid
        self.tile = parent.level.tiles[gid]
        
        super.init(id: id, name: name, visible: visible, x: x, y: y, width: width, height: height, rotatedTo: rotation, in: parent, with: properties)
    }
}

public class TextObject : RectangleObject{
    public struct TextStyle {
        public let wrap : Bool
        public let fontFamily : String?
        public let pixelSize : Int
        public let color : Color
        public let verticalAlignment : VerticalTextAlignment
        public let horizontalAlignment : HorizontalTextAlignment
        public let bold : Bool
        public let italic : Bool
        public let underline : Bool
        public let strikeout : Bool
        public let kerning : Bool
        
        internal init(from definition:TextDefinition){
            self.wrap = definition.wrap
            self.fontFamily = definition.fontFamily
            self.pixelSize = definition.pixelSize
            self.color = definition.color
            self.verticalAlignment = definition.verticalAlignment
            self.horizontalAlignment = definition.horizontalAlignment
            self.bold = definition.bold
            self.italic = definition.italic
            self.underline = definition.underline
            self.strikeout = definition.strikeout
            self.kerning = definition.kerning
        }
    }
    
    public let string : String
    public let style : TextStyle
    
    internal init(id: Int, name: String, visible: Bool, x: Double, y: Double, width: Double, height: Double, rotation:Double, text:TextDefinition, in parent: ObjectLayer, with properties: [String : PropertyValue]) {
        
        self.string = text.string
        
        self.style = TextStyle(from: text)
        
        super.init(id: id, name: name, visible: visible, x: x, y: y, width: width, height: height, rotatedTo: rotation, in: parent, with: properties)
    }
}


public class PolygonObject : Object{
    public let points : [Position]
    
    
    init(id: Int, name: String, visible: Bool, x: Double, y: Double, points:[Position], in parent: ObjectLayer, with properties: [String : PropertyValue]) {
        self.points = points
        super.init(id: id, name: name, visible: true, x: x, y: y, in: parent, with: properties)
    }
}

public class PolylineObject : PolygonObject{
}

fileprivate struct LoadableObject : Decodable, Propertied {
    let id : Int
    let name : String
    let x : Double
    let y : Double
    let width: Double?
    let height : Double?
    let rotation : Double
    let kind : Kind
    let visible : Bool
    var properties = [String:PropertyValue]()
    let parent : ObjectLayer

    enum Kind {
        case tile(gid:Int), point, ellipse, rectangle, polyline(points:[Position]), text(definition:TextDefinition),polygon(points:[Position])
    }
    
    struct PolygonPoints : Decodable {
        var points : String
        
        var pointsArray : [Position] {
            return points.split(separator: " ").map{
                let xy = $0.split(separator: ",")
                #warning("Remove forced unwrap")
                return Position(x: Double(xy[0])!, y: Double(xy[1])!)
            }
        }
    }
    
    
    enum CodingKeys : String, CodingKey {
        case id, name, x, y, width, height, gid, rotation, ellipse, point, polygon, text, visible, polyline
    }
    
    init(from decoder: Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            throw TiledDecodingError.missingDecoderContext
        }
        
        guard let objectLayer : ObjectLayer = decoderContext.layerPath.last as? ObjectLayer else {
            throw TiledDecodingError.objectNotContainedInObjectLayer(layerPath: decoderContext.layerPath)
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
        parent = objectLayer
        
        
        
        if container.allKeys.contains(.ellipse){
            kind = .ellipse
        } else if container.allKeys.contains(.point){
            kind = .point
        } else if container.allKeys.contains(.gid){
            kind = .tile(gid: try container.decode(Int.self, forKey: .gid))
        } else if container.allKeys.contains(.text){
            let definition = try container.decode(TextDefinition.self, forKey: .text)
            kind = .text(definition: definition)
        } else if container.allKeys.contains(.polygon){
            let polygonPoints = try container.decode(PolygonPoints.self, forKey: .polygon)
            kind = .polygon(points: polygonPoints.pointsArray)
        } else if container.allKeys.contains(.polyline) {
            let polygonPoints = try container.decode(PolygonPoints.self, forKey: .polyline)
            kind = .polyline(points: polygonPoints.pointsArray)
        } else {
            kind = .rectangle
        }
        
        if let properties = try? decode(from: decoder) {
            self.properties = properties
        }
        
    }
    
    #warning("Lots of forced unwrapping")
    var objectInstance : Object {
        switch kind {
        case .tile(gid: let gid):
            return TileObject(id: id, tileGid: gid, name: name, visible: visible, x: x, y: y, width: width!, height: height!, rotation: rotation, in: parent, with: properties)
        case .point:
            return PointObject(id: id, name: name, visible: visible, x: x, y: y, in: parent, with: properties)
        case .ellipse:
            return EllipseObject(id: id, name: name, visible: visible, x: x, y: y, width: width!, height: height!, rotatedTo: rotation, in: parent, with: properties)
        case .rectangle:
            return RectangleObject(id: id, name: name, visible: visible, x: x, y: y, width: width!, height: height!, rotatedTo: rotation, in: parent, with: properties)
        case .polygon(points: let points):
            return PolygonObject(id: id, name: name, visible: visible, x: x, y: y, points: points, in: parent, with: properties)
        case .polyline(points: let points):
            return PolylineObject(id: id, name: name, visible: visible, x: x, y: y, points: points, in: parent, with: properties)
        case .text(let definition):
            return TextObject(id: id, name: name, visible: visible, x: x, y: y, width: width!, height: height!, rotation: rotation, text: definition, in: parent, with: properties)
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

