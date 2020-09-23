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

public struct TMXElements : Codable {
    
}

public struct TMXLevel : Codable, XMLPropertied {
    enum CodingKeys : String, CodingKey {
        case version, tiledVersion = "tiledversion", orientation, renderOrder = "renderorder", width, height, tileWidth = "tilewidth", tileHeight = "tileheight", infinite
    }
    
    enum ElementCodingKeys : String, CodingKey {
        case layer, objects = "objectgroup", group, image = "imagelayer", properties, tileset
    }
    
    static var decoder : XMLDecoder {
        let decoder = XMLDecoder()
                
        return decoder
    }
    
    public let version : String
    public let tiledVersion : String
    public let orientation : String
    public let renderOrder : String
    public let width : Int
    public let height : Int
    public let tileWidth : Int
    public let tileHeight : Int
    public let infinite : Bool

    public let layers : [TMXLayer]
    public let tileSetReferences : [TMXTileSetReference]
    public let properties : XMLProperties
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        version = try container.decode(String.self, forKey: .version)
        tiledVersion = try container.decode(String.self, forKey: .tiledVersion)
        orientation = try container.decode(String.self, forKey: .orientation)
        renderOrder = try container.decode(String.self, forKey: .renderOrder)
        
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        
        infinite = try container.decode(Bool.self, forKey: .infinite)

        let elementContainer = try decoder.container(keyedBy: ElementCodingKeys.self)
        let keys = elementContainer.allKeys.compactMap(){ (elementCodingKey) -> ElementCodingKeys? in
            switch elementCodingKey {
            case .properties, .tileset: return nil
            default: return elementCodingKey
            }
        }
        
        tileSetReferences = try elementContainer.decode([TMXTileSetReference].self, forKey: .tileset)
        properties = try elementContainer.decodeIfPresent(XMLProperties.self, forKey: .properties) ?? XMLProperties(properties: [XMLProperty]())
                
        var layers = [TMXInternalLayerRepresentation]()
        var tileLayers = try elementContainer.decode([TMXTileLayer].self, forKey: .layer)
        var groupLayers = try elementContainer.decode([TMXGroupLayer].self, forKey: .group)
        var imageLayers = try elementContainer.decode([TMXImageLayer].self, forKey: .image)
        var objectLayers = try elementContainer.decode([TMXObjectLayer].self, forKey: .objects)

        for key in keys {
            switch key {
            case .layer:
                layers.append(tileLayers.removeFirst())
            case .objects:
                layers.append(objectLayers.removeFirst())
            case .group:
                layers.append(groupLayers.removeFirst())
            case .image:
                layers.append(imageLayers.removeFirst())
            default:
                break
            }
        }
        
        self.layers = layers
    }
    
    #warning("Not implemented")
    public func encode(to encoder: Encoder) throws {
        fatalError("Not implemented")
    }
}
