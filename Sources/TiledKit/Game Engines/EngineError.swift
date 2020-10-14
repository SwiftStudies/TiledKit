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

/// The different errors that can be thrown
enum EngineError : Error {
    
    /// Thrown when the type of the map can't be created
    case unsupportedTypeWhenLoadingMap(desiredType:String, supportedType:String)

    /// Thrown when they type of the texture can't be created, or the texture can't be loaded
    case couldNotCreateTextureFrom(URL)

    /// `Tile` with the given id cannot be found in the containing `TileSet`
    case couldNotFindTileInTileSet(UInt32, tileSet:TileSet)

    /// The `Engine` specific sprite with the given id cannot be found for the `TileSet`
    case couldNotFindSpriteInTileSet(UInt32, tileSet:TileSet)

    /// When a tileGid can't be found in the engineloader's index of tiles
    case couldNotFindTileInMap(TileGID)
    
    /// Thrown if a function is not yet implemented
    case notImplemented
}
