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

/// A `TileSet` represents a Tiled tile set, most typically loaded as part of loading a `Map`.
public class TileSet : Loadable, MutablePropertied {
    /// The name of the `TileSet`
    public let name : String
    
    /// The size in pixels of a `Tile`. Note that individual `Tile`s may differ in size but this size will be used as an assumption
    public let tileSize : PixelSize
    
    /// The user specified `Properties` of the `TileSet`
    public var properties : Properties

    private var tiles = [UInt32:Tile]()
    
    /// The number of tiles in the `TileSet`
    public  var count : Int {
        return tiles.count
    }

    
    /// Creates a new instance of the a `TileSet`
    /// - Parameters:
    ///   - name: The name of the `TileSet`
    ///   - tileSize: The size of the `Tile`s in the `TileSet`
    ///   - properties: Any user specified `Properties`
    public init(name:String, tileSize : PixelSize, properties:Properties){
        self.name = name
        self.tileSize = tileSize
        self.properties = properties
    }
    
    /// Returns the local id of the tile (outside of the context of a map) of a given tile
    /// - Parameter tile: The tile
    /// - Returns: `nil` if the `Tile` is 
    public func localId(of tile:Tile)->UInt32? {
        for (index,setTile) in tiles {
            if tile == setTile {
                return index
            }
        }
        return nil
    }
    
    /// Retreives the `Tile` specified by the index from the `TileSet`
    /// - Parameters:
    ///   - tileId: The index of the `Tile` starting at 0
    /// - returns: The `Tile` or `nil` if no `Tile` with the specified `id` exists
    public subscript(_ tileId:UInt32)->Tile? {
        get {
            return tiles[tileId]
        }
        
        set {
            tiles[tileId] = newValue
        }
    }
    
    /// Creates and returns an instance of `TileSetLoader` which will load tilesets from Tiled tsx files
    /// - Parameter project: The project the `TileSet` will be loaded connected to
    /// - Returns: An instance of `TileSetLoader`
    public static func loader(for project: Project) -> ResourceLoader {
        return TileSetLoader(project: project)
    }
    
    /// Maps should be cached, as they are value types a new instance is created anyway so there will not be unintended side effects
    public let cache = true
    
    
    /// A `TileSet` should be the same across all `Map`s in a project so no deep copy is done
    /// - Returns: `self`
    public func newInstance() -> Self {
        return self
    }
}

/// `TileSet`s are referenced by `Map`s, and all tile `Layer`s reference a specific `Tile` and `TileSet` by using a `TileGID`.  The `TileSetReference` type
/// captures both the first `TileGID` of a `TileSet` referenced by a `Map`, as well as the `TileSet` itself. 
public struct TileSetReference {
    public let firstGid : UInt32
    public let tileSet : TileSet
}
