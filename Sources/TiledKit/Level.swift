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

//TODO: Move into its own file
class DecodingContext{
    static var key : CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "TiledLevelDecodingContext")!
    }
    var originUrl : URL?
    var level : Level? = nil
    var layerPath = [Layer]()
    
    init(originatingFrom url:URL?){
        self.originUrl = url
    }
    
    var currentContainer : LayerContainer? {
        if let topContainer = layerPath.last {
            return topContainer as? LayerContainer
        }
        return level
    }
}

protocol TiledDecodable : Decodable {
   
}

public class Level : TiledDecodable, LayerContainer, Propertied {
    public var parent : LayerContainer {
        return self
    }
    public var layers      = [Layer]()
    public let height      : Int
    public let width       : Int
    public let tileWidth   : Int
    public let tileHeight  : Int
    public var properties  = [String:Literal]()
    fileprivate let tileSetReferences    : [TileSetReference]
    internal var tileSets = [TileSet]()
    public var tiles = [Int : TileSet.Tile]()
    
    public init(){
        height = 0
        width = 0
        tileWidth = 0
        tileHeight = 0
        tileSetReferences = []
    }

    public init(from url:URL) throws {
        let data = try  Data.withContentsInBundleFirst(url:url)
        
        do {
            let decoder = TiledDecoder(from: url)

            let loaded = try decoder.decode(Level.self, from: data)
            
            height = loaded.height
            width = loaded.width
            tileWidth = loaded.tileWidth
            tileHeight = loaded.tileHeight
            tileSetReferences = loaded.tileSetReferences
            properties = loaded.properties
            tileSets = loaded.tileSets
            layers = loaded.layers
            
        } catch {
            throw TiledDecodingError.couldNotLoadLevel(url: url, decodingError: error)
        }
    }
    
    public required init(from decoder:Decoder) throws {
        guard let decoderContext = decoder.userInfo.decodingContext else {
            throw TiledDecodingError.missingDecoderContext
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)

        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        tileSetReferences = try container.decode([TileSetReference].self, forKey: .tileSets)
        if let properties = try? decode(from: decoder) {
            self.properties = properties
        }
        
        
        decoderContext.level = self

        for tileSetReference in tileSetReferences {
            let tileSet = try TileSetCache.tileSet(from: tileSetReference)
            tileSets.append(tileSet)
            for (lid,tile) in tileSet.tiles {
                print("Setting \(tileSetReference.firstGID+lid) (\(tileSetReference.firstGID)+\(lid))")
                tiles[tileSetReference.firstGID+lid] = tile
            }
        }

        //Import to set the level context before decoding layers
        layers.append(contentsOf: try Level.decodeLayers(container))

    }
    
    enum CodingKeys : String, CodingKey {
        case height, width, layers = "layer", objectLayer = "objectgroup", imageLayer="imagelayer", group="group", properties
        case tileWidth  = "tilewidth"
        case tileHeight = "tileheight"
        case tileSets = "tileset"
    }
}

extension Dictionary where Key == CodingUserInfoKey {
    var decodingContext : DecodingContext? {
        return self[DecodingContext.key] as? DecodingContext
    }

}
