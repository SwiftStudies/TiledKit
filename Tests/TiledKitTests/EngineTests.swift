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

final class EngineTests: XCTestCase {
    lazy var moduleBundleProject : Project = {
        Project(using: Bundle.module)
    }()
    
    func testMapLoading(){
        let testMap : TestMap
        let originalMap : Map
        do {
            testMap = try moduleBundleProject.retrieve(specializedMap: "Test Map 1", in: "Maps")
            originalMap = try moduleBundleProject.retrieve(map: "Test Map 1", in: "Maps")
        } catch {
            return XCTFail("\(error)")
        }
        
        XCTAssertEqual(testMap.size, originalMap.pixelSize)
        XCTAssertEqual(testMap.falseByDefault, false)
        XCTAssertEqual(testMap.lifeTheUniverseAndEverything, 0)

        XCTAssertEqual(TestEngine.engineMapFactories().count, 0)
        XCTAssertEqual(TestEngine.engineMapPostProcessors().count, 0)
        TestEngine.register(factory: TestMapFactory())
        TestEngine.register(postProcessor: TestMapPostProcessor())
        TestEngine.register(postProcessor: TestTilePostProcessor())
        XCTAssertEqual(TestEngine.engineMapFactories().count, 1)
        XCTAssertEqual(TestEngine.engineMapPostProcessors().count, 1)

        XCTAssertEqual(TestEngine.createdSprites.count, 5)
        XCTAssertEqual(TestEngine.createdSprites.filter(\.postProcessed).count, TestEngine.createdSprites.count)
        
        // Reset sprite count
        TestEngine.createdSprites.removeAll()
        guard let customMap : TestMap = try? moduleBundleProject.retrieve(specializedMap:"Test Map 1", in:"Maps") else {
            TestEngine.removeAllFactoriesAndPostProcessors()
            return XCTFail("Could not load custom map")
        }
        
        XCTAssertEqual(customMap.size, PixelSize(width: 1, height: 1))
        XCTAssertEqual(customMap.falseByDefault, true)
        XCTAssertEqual(customMap.lifeTheUniverseAndEverything, 42)
        XCTAssertEqual(TestEngine.createdSprites.count, 5)
        XCTAssertEqual(TestEngine.createdSprites.filter(\.postProcessed).count, 0)

        
        TestEngine.removeAllFactoriesAndPostProcessors()
        XCTAssertEqual(TestEngine.engineMapFactories().count, 0)
        
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

