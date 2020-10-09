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

class TestEngine : Engine {
    typealias FloatType = Float
    typealias ColorType = UInt32
}

class TestSprite : EngineObject {
    typealias EngineType = TestEngine
    
    var color : UInt32 = 0
    var weight : Float = 100.0
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
}

extension UInt32 : ExpressibleAsTiledColor {
    public init(_ from: Color) {
        self = UInt32(from.alpha) << 24 | UInt32(from.blue) << 16 | UInt32(from.green) << 8 | UInt32(from.red)
    }
}

final class EngineTests: XCTestCase {
        
    func testBridgeAblePropertyApplication(){
        let sprite = TestSprite()
        
        XCTAssertEqual(sprite.color, 0)
        XCTAssertEqual(sprite.weight, 100)
        
        TestProperties.mass.apply(to: sprite, TestProperties.mass.tiledDefault)
        XCTAssertEqual(sprite.weight, 10)

        TestProperties.shade.apply(to: sprite, TestProperties.shade.tiledDefault)
        XCTAssertEqual(sprite.color, UInt32(Color.red))
    }
    
    static var allTests = [
        ("testBridgeAblePropertyApplication", testBridgeAblePropertyApplication),
        ]
}

