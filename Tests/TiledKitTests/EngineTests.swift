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

import XCTest
@testable import TiledKit
import TiledResources

final class EngineTests: XCTestCase {

    
    func testProductionRegistration(){
        struct SomeMapFactory : MapPostProcessor, MapFactory {
            typealias EngineType = TestEngine
            
            func process(engineMap specializedMap: EngineType.MapType, for map: Map, from project: Project) throws -> EngineType.MapType {
                return specializedMap
            }
            func make(mapFor map: Map, in project: Project) throws -> EngineType.MapType? {
                return nil
            }
        }
        
        TestEngine.removeProducers()
        
        XCTAssertFalse(TestEngine.hasProducers)

        TestEngine.register(producer: SomeMapFactory())

        XCTAssertTrue(TestEngine.hasProducers)
        
        XCTAssertEqual(TestEngine.engineMapFactories().count, 1)
        XCTAssertEqual(TestEngine.engineMapPostProcessors().count, 1)

        TestEngine.register(producer: TestObjectMapProcessor("ObjectMapProcessor", value: true))
        
        XCTAssertEqual(TestEngine.engineMapPostProcessors().count, 2)
        XCTAssertEqual(TestEngine.engineObjectPostProcessors().count, 1)
    }
    
    func testMapLoading(){
        let testMap : TestMap
        let originalMap : Map
        do {
            testMap = try TiledResources.GenericTiledProject.Maps.testMap1.loadMap(for: TestEngine.self)
            originalMap = try TiledResources.GenericTiledProject.Maps.testMap1.loadMap()
        } catch {
            return XCTFail("\(error)")
        }
        
        XCTAssertEqual(testMap.size, originalMap.pixelSize)
        XCTAssertEqual(testMap.falseByDefault, false)
        XCTAssertEqual(testMap.lifeTheUniverseAndEverything, 0)

        XCTAssertEqual(TestEngine.engineMapFactories().count, 0)
        XCTAssertEqual(TestEngine.engineMapPostProcessors().count, 0)
        TestEngine.register(producer: TestMapFactory())
        TestEngine.register(producer: TestMapPostProcessor())
        TestEngine.register(producer: TestTilePostProcessor())
        TestEngine.register(producer: TestMultiProcessor())
        XCTAssertEqual(TestEngine.engineLayerPostProcessors().count, 1)
        XCTAssertEqual(TestEngine.engineMapFactories().count, 1)
        XCTAssertEqual(TestEngine.engineMapPostProcessors().count, 2)

        XCTAssertEqual(TestEngine.createdSprites.count, 32)
        XCTAssertEqual(TestEngine.createdSprites.filter(\.postProcessed).count, TestEngine.createdSprites.count)
        
        // Reset sprite count
        TestEngine.createdSprites.removeAll()
        guard let customMap : TestMap = try? TiledResources.GenericTiledProject.Maps.testMap1.loadMap(for: TestEngine.self) else {
            TestEngine.removeProducers()
            return XCTFail("Could not load custom map")
        }
        
        XCTAssertEqual(customMap.size, PixelSize(width: 1, height: 1))
        XCTAssertEqual(customMap.falseByDefault, true)
        XCTAssertEqual(customMap.lifeTheUniverseAndEverything, 42)
        XCTAssertEqual(customMap.userData["multiProcessed"] as? Bool, true)
        XCTAssertEqual(TestEngine.createdSprites.count, 32)
        XCTAssertEqual(TestEngine.createdSprites.filter(\.postProcessed).count, 0)

        
        TestEngine.removeProducers()
        XCTAssertEqual(TestEngine.engineMapFactories().count, 0)
        
    }

    func testRenderingOrder(){
        let map = Map(with: TileGridSize(width: 2, height: 2), and: PixelSize(width: 16, height: 8), orientation: .isometric, renderingOrder: .rightDown)
        
        let rightDown = [
            TileGridPosition(x: 0, y: 0),
            TileGridPosition(x: 1, y: 0),
            TileGridPosition(x: 0, y: 1),
            TileGridPosition(x: 1, y: 1),
        ]

        let rightUp = [
            TileGridPosition(x: 0, y: 1),
            TileGridPosition(x: 1, y: 1),
            TileGridPosition(x: 0, y: 0),
            TileGridPosition(x: 1, y: 0),
        ]

        let leftDown = [
            TileGridPosition(x: 1, y: 0),
            TileGridPosition(x: 0, y: 0),
            TileGridPosition(x: 1, y: 1),
            TileGridPosition(x: 0, y: 1),
        ]

        let leftUp = [
            TileGridPosition(x: 1, y: 1),
            TileGridPosition(x: 0, y: 1),
            TileGridPosition(x: 1, y: 0),
            TileGridPosition(x: 0, y: 0),
        ]

        
        do {
            var i = 0
            for gridPosition in try RenderingOrder.rightDown.tileSequence(for: map) {
                XCTAssertEqual(gridPosition, rightDown[i])
                
                i+=1
            }
            i = 0
            for gridPosition in try RenderingOrder.rightUp.tileSequence(for: map) {
                XCTAssertEqual(gridPosition, rightUp[i])
                
                i+=1
            }
            i=0
            for gridPosition in try RenderingOrder.leftDown.tileSequence(for: map) {
                XCTAssertEqual(gridPosition, leftDown[i])
                
                i+=1
            }
            i=0
            for gridPosition in try RenderingOrder.leftUp.tileSequence(for: map) {
                XCTAssertEqual(gridPosition, leftUp[i])
                
                i+=1
            }

        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testIsometricLayout(){
        let map = Map(with: TileGridSize(width: 2, height: 2), and: PixelSize(width: 16, height: 8), orientation: .isometric, renderingOrder: .rightDown)
        
        let expectedResults = [
            Position(x: 8, y: 0),
            Position(x: 16, y: 4),
            Position(x: 0, y: 4),
            Position(x: 8, y: 8),
        ]
        
        do {
            var i = 0
            for gridPosition in try RenderingOrder.rightDown.tileSequence(for: map) {
                let result = try Orientation.isometric.position(for: gridPosition, in: map)
                XCTAssertEqual(expectedResults[i], result)
                i += 1
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    
    func testMapProcessing(){
        XCTAssertEqual(try TiledResources.GenericTiledProject.Maps.testMap1.loadMap(for: TestEngine.self).userData["processedBy"] as? String, "TestEngine")
        
        struct CustomMapProcessor : MapPostProcessor {
            typealias EngineType = TestEngine

            func process(engineMap: EngineType.MapType, for map: Map, from project: Project) throws -> EngineType.MapType {
                engineMap.userData["processedBy"] = "CustomMapProcessor"
                
                return engineMap
            }
        }
        
        TestEngine.register(producer: CustomMapProcessor())
        
        XCTAssertEqual(try TiledResources.GenericTiledProject.Maps.testMap1.loadMap(for: TestEngine.self).userData["processedBy"] as? String, "CustomMapProcessor")
    }
    
    func testBridgeAblePropertyApplication(){
        let sprite = TestSprite()
        
        XCTAssertEqual(sprite.color, 0)
        XCTAssertEqual(sprite.weight, 100)
        
        TestProperties.mass.apply(to: sprite, TestProperties.mass.tiledDefault)
        XCTAssertEqual(sprite.weight, 10)

        TestProperties.shade.apply(to: sprite, TestProperties.shade.tiledDefault)
        XCTAssertEqual(sprite.color, UInt32.instance(bridging: Color.red))
    }
    
    static var allTests = [
        ("testMapLoading", testMapLoading),
        ("testBridgeAblePropertyApplication", testBridgeAblePropertyApplication),
        ]
}

