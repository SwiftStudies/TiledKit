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

import TKXMLCoding

/// Represents a two dimensional grid of tiles (such as that in a tile `Layer`
public struct TileGrid {
    private let    grid : [TileGID]
    
    /// The size of the grid (in tiles)
    public  let    size : TileGridSize
    
    
    /// Retreives a `TileGID` for the `Tile` at the specied location
    /// - Parameters:
    ///   - x: The x position
    ///   - y: The y position
    /// - returns: The `TileGID` of the specified tile
    public subscript(_ x:Int, _ y:Int)->TileGID {
        return grid[x+y*size.width]
    }
    
    /// Creates a new `TileGrid` using the supplied array of `TileGID`s
    /// - Parameters:
    ///   - grid: The `TileGID`s to use. There should be size.width * size.height elements
    ///   - size: The `Dimension`s of the grid
    public init(_ grid:[TileGID], size:TileGridSize){
        self.grid = grid
        self.size = size
    }
}

extension TMXTileLayer {
    func tileGrid(for map:Map)->TileGrid {
        return TileGrid(data.map({$0.tileGID}), size: map.mapSize)
    }
}
