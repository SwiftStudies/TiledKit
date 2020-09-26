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
import TKXMLCoding

enum MapError : Error {
    case unknownMapType(String)
}

/// Represents a Tiled map which can be loaded from a Tiled `tmx` file (other Tiled formats can be supported in the future, such as JSON). It contains the root collection of `Layer`s as well as carrying the references to the `TileSet`s used by the `Map`
public struct Map : LayerContainer, Loadable{
    /// The url the map was loaded from (if any)
    internal let  url              : URL?
    
    /// The size of the map in tiles
    public let    mapSize          : TileGridSize
    
    /// The size of a tile in pixels
    public let    tileSize         : PixelSize
    
    /// Properties of the map
    public var    properties       = Properties()
    
    /// The size of the map in pixels
    public var    pixelSize        : PixelSize {
        return PixelSize(width: tileSize.width * mapSize.width, height: tileSize.height * mapSize.height)
    }
    
    /// The orientation of the map
    public var    orientation      : Orientation

    /// The rendering order the map was designed in
    public var    renderingOrder   : RenderingOrder

    /// The various layers in the map
    public var    layers          = [Layer]()
    
    /// The tilesets used by the project
    internal var    tileSetReferences  = [TileSetReference]()
    
    /// Retreive a tile based on its `TileGID`
    public subscript(_ tile:TileGID)->Tile? {
        let tileSetTileId = tile.globalTileOffset
        
        for tileSetReference in tileSetReferences.reversed() {
            if tileSetReference.firstGid <= tile.globalTileOffset {
                return tileSetReference.tileSet[tileSetTileId - tileSetReference.firstGid]
            }
        }
        
        return nil
    }
    
    
    /// Creates and returns an instance of `MapLoader` which will load maps from Tiled tmx files
    /// - Parameter project: The project the `Map` will be loaded into
    /// - Returns: An instance of `MapLoader`
    public static func loader(for project: Project) -> ResourceLoader {
        return MapLoader(project: project)
    }
    
    /// Maps should be cached, as they are value types a new instance is created anyway so there will not be unintended side effects
    public let cache = true
    
    
    /// Returns `self` as it is a value type
    /// - Returns: This value
    public func newInstance() -> Map {
        return self
    }
}
