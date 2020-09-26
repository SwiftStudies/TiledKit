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

public class TKTileSet {
    public let name : String
    public let tileSize : PixelSize
    public let properties : Properties

    private var tiles = [UInt32:Tile]()
    public  var count : Int {
        return tiles.count
    }

    public init(name:String, tileSize : PixelSize, properties:Properties){
        self.name = name
        self.tileSize = tileSize
        self.properties = properties
    }
    
    public subscript(_ tileId:UInt32)->Tile? {
        get {
            return tiles[tileId]
        }
        
        set {
            tiles[tileId] = newValue
        }
    }
}

public struct TKTileSetReference {
    public let firstGid : UInt32
    public let tileSet : TKTileSet
}
