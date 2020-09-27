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

/// Captures if and how a `Tile` should be rendered
public struct TileFlip : OptionSet {
    /// As specied in the Tiled TMX format, a tile gid is a 32-bit unsigned integer
    public typealias RawValue = UInt32

    /// The raw value that could be OR'd with a tile id to get the full `TileGID`
    public var rawValue: UInt32
    
    /// Creates a new instance with the specified value
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// Include if the tile should be flipped horizontally
    public static let horizontally : UInt32 = 0x80000000
    
    /// Include if the tile should be flipped vertically
    public static let vertically : UInt32    = 0x40000000
    
    /// Include if the tile should be flipped diagnoally
    public static let diagonally : UInt32    = 0x20000000
}

/// Represents the reference to a specific `Tile` in a tile `Layer` for a given `Map`. It captures not only an identifier uniquely identifying the `Tile` (and the `TileSet` it is in) but also if the `Tile` should be flipped (see `TileFlip`)
public struct TileGID : ExpressibleByIntegerLiteral, Equatable {
    public typealias IntegerLiteralType = UInt32
    
    private static let tileIdMask : UInt32    = ~(TileFlip.horizontally | TileFlip.vertically | TileFlip.diagonally)

    let value : UInt32
    
    /// The gobal tile offset which uniquely identifies the `Tile` for a given `Map`
    public var globalTileOffset : UInt32 {
        return value & TileGID.tileIdMask
    }
    
    fileprivate init(_ rawValue:UInt32){
        value = rawValue
    }
    
    /// Create a new instance with the given raw value, note that unless you are creating a customized `ResourceLoader` you will not need this.
    /// - Parameter value: The raw value (see TMX format description in the Tiled documentation)
    public init(integerLiteral value: UInt32) {
        self.value = value
    }
    
    /// Creates a new instance for the supplied `Map` `globalTileOffset`
    /// - Parameters:
    ///   - tileId: The id of the tile in the set of `TileSet`s for a `Map`
    ///   - flip: Any transformations that should be applied
    public init(tileId:UInt32, flip:TileFlip){
        value = tileId | flip.rawValue
    }
    
    /// `true` if the tile should be flipped horizontally
    public var flipHorizontally : Bool {
        return value & TileFlip.horizontally != 0
    }

    /// `true` if the tile should be flipped vertically
    public var flipVertically : Bool {
        return value & TileFlip.vertically != 0
    }

    /// `true` if the tile should be flipped diagonally
    public var flipDiagonally : Bool {
        return value & TileFlip.diagonally != 0
    }

}

extension UInt32 {
    var tileGID : TileGID {
        return TileGID(self)
    }
}
