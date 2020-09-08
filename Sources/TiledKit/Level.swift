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
    var customObjectTypes : [CustomObject.Type]
    var level : Level? = nil
    var layerPath = [Layer]()
    
    init(originatingFrom url:URL?, with customObjectTypes:[CustomObject.Type]){
        self.originUrl = url
        self.customObjectTypes = customObjectTypes
    }
}

protocol TiledDecodable : Decodable {
   
}

extension TiledDecodable {
    func decodingContext(url:URL?,_ decoder:Decoder)->DecodingContext{
        return decoder.userInfo.levelDecodingContext(originatingFrom: url)
    }
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
    fileprivate var tileSets = [TileSet]()
    public var tiles = [Int : TileSet.Tile]()
    
    public init(){
        height = 0
        width = 0
        tileWidth = 0
        tileHeight = 0
        tileSetReferences = []
    }

    public init(from url:URL) throws {
        let data = Data.withContentsInBundleFirst(url:url)
        
        do {
            let decoder = XMLDecoder()
            let context = DecodingContext(originatingFrom: url.deletingLastPathComponent(), with: [])
            
            decoder.userInfo[DecodingContext.key] = context
            
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
            fatalError("Could not decode XML \(error)")
        }
    }
    
    public required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        tileSetReferences = try container.decode([TileSetReference].self, forKey: .tileSets)
        if let properties = try? decode(from: decoder) {
            self.properties = properties
        }
        
        
        decodingContext(url: nil, decoder).level = self

        for tileSetReference in tileSetReferences {
            let tileSet = TileSetCache.tileSet(from: tileSetReference)
            tileSets.append(tileSet)
            for (lid,tile) in tileSet.tiles {
                tiles[tileSetReference.firstGID+lid] = tile
            }
        }

        //Import to set the level context before decoding layers
        layers.append(contentsOf: try Level.decodeLayers(container))

        //Now build all the custom objects
        for objectLayer in getObjectLayers(recursively: true) as [ObjectLayer]{
            for object in objectLayer.objects {
                object.type = CustomObjectFactory.make(for: object, with: decodingContext(url: nil, decoder).customObjectTypes)
            }
        }
    }
    
    public init<Engine:GameEngine>(fromFile file:String, using customObjectTypes:[CustomObject.Type] = [], for engine:Engine.Type){
        let url : URL
        
        if let bundleUrl = Bundle.main.url(forResource: file, withExtension: "json") {
            url = bundleUrl
        } else {
            url = URL(fileURLWithPath: file)
        }
        
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("Could not find level file \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) as data")
        }
        
        do {
            let workingDirectory = FileManager.default.currentDirectoryPath
            
            FileManager.default.changeCurrentDirectoryPath(url.deletingLastPathComponent().absoluteURL.path)
            
            let jsonDecoder = JSONDecoder()
            let decodingContext = DecodingContext(originatingFrom: url, with: customObjectTypes)
            jsonDecoder.userInfo[DecodingContext.key] = decodingContext
            let loadedLevel = try jsonDecoder.decode(Level.self, from: data)
            self.height = loadedLevel.height
            self.width  = loadedLevel.width
            self.tileWidth = loadedLevel.tileWidth
            self.tileHeight = loadedLevel.tileHeight
            self.properties = loadedLevel.properties
            self.layers = loadedLevel.layers
            self.tileSetReferences = loadedLevel.tileSetReferences
            self.tileSets = loadedLevel.tileSets
            self.tiles = loadedLevel.tiles
            
            
            Engine.cacheTextures(from: self)
            FileManager.default.changeCurrentDirectoryPath(workingDirectory)
        } catch {
            fatalError("\(error)")
        }
    }
    
    enum CodingKeys : String, XMLChoiceCodingKey {
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
    func levelDecodingContext(originatingFrom url:URL?)->DecodingContext{
        return (self[DecodingContext.key] as? DecodingContext) ?? DecodingContext(originatingFrom:  nil, with: [])

    }
}
