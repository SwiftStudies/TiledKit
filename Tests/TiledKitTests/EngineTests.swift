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
        
        XCTAssertEqual(TestEngine.engineMapFactories().count, 0)
        TestEngine.register(factory: TestMapFactory())
        XCTAssertEqual(TestEngine.engineMapFactories().count, 1)
        
        guard let customMap : TestMap = try? moduleBundleProject.retrieve(specializedMap:"Test Map 1", in:"Maps") else {
            TestEngine.removeAllFactoriesAndPostProcessors()
            return XCTFail("Could not load custom map")
        }
        
        XCTAssertEqual(customMap.size, PixelSize(width: 1, height: 1))
        
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

