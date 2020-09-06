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
import XMLCoder

class TileSetReference : Decodable{
    var identifier : Identifier? = nil
    let firstGID    : Int
    let file        : String
    
    init(with firstGid:Int, for tileSet:TileSet, in file:String){
        self.firstGID = firstGid
        identifier = Identifier(stringLiteral: tileSet.name)
        self.file = file
    }
    
    var tileSet : TileSet {
        return TileSetCache.tileSet(from: self)
    }
    
    enum CodingKeys : String, CodingKey {
        case firstGID = "firstgid", file = "source"
    }
}

public enum TileSetType {
    case files
    case sheet(tileSheet:TileSheet)
}

public struct TileSheet : Decodable {
    let imagePath : String
    let imageWidth : Int
    let imageHeight : Int
    let margin : Int
    let spacing : Int
    let tileCount : Int
    let transparentColor : Color
    let columns : Int
    
    
    private enum CodingKeys : String, CodingKey {
        case imageWidth = "width", imageHeight = "height", margin, spacing, tileCount="tilecount", transparentColor = "transparentcolor", columns, imagePath = "source", image = "image"
    }
    
    public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Required
        columns = try container.decode(Int.self, forKey: .columns)
        tileCount = try container.decode(Int.self, forKey: .tileCount)

        let imageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .image)
        
        imagePath = try imageContainer.decode(String.self, forKey: .imagePath)
        imageWidth = try imageContainer.decode(Int.self, forKey: .imageWidth)
        imageHeight = try imageContainer.decode(Int.self, forKey: .imageHeight)
        
        // Optional
        transparentColor = (try? container.decode(Color.self, forKey: .transparentColor)) ?? Color(r: 0, g: 0, b: 0, a: 0)
        margin = (try? container.decode(Int.self, forKey: .margin)) ?? 0
        spacing = (try? container.decode(Int.self, forKey: .spacing)) ?? 0
    }
    
    func createTiles(for tileSet:TileSet, with data:[Int:TileSet.Tile], in container:LayerContainer)->[Int:TileSet.Tile]{
        var tiles = [Int:TileSet.Tile]()

        for tileIndex in 0..<tileCount {
            let row     = tileIndex / columns
            let column  = tileIndex % columns
            
            let y = (row * tileSet.tileHeight) +
                (row * spacing) +
                ((row * 2 * margin ) + margin)
            let x = (column * tileSet.tileWidth) +
                (column * spacing) +
                ((column * 2 * margin ) + margin)
                    
            
            let newTile = TileSet.Tile(tileIndex, from: self, for: tileSet, at: (x,y), in: container)
            
            if let additionalTileData = data[tileIndex] {
                newTile.objects = additionalTileData.objects
            }
            
            tiles[tileIndex] = newTile
        }
        return tiles
    }
}

public struct TileSet : TiledDecodable{
    public var name : String
    public var tileWidth : Int
    public var tileHeight : Int
    public var tiles = [Int:Tile]()
    public var type : TileSetType
    
    public enum CodingKeys : String, CodingKey {
        case tiles = "tile"
        case tileWidth = "tilewidth"
        case tileHeight = "tileheight"
        case name
        case image
    }
    
    public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        name = try container.decode(String.self, forKey: .name)
        
        //Import to set the level context before decoding tiles as they can contain layers
        let level = Level()
        decoder.userInfo.levelDecodingContext().level = level
        
        // Create the tiles, we first need to determine if this is a
        // sheet type or a collection of images
        if container.contains(.image){
            let spec = try TileSheet(from: decoder)
            type = .sheet(tileSheet: spec)
            // Needed for layers and animations etc
            let tilesData = try container.decode([Int:Tile].self, forKey: .tiles)
            tiles = spec.createTiles(for:self, with: tilesData, in: level)
        } else {
            //It's individual files
            type = .files
            
            let allTiles = try container.decode([Tile].self, forKey: .tiles)
            
            for tile in allTiles where tile.identifier.integerSource != nil{
                tile.tileSet = self
                tiles[tile.identifier.integerSource!] = tile
            }
            
        }
    }
    
    public class Tile: TiledDecodable, LayerContainer {
        public var identifier : Identifier
        public var parent : LayerContainer
        public let path    : String?
        public var objects : ObjectLayer?
        public var tileSet : TileSet? = nil
        public let position : Position?
        public var layers : [Layer] {
            if let objectLayer = objects {
                return [objectLayer]
            }
            return []
        }

        enum CodingKeys : String, CodingKey {
            case identifier = "id", image, objects = "objectgroup"
        }
        
        public required init(_ index:Int, from sheet:TileSheet, for set:TileSet, at location: (x:Int,y:Int), in container:LayerContainer){
            identifier = Identifier(stringLiteral: "\(sheet.imagePath):\(index)")
            path = nil
            tileSet = set
            objects = nil
            position = Position(x:location.x,y:location.y)
            parent = container
        }
        
        public required init(from decoder: Decoder) throws{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let path = try container.decodeIfPresent(String.self, forKey: CodingKeys.image){
                self.path = path
            } else {
                self.path = nil
            }
            
            identifier = Identifier(integerLiteral: try container.decode(Int.self, forKey: .identifier))
            
            parent = (decoder.userInfo[DecodingContext.key] as! DecodingContext).level!
            objects = try container.decodeIfPresent(ObjectLayer.self, forKey: .objects)
            position = nil
        }
        
        func texture<Engine:GameEngine>(for:Engine.Type)->Engine.Texture{
            return Engine.textureCache[identifier] ?? Engine.texture(self)
        }
    }
    
    
    public init(from url:URL){
        let data = Data.withContentsInBundleFirst(url:url)
        
        do {
            let decoder = XMLDecoder()
            decoder.userInfo[DecodingContext.key] = DecodingContext(with: [])
            
            let loaded = try decoder.decode(TileSet.self, from: data)
            
            self.tiles = loaded.tiles
            self.tileWidth = loaded.tileWidth
            self.tileHeight = loaded.tileHeight
            self.name = loaded.name
            self.type = loaded.type
        } catch {
            fatalError("Could not decode XML \(error)")
        }
    }
    
    public init(named name:String, tileWidth:Int, tileHeight:Int, of type:TileSetType){
        self.name = name
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.type = type
    }
}
