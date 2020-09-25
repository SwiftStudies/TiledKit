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

import TKXMLCoding
import Foundation

extension TMXMap {
    static func build(in project:Project, from url:URL) throws -> Map {
        let baseUrl = url.deletingLastPathComponent()
        let file    = url.lastPathComponent
        guard let type = FileTypes(rawValue: url.pathExtension) else {
            throw MapError.unknownMapType(url.pathExtension)
        }

        let data = try Data(contentsOf: url)
        let tmxMap = try TMXMap.decoder.decode(TMXMap.self, from: data)

        var map = Map(
            url: url,
            mapSize: TileSize(width: tmxMap.width, height: tmxMap.height),
            tileSize: PixelSize(width: tmxMap.tileWidth, height: tmxMap.tileHeight),
            orientation: Orientation(rawValue: tmxMap.orientation) ?? .orthogonal,
            renderingOrder: RenderingOrder(rawValue: tmxMap.renderOrder) ?? .rightDown
        )
        
        // Convert properties on the map
        map.properties = tmxMap.properties.interpret(for: map, in: project)
        
        // Load tile sets
        #warning("Not implemented")
        
        // Build layers
        map.layers.append(contentsOf: tmxMap.layers.compactMap({$0.tkLayer(for: map, in: project)}))
        return map
    }
}
