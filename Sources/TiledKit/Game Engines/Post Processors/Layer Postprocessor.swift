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

/// A specialized form of a `PostProcessor` that applies to `Tile`s. It is called after the first factory
/// has created the specialized sprite for the tile
public protocol LayerPostProcessor : Producer {
    
    /// Perfforms post processing on an object layer after creation
    /// - Parameters:
    ///   - objectLayer: The object layer
    ///   - layer: The original tiled layer meta data
    ///   - map: The map the layer is in
    ///   - project: The project the map was loaded from
    func process(_ objectLayer:EngineType.ObjectLayerType, from layer:LayerProtocol, for map:Map, in project:Project) throws -> EngineType.ObjectLayerType

    /// Perfforms post processing on an tile layer after creation
    /// - Parameters:
    ///   - tileLayer: The tile layer
    ///   - layer: The original tiled layer meta data
    ///   - map: The map the layer is in
    ///   - project: The project the map was loaded from
    func process(_ tileLayer:EngineType.TileLayerType, from layer:LayerProtocol, for map:Map, in project:Project) throws -> EngineType.TileLayerType

    /// Perfforms post processing on an image layer after creation
    /// - Parameters:
    ///   - imageLayer: The sprite that was created
    ///   - layer: The original tiled layer meta data
    ///   - map: The map the layer is in
    ///   - project: The project the map was loaded from
    func process(_ imageLayer:EngineType.SpriteType, from layer:LayerProtocol, for map:Map, in project:Project) throws -> EngineType.SpriteType

    /// Perfforms post processing on an group layer after creation
    /// - Parameters:
    ///   - groupLayer: The group layer
    ///   - layer: The original tiled layer meta data
    ///   - map: The map the layer is in
    ///   - project: The project the map was loaded from
    func process(_ groupLayer:EngineType.GroupLayerType, from layer:LayerProtocol, for map:Map, in project:Project) throws -> EngineType.GroupLayerType
}

/// Adds support for `TilePostProcessor`s  to `Engine`
public extension Engine {
    
    /// Returns all engine map factories registered
    /// - Returns: The available tile post processors for this engine
    internal static func engineLayerPostProcessors() -> [AnyLayerPostProcessor<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}

internal struct AnyLayerPostProcessor<EngineType:Engine> : LayerPostProcessor {

    
    let objectLayerProcessor : (_ objectLayer: EngineType.ObjectLayerType, _ layer: LayerProtocol, _ map: Map, _ project: Project) throws -> EngineType.ObjectLayerType
    
    let tileLayerProcessor : (_ tileLayer: EngineType.TileLayerType, _ layer: LayerProtocol, _ map: Map, _ project: Project) throws -> EngineType.TileLayerType
    
    let imageLayerProcessor : (_ imageLayer: EngineType.SpriteType, _ layer: LayerProtocol, _ map: Map, _ project: Project) throws -> EngineType.SpriteType
    
    let groupLayerProcessor : (_ groupLayer: EngineType.GroupLayerType, _ layer: LayerProtocol, _ map: Map, _ project: Project) throws -> EngineType.GroupLayerType
    
    init<F:LayerPostProcessor>(wrap factory:F) where F.EngineType == EngineType {
        objectLayerProcessor = factory.process
        tileLayerProcessor = factory.process
        imageLayerProcessor = factory.process
        groupLayerProcessor = factory.process
    }
    
    func process(_ objectLayer: EngineType.ObjectLayerType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.ObjectLayerType {
        return try objectLayerProcessor(objectLayer, layer, map, project)
    }
    
    func process(_ tileLayer: EngineType.TileLayerType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.TileLayerType {
        return try tileLayerProcessor(tileLayer, layer, map, project)
    }
    
    func process(_ imageLayer: EngineType.SpriteType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.SpriteType {
        return try imageLayerProcessor(imageLayer, layer, map, project)
    }
    
    func process(_ groupLayer: EngineType.GroupLayerType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.GroupLayerType {
        return try groupLayerProcessor(groupLayer, layer, map, project)
    }
}
