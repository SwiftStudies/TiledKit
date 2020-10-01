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

enum TileSetLoadingError : Error {
    case imageForTileSheetCantBeFound(URL)
    case tileForFrameDoesNotExist(UInt32)
}

extension TSXTileSet {
    static func build(in project:Project, from url:URL) throws -> TileSet {
        let tileSetXML = try TSXTileSet(from: url)
        
        let tileSet = TileSet(name: tileSetXML.name, tileSize: PixelSize(width: tileSetXML.tileWidth, height: tileSetXML.tileHeight), properties: tileSetXML.properties.interpret(baseUrl: url, in: project))
        
        if let xmlImage = tileSetXML.image {
            
            // Resolve the source of the image
            guard let tileImageUrl = project.resolve(URL(fileURLWithPath: xmlImage.source), relativeTo: url) else {
                throw TileSetLoadingError.imageForTileSheetCantBeFound(URL(fileURLWithPath: xmlImage.source))
            }
            
            // Prepare the transparent color if any
            let transparentColor : Color?
            if let colorString = xmlImage.transparentColor {
                transparentColor = Color(from: colorString)
            } else {
                transparentColor = nil
            }
            
            // Calculate the bounds for each tile and add them to the tile set
            for tileId in 0..<tileSetXML.tileCount {
                let origin = PixelPoint(
                    x: (tileId % tileSetXML.columns) * tileSetXML.tileWidth,
                    y: (tileId / tileSetXML.columns) * tileSetXML.tileHeight)
                
                let tile = Tile(
                    tileImageUrl,
                    bounds: PixelBounds(origin: origin, size: tileSet.tileSize), transparentColor: transparentColor)
                
                tileSet[UInt32(tileId)] = tile
            }
        } else {
            for xmlTile in tileSetXML.tileSpecs {
                if let tileImage = xmlTile.image, let tileImageUrl = project.resolve(URL(fileURLWithPath: tileImage.source), relativeTo: url) {
                    let transparentColor : Color?
                    
                    if let colorString = xmlTile.image?.transparentColor ?? tileSetXML.image?.transparentColor{
                        transparentColor = Color(from: colorString)
                    } else {
                        transparentColor = nil
                    }
                    
                    let tile = Tile(
                        tileImageUrl,
                        bounds: PixelBounds(origin: PixelPoint.zero, size: PixelSize(width: tileImage.width, height: tileImage.height)), transparentColor: transparentColor)
                    
                    tileSet[xmlTile.id] = tile
                }
            }
        }
        
        // Now we have all tiles add any animation frames and collision bodies
        for xmlTile in tileSetXML.tileSpecs {
            let collisionBodies = xmlTile.collisionObject?.objects.compactMap({ (xmlObject)->Object? in
                return xmlObject.tkGeometricObject(relativeTo: url, in: project)
            })
            
            
            let frames = try xmlTile.animationFrames.map({ (xmlFrame) -> Frame in
                guard let frameTile = tileSet[xmlFrame.tileid] else {
                    throw TileSetLoadingError.tileForFrameDoesNotExist(xmlFrame.tileid)
                }
                return Frame(tile: frameTile, duration: Double(xmlFrame.duration)/1000)
            })
            
            if frames.count > 0 {
                tileSet[xmlTile.id]?.frames = frames
            }
            if let collisionBodies = collisionBodies {
                tileSet[xmlTile.id]?.collisionBodies = collisionBodies
            }
        }
        
        return tileSet
    }
}
