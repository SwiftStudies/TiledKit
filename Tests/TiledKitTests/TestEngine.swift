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

class TestEngine : Engine {
    typealias EngineType = TestEngine
    
    typealias FloatType = Float
    typealias ColorType = UInt32
    typealias MapType = TestMap
    
    
    static func make(engineMapForTiled map: Map) throws -> TestMap {
        return TestMap(size:map.pixelSize)
    }
}

class TestNode : EngineObject {
    typealias EngineType = TestEngine

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
        BridgedProperties.allCases.apply(map.properties, to: specializedMap)
        return specializedMap
    }
}

class TestSprite : TestNode {
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
    public static func instance(bridging value: Double) -> Float {
        return Float(value)
    }
}

extension UInt32 : ExpressibleAsTiledColor {
    public static func instance(bridging color: Color) -> UInt32 {
       return UInt32(color.alpha) << 24 | UInt32(color.blue) << 16 | UInt32(color.green) << 8 | UInt32(color.red)
    }
}
