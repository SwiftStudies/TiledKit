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
import TiledKit

final class TestEngine : Engine {
    typealias FloatType = Float
    typealias ColorType = UInt32
    typealias MapType = TestMap
    typealias SpriteType = TestSprite
    typealias TextureType = TestTexture
    typealias TileLayerType = TestNode
    typealias GroupLayerType = TestNode
    typealias ObjectLayerType = TestNode
    typealias PointObjectType = TestPoint
    typealias RectangleObjectType = TestRectangle
    typealias EllipseObjectType = TestEllipse
    typealias TextObjectType = TestText
    typealias PolylineObjectType = TestPologonal
    typealias PolygonObjectType = TestPologonal

    static func load(textureFrom url: URL, in project:Project) throws -> TestTexture {
        return TestTexture(from: url)
    }
    
    static func make(mapFor map: Map) throws -> TestMap {
        return TestMap(size:map.pixelSize)
    }
    
    static func registerProducers() {
        return
    }
    
    //
    // Tile Processing
    //
    
    static var createdSprites = [SpriteType]()
    
    static func make(spriteFor tile: Tile, in tileset: TileSet, with texture: TestTexture, from project: Project) throws -> TestSprite {
        let sprite = TestSprite()
        
        createdSprites.append(sprite)
        return sprite
    }
    
    static func postProcess(_ specializedMap: TestMap, for map: Map, from project: Project) throws -> TestMap {
        return specializedMap
    }
    
    static func process(_ sprite: TestSprite, from tile: Tile, in tileSet: TileSet, with setSprites: [UInt32 : TestSprite], for map: Map, from project: Project) throws -> TestSprite {
        sprite.postProcessed = true
      return sprite
    }
    
    static func make(spriteFrom texture: TestTexture, for layer: LayerProtocol, in map: Map, from project: Project) throws -> TestSprite? {
        return TestSprite()
    }
    
    static func make(groupFrom layer: LayerProtocol, in map: Map, from project: Project) throws -> TestNode? {
        return TestNode()
    }
    
    static func make(objectContainerFrom layer: LayerProtocol, in map: Map, from project: Project) throws -> TestNode? {
        return TestNode()
    }
        
    static func make(tileLayer tileGrid: TileGrid, for layer: LayerProtocol, with sprites: MapTiles<TestEngine>, in map: Map, from project: Project) throws -> TestNode? {
        return TestNode()
    }
    
    static func make(pointFor object: ObjectProtocol, in map: Map, from project: Project) throws -> TestPoint {
        return TestPoint()
    }
    
    static func make(rectangleOf size: Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TestRectangle {
        return TestRectangle()
    }
    
    static func make(ellipseOf size: Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TestEllipse {
        return TestEllipse()
    }
    
    static func make(spriteWith tile: TestSprite, of size: Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TestSprite {
        return TestSprite()
    }
    
    static func make(textWith string: String, of size: Size, at angle: Double, with style: TextStyle, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TestText {
        return TestText()
    }
    
    static func make(polylineWith path: Path, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TestPologonal {
        return TestPologonal()
    }
    
    static func make(polygonWith path: Path, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TestPologonal {
        return TestPologonal()
    }
    
    static func make(texture: TestTexture, with bounds: PixelBounds?, and properties: Properties, in project: Project) throws -> TestTexture {
        return TestTexture()
    }
}

protocol TestableObject {
    var properties : [String:PropertyValue] { get }
}

struct TestPoint : EngineObject, TestableObject {
    typealias EngineType = TestEngine
    var properties = [String : PropertyValue]()

}

struct TestRectangle : EngineObject, TestableObject {
     typealias EngineType = TestEngine
    var properties = [String : PropertyValue]()

}

struct TestEllipse : EngineObject, TestableObject {
    typealias EngineType = TestEngine
    var properties = [String : PropertyValue]()

}

struct TestText : EngineObject, TestableObject {
    typealias EngineType = TestEngine
    var properties = [String : PropertyValue]()

}

struct TestPologonal : EngineObject, TestableObject {
    typealias EngineType = TestEngine
    var properties = [String : PropertyValue]()

}

public enum TestError : Error {
    case couldNotCreateTexture(URL)
}

class TestTexture : EngineTexture, TestableObject {
    typealias EngineType = TestEngine
    
    var properties = [String : PropertyValue]()
    var originatingUrl : URL?
    
    init(from url:URL){
        originatingUrl = url
    }
    
    init(){
        originatingUrl = nil
    }
    
    func newInstance() -> Self {
        return self
    }

}

class TestSprite : TestNode, DeepCopyable {
    var color : UInt32 = 0
    var weight : Float = 100.0
    
    var postProcessed = false
    
    func deepCopy() -> Self {
        let newCopy = TestSprite()
        
        newCopy.color = color
        newCopy.weight = weight
        newCopy.postProcessed = postProcessed
        
        return newCopy as! Self
    }
    
}

class TestNode : EngineLayerContainer, EngineObjectContainer, TestableObject {
    typealias EngineType = TestEngine

    var children = [Any]()
    var userData = [String:Any]()
    
    var properties = [String : PropertyValue]()

    
    func add(child point: TestPoint) {
        children.append(point)
    }
    
    func add(child rectangle: TestRectangle) {
        children.append(rectangle)
    }
    
    func add(child ellipse: TestEllipse) {
        children.append(ellipse)
    }
    
    func add(child text: TestText) {
        children.append(text)
    }
    
    func add(child polyline: TestPologonal) {
        children.append(polyline)
    }

    
    func add(child layer: TestNode) {
        children.append(layer)
    }
    
    func add(child sprite: TestSprite) {
        children.append(sprite)
    }
}

class TestMap : TestNode, EngineMap {
    let size : PixelSize
    
    var falseByDefault = false
    var lifeTheUniverseAndEverything = 0
    
    init(size:PixelSize){
        self.size = size
    }
    
    var cache: Bool {
        return false
    }
    
    func newInstance() -> Self {
        return self
    }
    
}

struct TestMapFactory : MapFactory {
    
    typealias EngineType = TestEngine

    func make(mapFor map: Map, in project: Project) throws -> TestMap? {
        return TestMap(size: PixelSize(width: 1, height: 1))
    }
}

struct TestTilePostProcessor : TilePostProcessor {
    typealias EngineType = TestEngine
    
    
    func process(sprite: EngineType.SpriteType, from tile: Tile, in tileSet: TileSet, with setSprites: [UInt32 : EngineType.SpriteType], for map: Map, from project: Project) throws -> EngineType.SpriteType {
        sprite.postProcessed = false
        return sprite
    }
    
}

struct TestMapPostProcessor : MapPostProcessor {
    typealias EngineType = TestEngine

    enum BridgedProperties : String, TiledEngineBridgableProperty, CaseIterable {
        typealias EngineObjectType = TestMap
        
        case booleanProperty = "Boolean Property", intProperty = "Int Property"

        var tiledName: String {
            return rawValue
        }
        
        var tiledDefault: PropertyValue {
            switch self {
            case .booleanProperty: return false
            case .intProperty: return 42
            }
        }
        
        var engineObjectProperty: PartialKeyPath<TestMap> {
            switch self {
            case .booleanProperty:
                return \EngineObjectType.falseByDefault
            case .intProperty:
                return \EngineObjectType.lifeTheUniverseAndEverything
            }
        }
        
    }
    
    func process(engineMap specializedMap: EngineType.MapType, for map: Map, from project: Project) throws -> EngineType.MapType {
        BridgedProperties.apply(map.properties, to: specializedMap)
        return specializedMap
    }
}

struct TestMultiProcessor : MapPostProcessor, LayerPostProcessor {
    typealias EngineType = TestEngine

    func process(imageLayer: TestSprite, from layer: LayerProtocol, for map: Map, in project: Project) throws -> TestSprite {
        imageLayer.userData["multiProcessed"] = true
        
        return imageLayer
    }

    
    func process(engineMap specializedMap: TestMap, for map: Map, from project: Project) throws -> EngineType.MapType {
        specializedMap.userData["multiProcessed"] = true
        
        return specializedMap
    }
    
    func process(objectLayer node: TestNode, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.ObjectLayerType {
        node.userData["multiProcessed"] = true
        
        return node
    }
    
    func process(tileLayer: TestNode, from layer: LayerProtocol, for map: Map, in project: Project) throws -> TestNode {
        return try process(objectLayer: tileLayer, from: layer, for: map, in: project)
    }
    
    func process(groupLayer: TestNode, from layer: LayerProtocol, for map: Map, in project: Project) throws -> TestNode {
        return try process(objectLayer: groupLayer, from: layer, for: map, in: project)
    }
}

struct TestObjectMapProcessor : ObjectPostProcessor, MapPostProcessor {
    typealias EngineType = TestEngine
    
    let property : String
    let value : PropertyValue
    
    init(_ property:String, value:PropertyValue){
        self.property = property
        self.value = value
    }
    
    func process(point: EngineType.PointObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.PointObjectType {
        var point = point
        point.properties[property] = value
        return point
    }
    
    func process(rectangle: EngineType.RectangleObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.RectangleObjectType {
        var rectangle = rectangle
        rectangle.properties[property] = value
        return rectangle
    }
    
    func process(ellipse: EngineType.EllipseObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.EllipseObjectType {
        var ellipse = ellipse

        ellipse.properties[property] = value

        return ellipse
    }
    
    func process(sprite: EngineType.SpriteType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.SpriteType {

        sprite.properties[property] = value
        return sprite
    }
    
    func process(text: EngineType.TextObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.TextObjectType {
        var text = text
        text.properties[property] = value
        return text
    }
    func process(polyline: EngineType.PolylineObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.PolylineObjectType {
        return try process(polygon: polyline, from: object, for: map, from: project)
    }
    
    func process(polygon: EngineType.PolylineObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.PolylineObjectType {
        var pologonal = polygon
        pologonal.properties[property] = value

        return pologonal
    }
    
    func process(engineMap: EngineType.MapType, for map: Map, from project: Project) throws -> EngineType.MapType {
        engineMap.properties[property] = value

        return engineMap
    }
    
}

enum TestProperties : String, TiledEngineBridgableProperty, CaseIterable {
    typealias EngineObjectType = TestSprite
    
    case shade, mass
    
    var tiledName: String {
        return rawValue
    }
    
    var tiledDefault: PropertyValue {
        switch  self {
        case .shade:
            return .color(.red)
        case .mass:
            return 10.0
        }
    }
    
    var engineObjectProperty: PartialKeyPath<TestSprite> {
        switch self {
        case .shade:
            return \TestSprite.color
        case .mass:
            return \TestSprite.weight
        }
    }
}

extension Float : ExpressibleAsTiledFloat {
    public static func instance(bridging value: Double) -> Float {
        return Float(value)
    }
}

extension UInt32 : ExpressibleAsTiledColor {
    public static func instance(bridging color: Color) -> UInt32 {
       return UInt32(color.alpha) << 24 | UInt32(color.blue) << 16 | UInt32(color.green) << 8 | UInt32(color.red)
    }
}
