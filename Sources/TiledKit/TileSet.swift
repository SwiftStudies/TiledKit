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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let relativePath = try container.decode(String.self, forKey: .file)
        
        if relativePath.hasPrefix("..") {
            let originUrl = decoder.userInfo.decodingContext?.originUrl ?? Bundle.main.bundleURL
            
            file = originUrl.appendingPathComponent(relativePath).path
            
        } else {
            file = relativePath
        }
        
        firstGID = try container.decode(Int.self, forKey: .firstGID)
    }
    
    init(with firstGid:Int, for tileSet:TileSet, in file:String){
        self.firstGID = firstGid
        identifier = Identifier(stringLiteral: tileSet.name)
        self.file = file
    }
    
    func tileSet() throws -> TileSet {
        return try TileSetCache.tileSet(from: self)

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
    public let imagePath : URL
    let imageWidth : Int
    let imageHeight : Int
    let margin : Int
    let spacing : Int
    let tileCount : Int
    let transparentColor : Color
    let columns : Int
    
    
    private enum CodingKeys : String, CodingKey {
        case imageWidth = "width", imageHeight = "height", margin, spacing, tileCount="tilecount", transparentColor = "trans", columns, imagePath = "source", image = "image"
    }
    
    public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Required
        columns = try container.decode(Int.self, forKey: .columns)
        tileCount = try container.decode(Int.self, forKey: .tileCount)

        let imageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .image)
        
        var path = try imageContainer.decode(String.self, forKey: .imagePath)
        
        #warning("Should check for .. first")
        if path.hasPrefix("..") {
            let originUrl = decoder.userInfo.decodingContext?.originUrl ?? Bundle.main.bundleURL
            
            path = originUrl.appendingPathComponent(path).standardizedFileURL.path
        }
        
        imagePath = URL(fileURLWithPath: path)
        
        imageWidth = try imageContainer.decode(Int.self, forKey: .imageWidth)
        imageHeight = try imageContainer.decode(Int.self, forKey: .imageHeight)
        
        // Optional
        #warning("Not reading the grid")
        transparentColor = (try? imageContainer.decode(Color.self, forKey: .transparentColor)) ?? Color(r: 0, g: 0, b: 0, a: 0)
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
                    
            
            let newTile = TileSet.Tile(tileIndex, from: self, for: tileSet, at: (x,y),  in: container)
            
            #warning("Should check for animation data here too")
            if let additionalTileData = data[tileIndex] {
                newTile.objects = additionalTileData.objects
                newTile.frames = additionalTileData.frames
            }
            
            tiles[tileIndex] = newTile
        }
        return tiles
    }
}

@dynamicMemberLookup
public struct TileSet : TiledDecodable, Propertied{
    public var name : String
    public var tileWidth : Int
    public var tileHeight : Int
    public var tiles = [Int:Tile]()
    public var type : TileSetType
    
    public var properties = [String : PropertyValue]()
    
    public enum CodingKeys : String, CodingKey {
        case tiles = "tile"
        case tileWidth = "tilewidth"
        case tileHeight = "tileheight"
        case name
        case image
        case properties
    }
    
    public init(from decoder: Decoder) throws{
        guard let decoderContext = decoder.userInfo.decodingContext else {
            throw TiledDecodingError.missingDecoderContext
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        name = try container.decode(String.self, forKey: .name)
        
        //Import to set the level context before decoding tiles as they can contain layers
        let level = Level()
        decoderContext.level = level
        
        // Create the tiles, we first need to determine if this is a
        // sheet type or a collection of images
        if container.contains(.image){
            let spec = try TileSheet(from: decoder)
            type = .sheet(tileSheet: spec)
            // Needed for layers and animations etc
            let additionalTileData = try container.decode([Tile].self, forKey: .tiles)
            
            let tilesData = additionalTileData.reduce(into:[Int:Tile]()) {
                $0[$1.identifier.integerSource!] = $1
            }
            
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
        
        if let properties = try? decode(from: decoder) {
            self.properties = properties
        }
    }
    
    public class Tile: TiledDecodable, LayerContainer {
        fileprivate struct Frames : Codable {
            fileprivate struct AnimationFrame : Codable {
                let tileid : Int
                let duration : Int
            }
            let frames : [AnimationFrame]
            
            enum CodingKeys : String, CodingKey {
                case frames = "frame"
            }
        }
        
        public struct Frame {
            let tile        : Tile
            let duration    : Double
        }

        public var identifier : Identifier
        public var parent : LayerContainer
        public let path    : URL?
        public var objects : ObjectLayer?
        public var tileSet : TileSet? = nil
        public let position : Position?
        public var layers : [Layer] {
            if let objectLayer = objects {
                return [objectLayer]
            }
            return []
        }
        fileprivate var frames : Frames
        
        public var animation : [Frame] {
            guard let tileSet = tileSet else {
                fatalError("Tile has no tileSet")
            }
            return frames.frames.map(){
                guard let tile = tileSet.tiles[$0.tileid] else {
                    fatalError("Tileset \"\(tileSet.name)\" does not contain tile with id \($0.tileid)")
                }
                return Frame(tile: tile, duration: Double($0.duration)/1000)
            }
        }

        enum CodingKeys : String, CodingKey {
            case identifier = "id", image, objects = "objectgroup", animation, frame
        }
        
        public required init(_ index:Int, from sheet:TileSheet, for set:TileSet, at location: (x:Int,y:Int), in container:LayerContainer){
            identifier = Identifier(stringLiteral: "\(sheet.imagePath):\(index)")
            path = nil
            tileSet = set
            position = Position(x:location.x,y:location.y)
            parent = container
            objects = nil
            frames = Frames(frames: [Frames.AnimationFrame]())
        }
        
        public required init(from decoder: Decoder) throws{
            
            struct TileImage : Decodable {
                let width : Int
                let height : Int
                let source : String
            }
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let tileImage = try container.decodeIfPresent(TileImage.self, forKey: .image){
                #warning("Should check for .. first")
                path = decoder.userInfo.decodingContext?.originUrl?.appendingPathComponent(tileImage.source).standardizedFileURL
            } else {
                path = nil
            }
            
                    
            identifier = Identifier(integerLiteral: try container.decode(Int.self, forKey: .identifier))
            
            #warning("Force unwrap")
            parent = (decoder.userInfo[DecodingContext.key] as! DecodingContext).level!
            objects = try container.decodeIfPresent(ObjectLayer.self, forKey: .objects)

            do {
                let loadedFrames = try container.decode(Frames.self, forKey: .animation)
                frames = loadedFrames
            } catch {
                frames = Frames(frames: [Frames.AnimationFrame]())
            }
            
            print(frames.frames.map(({"\($0.tileid) \($0.duration)ms"})))
            
            position = nil
        }
        
    }
    
    
    public init(from url:URL) throws {
        let data = try Data.withContentsInBundleFirst(url:url)
        
        do {
            let decoder = TiledDecoder(from: url)
            
            let loaded = try decoder.decode(TileSet.self, from: data)
            
            self.tiles = loaded.tiles
            self.tileWidth = loaded.tileWidth
            self.tileHeight = loaded.tileHeight
            self.name = loaded.name
            self.type = loaded.type
            self.properties = loaded.properties
            for tile in self.tiles.values {
                tile.tileSet = self
            }
        } catch {
            throw TiledDecodingError.couldNotLoadTileSet(url: url, decodingError: error)
        }
    }
    
    public init(named name:String, tileWidth:Int, tileHeight:Int, of type:TileSetType){
        self.name = name
        self.tileWidth = tileWidth
        self.tileHeight = tileHeight
        self.type = type
    }
}
