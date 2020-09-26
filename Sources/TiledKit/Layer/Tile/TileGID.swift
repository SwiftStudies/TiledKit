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

public struct TileFlip : OptionSet {
    public typealias RawValue = UInt32

    public var rawValue: UInt32
    
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let horizontally : UInt32 = 0x80000000
    public static let vertically : UInt32    = 0x40000000
    public static let diagonally : UInt32    = 0x20000000
}

public struct TileGID : ExpressibleByIntegerLiteral, Equatable {
    public typealias IntegerLiteralType = UInt32
    
    private static let tileIdMask : UInt32    = ~(TileFlip.horizontally | TileFlip.vertically | TileFlip.diagonally)

    let value : UInt32
    var globalTileOffset : UInt32 {
        return value & TileGID.tileIdMask
    }
    
    fileprivate init(_ rawValue:UInt32){
        value = rawValue
    }
    
    public init(integerLiteral value: UInt32) {
        self.value = value
    }
    
    public init(tileId:UInt32, flip:TileFlip){
        value = tileId | flip.rawValue
    }
    
    public var flipHorizontally : Bool {
        return value & TileFlip.horizontally != 0
    }

    public var flipVertically : Bool {
        return value & TileFlip.vertically != 0
    }

    public var flipDiagonally : Bool {
        return value & TileFlip.diagonally != 0
    }

}

extension UInt32 {
    var tileGID : TileGID {
        return TileGID(self)
    }
}
