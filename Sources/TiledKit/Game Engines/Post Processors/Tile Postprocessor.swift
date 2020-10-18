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
public protocol TilePostProcessor : PostProcessor {
    
    
    /// Enables post processing of tiles which is performed after all tiles for a tileset have been created by factories and enables
    /// any specialization or other work that requires other tiles to have been loaded
    /// - Parameters:
    ///   - sprite: The previously created `SpriteType`
    ///   - tile: The `Tile` it was created from
    ///   - tileSet: The `TileSet` the tile belongs to
    ///   - setSprites: All other sprites created for the `TileSet`
    ///   - map: The map the `TileSet`s were loaded from
    ///   - project: The project the `Map`& `TileSet` was loaded from
    func process(_ sprite:EngineType.SpriteType, from tile:Tile, in tileSet:TileSet, with setSprites:[UInt32:EngineType.SpriteType], for map:Map, from project:Project) throws ->EngineType.SpriteType
}

/// Adds support for `TilePostProcessor`s  to `Engine`
public extension Engine {
    
    /// Returns all engine map factories registered
    /// - Returns: The available tile post processors for this engine
    internal static func engineTilePostProcessors() -> [AnyTilePostProcessor<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}

internal struct AnyTilePostProcessor<EngineType:Engine> : TilePostProcessor {
    let wrapped : (_ sprite: EngineType.SpriteType, _ tile: Tile, _ tileSet: TileSet, _ setSprites: [UInt32 : EngineType.SpriteType], _ map: Map, _ project: Project) throws -> EngineType.SpriteType

    init<F:TilePostProcessor>(wrap factory:F) where F.EngineType == EngineType {
        wrapped = factory.process
    }
    
    func process(_ sprite: EngineType.SpriteType, from tile: Tile, in tileSet: TileSet, with setSprites: [UInt32 : EngineType.SpriteType], for map: Map, from project: Project) throws -> EngineType.SpriteType {
        return try wrapped(sprite, tile, tileSet, setSprites, map, project)
    }
}
