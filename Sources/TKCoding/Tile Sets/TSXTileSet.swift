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

import XMLCoder
import Foundation

public struct TSXTileSet : Codable {
    public let version : String
    public let tiledVersion : String
    public let name : String
    public let tileWidth : Int
    public let tileHeight : Int
    public let tileCount : Int
    public let columns : Int
    public let spacing : Int? 
    public let margin : Int? 
    public let properties : XMLProperties
    public let image : XMLImageElement?
    public let tileSpecs : [TSXTile]
    
    private enum CodingKeys : String, CodingKey{
        case version, tiledVersion = "tiledversion", name, tileWidth = "tilewidth", tileHeight = "tileheight", tileCount = "tilecount", columns, properties, image, tileSpecs = "tile", spacing, margin
    }
    
    static var decoder : XMLDecoder {
        let decoder = XMLDecoder()
                
        return decoder
    }
    
    public init(from url:URL) throws {
        let data = try Data(contentsOf: url)
        let loaded = try TSXTileSet.decoder.decode(TSXTileSet.self, from: data)
        
        name = loaded.name
        version = loaded.version
        tiledVersion = loaded.tiledVersion
        
        tileWidth = loaded.tileWidth
        tileHeight = loaded.tileHeight
        tileCount = loaded.tileCount
        columns = loaded.columns
        
        spacing = loaded.spacing
        margin = loaded.margin
        
        image = loaded.image
        
        properties = loaded.properties
        
        tileSpecs = loaded.tileSpecs
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        version = try container.decode(String.self, forKey: .version)
        tiledVersion = try container.decode(String.self, forKey: .tiledVersion)
        name = try container.decode(String.self, forKey: .name)
        
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        tileCount = try container.decode(Int.self, forKey: .tileCount)
        columns = try container.decode(Int.self, forKey: .columns)
        
        spacing = try container.decodeIfPresent(Int.self, forKey: .spacing)
        margin = try container.decodeIfPresent(Int.self, forKey: .margin)
        
        properties = try XMLProperties.decode(from: decoder)
        
        image = try container.decodeIfPresent(XMLImageElement.self, forKey: .image)
        
        tileSpecs = try container.decode([TSXTile].self, forKey: .tileSpecs)
    }
}
