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

import TKCoding
import Foundation

extension TMXMap {
    static func build(in project:Project, from url:URL) throws -> Map {
        guard let _ = FileType(rawValue: url.pathExtension) else {
            throw MapError.unknownMapType(url.pathExtension)
        }

        let data = try Data(contentsOf: url)
        let tmxMap = try TMXMap.decoder.decode(TMXMap.self, from: data)

        let backgroundColor : Color?
        if let rawBackgroundColor = tmxMap.backgroundColor {
            backgroundColor = Color(from: rawBackgroundColor)
        } else {
            backgroundColor = nil
        }
        
        let orientation = try Orientation(
            tmxMap.orientation ?? "orthogonal", 
            staggerAxis: StaggerAxis(tmxMap.staggerAxis), 
            staggerIndex: StaggerIndex(tmxMap.staggerIndex), 
            hexSideLength: tmxMap.hexSideLength)
        
        var map = Map(
            url: url,
            mapSize: TileGridSize(width: tmxMap.width, height: tmxMap.height),
            tileSize: PixelSize(width: tmxMap.tileWidth, height: tmxMap.tileHeight),
            orientation: orientation,
            renderingOrder: RenderingOrder(rawValue: tmxMap.renderOrder) ?? .rightDown,
            backgroundColor: backgroundColor
        )
        
        // Convert properties on the map
        map.properties = tmxMap.properties.interpret(baseUrl: map.url, in: project)
        
        // Load tile sets
        for tileSetReference in tmxMap.tileSetReferences {
            let tileSet = try project.retrieve(asType: TileSet.self, from: URL(fileURLWithPath: tileSetReference.path), relativeTo: url)
            
            map.tileSetReferences.append(TileSetReference(firstGid: UInt32(tileSetReference.firstGid), tileSet: tileSet))
        }
        
        // Build layers
        map.layers.append(contentsOf: tmxMap.layers.compactMap({$0.tkLayer(for: map, in: project)}))
        return map
    }
}
