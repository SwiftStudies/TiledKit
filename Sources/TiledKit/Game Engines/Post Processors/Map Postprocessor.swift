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

/// A specialized form of a `PostProcessor` that applies to `Maps`. It is called after all `Layers`
/// and `Objects` have been made and processed
public protocol MapPostProcessor : PostProcessor {
    
    /// Enables you to post process a map, even creating a different instance of the specialized
    /// map for the engine. As it is called after all other contents have been specialized you can
    /// apply changes to everything within your specialized map
    /// - Parameters:
    ///   - specializedMap: The output of the factory, or previous post processor
    ///   - map: The original Tiled map
    ///   - project: The project the map was loaded from
    func process(_ specializedMap:EngineType.MapType, for map:Map, from project:Project) throws ->EngineType.MapType
}

/// Adds support for `MapPostProcessor`s  to `Engine`
public extension Engine {

    /// Returns all engine map factories registered
    /// - Returns: The available map post processsors for this engine
    internal static func engineMapPostProcessors() -> [AnyEngineMapPostProcessor<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}

internal struct AnyEngineMapPostProcessor<EngineType:Engine> : MapPostProcessor {
    let wrapped : (_ specializedMap: EngineType.MapType, _ map:Map, _ project:Project) throws -> EngineType.MapType

    init<F:MapPostProcessor>(wrap factory:F) where F.EngineType == EngineType {
        wrapped = factory.process
    }

    func process(_ specializedMap: EngineType.MapType, for map: Map, from project: Project) throws -> EngineType.MapType {
        return try wrapped(specializedMap, map, project)
    }
}
