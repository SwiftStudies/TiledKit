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


/// Factories are responsible for creating the specialized game engine objects. `Factory` itself is
/// simply a common base protocol
public protocol Factory {
    associatedtype  EngineType : Engine
}

/// A Factory responsible for creating an Engine Map
public protocol EngineMapFactory : Factory {
    
    /// A map factory is responsible for determining (for example looking at properites)
    /// if a special kind of map should be created. If the map type this factory makes
    /// is not applicable for the supplied `Map` then the factory can return nil, causing the
    /// next factory to be tried
    /// - Parameters:
    ///   - map: The `Map` being loaded
    ///   - project: The `Project` the map is being loaded from
    func make(from map:Map, in project:Project) throws -> EngineType.MapType?
}
