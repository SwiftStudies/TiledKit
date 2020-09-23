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

struct XMLLayerContainer {
    enum LayerElementCodingKeys : String, CodingKey {
        case layer, objects = "objectgroup", group, image = "imagelayer"
    }
    
    static func decodeLayers(from decoder:Decoder) throws ->[TMXLayer] {
        let elementContainer = try decoder.container(keyedBy: LayerElementCodingKeys.self)
        let keys = elementContainer.allKeys
        
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
            }
        }
        
        return layers
    }
}

