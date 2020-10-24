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

public protocol LayerFactory : Producer {
    /// Creates a sprite for the supplied image layer
    /// - Parameters:
    ///   - imageReference: The file reference to the image
    ///   - layer: The additional data from the layer
    ///   - map: The map the layer is part of
    ///   - project: The project the map is being loaded from
    func make(spriteFor imageReference:ImageReference, for layer:LayerProtocol, in map:Map, from project:Project) throws -> EngineType.SpriteType?
    
    /// Creates a layer to contain objects
    /// - Parameters:
    ///   - layer: The additional data from the layer
    ///   - map: The map the layer is part of
    ///   - project: The project the map is being loaded from
    func make(objectContainerFor layer:LayerProtocol,in map:Map, from project:Project) throws -> EngineType.ObjectLayerType?
    
    /// Creates a layer containing other layers
    /// - Parameters:
    ///   - layer: The details of the grouping layer
    ///   - map: The `Map` the layer belongs to
    ///   - project: The project the map is being loaded from
    func make(groupFor layer:LayerProtocol,in map:Map, from project:Project) throws -> EngineType.GroupLayerType?
    
    /// Creates a tile layer with the supplied tiles in using the sprites loaded during map building
    /// - Parameters:
    ///   - layer: The meta data about the layer
    ///   - sprites: The sprites (indexed by gid) that can be used
    ///   - map: The map the layer is in
    ///   - project: The project the layer is loaded from
    func make(tileLayerFor layer:LayerProtocol, with sprites:MapTiles<EngineType>, in map:Map, from project:Project) throws -> EngineType.TileLayerType?
    
    /// Called for each tile in a tile layer. The position in the layer is supplied in Tiled coordinates
    /// - Parameters:
    ///   - tile: A new instance of the tile representation in your specific game engine
    ///   - position: The location, in tiled coordinates, to position the tile at
    ///   - tileLayer: The tile layer containing the tile
    ///   - map: The map containing the tile layer
    ///   - project: The project containing the map
    func make(tileWith tileGid:TileGID, definedBy tile:Tile, and tilset:TileSet, at position:Position, with sprites:MapTiles<EngineType>, for tileLayer:LayerProtocol, in map:Map, from project:Project) throws -> EngineType.SpriteType?
}

/// Adds support for `LayerFactories` to `Engine`
public extension Engine {
    /// Returns all engine tile factories registered
    /// - Returns: The available tile factories for this engine
    internal static func layerFactories() -> [AnyLayerFactory<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}


internal struct AnyLayerFactory<EngineType:Engine> : LayerFactory {
    let imageLayerFactory : (_ imageReference:ImageReference, _ layer:LayerProtocol, _ map:Map, _ project:Project) throws -> EngineType.SpriteType?
    let objectLayerFactory : (_ layer:LayerProtocol, _ map:Map, _ project:Project) throws -> EngineType.ObjectLayerType?
    let groupLayerFactory : (_ layer:LayerProtocol, _ map:Map, _ project:Project) throws -> EngineType.GroupLayerType?
    let tileLayerFactory : (_ layer: LayerProtocol, _ sprites: MapTiles<EngineType>, _ map: Map, _ project: Project) throws -> EngineType.TileLayerType?
    let tileInstanceFactory : (_ tileGid: TileGID, _ tile: Tile, _ tilset: TileSet, _ position: Position, _ sprites: MapTiles<EngineType>, _ tileLayer: LayerProtocol, _ map: Map, _ project: Project) throws -> EngineType.SpriteType?
    
    init<F:LayerFactory>(wrap factory:F) where F.EngineType == EngineType {
        imageLayerFactory = factory.make
        objectLayerFactory = factory.make
        groupLayerFactory = factory.make
        tileLayerFactory = factory.make
        tileInstanceFactory = factory.make
    }

    func make(tileLayerFor layer: LayerProtocol, with sprites: MapTiles<EngineType>, in map: Map, from project: Project) throws -> EngineType.TileLayerType? {
        return try tileLayerFactory(layer,sprites,map,project)
    }
    
    func make(tileWith tileGid: TileGID, definedBy tile: Tile, and tilset: TileSet, at position: Position, with sprites: MapTiles<EngineType>, for tileLayer: LayerProtocol, in map: Map, from project: Project) throws -> EngineType.SpriteType? {
        return try tileInstanceFactory(tileGid,tile, tilset, position, sprites, tileLayer, map, project)
    }
    
    func make(spriteFor imageReference: ImageReference, for layer: LayerProtocol, in map: Map, from project: Project) throws -> EngineType.SpriteType? {
        return try imageLayerFactory(imageReference, layer, map, project)
    }
    
    func make(objectContainerFor layer: LayerProtocol, in map: Map, from project: Project) throws -> EngineType.ObjectLayerType? {
        return try objectLayerFactory(layer, map, project)
    }
    
    func make(groupFor layer: LayerProtocol, in map: Map, from project: Project) throws -> EngineType.GroupLayerType? {
        return try groupLayerFactory(layer, map, project)
    }
}
