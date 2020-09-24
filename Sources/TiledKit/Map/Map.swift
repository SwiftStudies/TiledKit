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

enum MapError : Error {
    case unknownMapType(String)
}

public struct Map : TKLayerContainer{
    internal let  url              : URL?
    
    /// The size of the map in tiles
    public let    mapSize          : TileSize
    
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
    public var    layers          = [TKLayer]()
    
}
