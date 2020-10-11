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

/// The entry point for any game engine specialization. See [Game Engine Specialization](../../Game%20Engine%20Specialization.md)
public protocol Engine {
    /// The most common lossless way of expressing a float in the engine
    associatedtype FloatType : ExpressibleAsTiledFloat
    
    /// The type that captures `Color`s in the engine
    associatedtype ColorType : ExpressibleAsTiledColor
    
    /// The type that represents a `Map` in the engine
    associatedtype MapType   : EngineMap
    
    
    /// Provide a default specialized map creator for the Engine
    /// - Parameter map: The `Map` to create it for
    static func make(engineMapForTiled map:Map) throws -> MapType
}

internal struct AnyEngineMapFactory<EngineType:Engine> : EngineMapFactory {
    
    let wrappedFactory : (_ map:Map, _ project:Project) throws -> EngineType.MapType?
    
    init<F:EngineMapFactory>(wrap factory:F) where F.EngineType == EngineType {
        wrappedFactory = factory.make
    }
    
    func make<EngineMapType>(from map: Map, in project: Project) throws -> EngineMapType? where EngineMapType : EngineMap {
        return try wrappedFactory(map,project) as? EngineMapType
    }
}

fileprivate struct Factories {
    static var factories = [Any]()
    
    static func get<T>()->[T] {
        return factories.compactMap({
            $0 as? T
        })
    }
}

/// Provides common diagnostic capabilites to any engine specialization
public extension Engine {

    /// Add a new factory to the factories for the `Engine`, new factories are tried first
    /// - Parameter factory: The new factory
    static func register<F:EngineMapFactory>(factory:F) where F.EngineType == Self {
            Factories.factories.insert(AnyEngineMapFactory<Self>(wrap:factory), at: 0)
    }
    
    static func removeAllFactories() {
        Factories.factories.removeAll()
    }
    
    /// Returns all engine map factories registered
    /// - Returns: The available map factories for this engine
    internal static func engineMapFactories() -> [AnyEngineMapFactory<Self>] {
        return  Factories.get()
        
        
    }
        
    static func warn(_ message:String){
        print("Warning: \(message)")
    }
}
