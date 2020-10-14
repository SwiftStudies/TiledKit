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
    
    static func make(engineMapForTiled map: Map) throws -> TestMap {
        return TestMap(size:map.pixelSize)
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
    
    static func postProcess(_ sprite: TestSprite, from tile: Tile, in tileSet: TileSet, with setSprites: [UInt32 : TestSprite], for map: Map, from project: Project) throws -> TestSprite {
        sprite.postProcessed = true
      return sprite
    }
    
    static func makeSpriteFrom(_ texture: TestTexture, for layer: LayerProtocol, in map: Map, from project: Project) throws -> TestSprite? {
        return TestSprite()
    }
    
    static func makeObjectContainer(_ layer: LayerProtocol, in map: Map, from project: Project) throws -> TestNode? {
        return TestNode()
    }
    
    static func makeGroupLayer(_ layer: LayerProtocol, in map: Map, from project: Project) throws -> TestNode? {
        return TestNode()
    }
    
    static func makeTileLayerFrom(_ tileGrid: TileGrid, for layer: LayerProtocol, with sprites: MapTiles<TestEngine>, in map: Map, from project: Project) throws -> TestNode? {
        return TestNode()
    }
    
    static func postProcess(_ objectLayer: TestNode, from layer: LayerProtocol, for map: Map, in project: Project) throws -> TestNode {
        return objectLayer
    }
    
    
    static func postProcess(_ imageLayer: TestSprite, from layer: LayerProtocol, for map: Map, in project: Project) throws -> TestSprite {
        return imageLayer
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
}

struct TestPoint : EngineObject {
    typealias EngineType = TestEngine
}

struct TestRectangle : EngineObject {
     typealias EngineType = TestEngine

}

struct TestEllipse : EngineObject {
    typealias EngineType = TestEngine

}

struct TestText : EngineObject {
    typealias EngineType = TestEngine

}

struct TestPologonal : EngineObject {
    typealias EngineType = TestEngine

}

public enum TestError : Error {
    case couldNotCreateTexture(URL)
}

class TestTexture : EngineTexture {
    typealias EngineType = TestEngine
    
    var originatingUrl : URL
    
    init(from url:URL){
        originatingUrl = url
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

class TestNode : EngineLayerContainer, EngineObjectContainer {
    typealias EngineType = TestEngine

    var children = [Any]()
    
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

struct TestMapFactory : EngineMapFactory {
    
    typealias EngineType = TestEngine

    func make(from map: Map, in project: Project) throws -> TestMap? {
        return TestMap(size: PixelSize(width: 1, height: 1))
    }
}

struct TestTilePostProcessor : TilePostProcessor {
    typealias EngineType = TestEngine
    
    
    func process(_ sprite: EngineType.SpriteType, from tile: Tile, in tileSet: TileSet, with setSprites: [UInt32 : EngineType.SpriteType], for map: Map, from project: Project) throws -> EngineType.SpriteType {
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
    
    func process(_ specializedMap: EngineType.MapType, for map: Map, from project: Project) throws -> EngineType.MapType {
        BridgedProperties.apply(map.properties, to: specializedMap)
        return specializedMap
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
