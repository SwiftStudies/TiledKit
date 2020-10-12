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

/// Tile factories create the sprites that will be rendered for tiles
public protocol TileFactory : Factory {
    
    /// Make a new sprite to represent the tile
    /// - Parameters:
    ///   - tile: The `Tile` the sprite should represent
    ///   - tileset: The `TileSet` the tile is from
    ///   - texture: The texture or bitmap that is or contains the grahics for the sprite
    ///   - project: The project it is being loaded from
    func make(spriteFor tile:Tile, in tileset:TileSet, with texture:EngineType.TextureType, from project:Project) throws ->EngineType.SpriteType?

}

/// Adds support for `EngineMapFactories` to `Engine`
public extension Engine {

    /// Add a new factory to the factories for the `Engine`, new factories are tried first
    /// - Parameter factory: The new factory
    static func register<F:TileFactory>(factory:F) where F.EngineType == Self {
        EngineRegistry.insert(
            for: Self.self,
            object: AnyTileFactory<Self>(wrap:factory)
        )
    }
    
    /// Returns all engine tile factories registered
    /// - Returns: The available tile factories for this engine
    internal static func tileFactories() -> [AnyTileFactory<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}


internal struct AnyTileFactory<EngineType:Engine> : TileFactory {
    let wrappedFactory : (_ tile:Tile, _ tileset:TileSet, _ texture: EngineType.TextureType, _ project : Project) throws -> EngineType.SpriteType?
    
    init<F:TileFactory>(wrap factory:F) where F.EngineType == EngineType {
        wrappedFactory = factory.make
    }
    
    func make(spriteFor tile: Tile, in tileset: TileSet, with texture: EngineType.TextureType, from project: Project) throws -> EngineType.SpriteType? {
        return try wrappedFactory(tile, tileset, texture, project)
    }
    
}
