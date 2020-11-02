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

// Provides some basic mathmeatical functions
public extension Point where N : BinaryFloatingPoint {
    func distance(to p2: Point<N>)->N {
        let dx = x - p2.x
        let dy = y - p2.y
        return (dx*dx + dy*dy).squareRoot()
    }
}

internal extension Orientation {
    
    func position(for gridPosition:TileGridPosition, in map:Map) throws ->Position {
        switch self {
        case .isometric:
            return Position(
                x: Double(map.pixelSize.width-map.tileSize.width)-(Double(gridPosition.y * (map.tileSize.width  / 2)) - Double(gridPosition.x * (map.tileSize.width / 2 )) + Double((map.pixelSize.width  / 2) - map.tileSize.width / 2)),
                y: Double(gridPosition.y * (map.tileSize.height / 2)) + Double(gridPosition.x * (map.tileSize.height / 2))                                  )
        case .orthogonal:
            return Position(
                x: Double(gridPosition.x)*map.orientation.tileWidth(for:map),
                y: Double(gridPosition.y)*map.orientation.tileHeight(for:map))
        case .hexagonal:
            var position = try Orientation.orthogonal.position(for: gridPosition, in: map)

            position.x += xStagger(for: gridPosition)
            position.y += yStagger(for: gridPosition)
            return position
        default:
            throw MapError.unsupportedOrientation(self)
        }
    }
    
    func tileWidth(for map:Map)->Double{
        switch self {
        case .hexagonal(let staggerAxis, _ , let sideLength):
            switch staggerAxis {
            case .x:
                return Double(map.tileSize.width - (sideLength/2))
            case .y:
                return Double(map.tileSize.width) 
            }
        default:
            return Double(map.tileSize.width)
        }        
    }
    
    func tileHeight(for map:Map)->Double{
        switch self {
        case .hexagonal(let staggerAxis, _ , let sideLength):
            switch staggerAxis {
            case .y:
                return Double(map.tileSize.height - (sideLength/2))
            case .x:
                return Double(map.tileSize.height)
            }
        default:
            return Double(map.tileSize.height)
        }        
        
    }
    
    func xStagger(for gridPosition:TileGridPosition)->Double{
        switch self {
        case .hexagonal(let staggerAxis, let staggerIndex, let sideLength):
            switch staggerAxis {
            case .x:
                return 0
            case .y:
                return  staggerIndex.appliesTo(gridPosition.y) ?   Double(sideLength) : 0
            }
        default:
            return 0
        }
    }
    
    func yStagger(for gridPosition:TileGridPosition)->Double{
        switch self {
        case .hexagonal(let staggerAxis, let staggerIndex, let sideLength):
            switch staggerAxis {
            case .y:
                return 0
            case .x:
                return  staggerIndex.appliesTo(gridPosition.x) ?   Double(sideLength) : 0
            }
        
        default:
            return 0
        }        
    }
    
    func produce<SpriteContainer:EngineSpriteContainer>(spriteContainer container:SpriteContainer, tilesFor grid:TileGrid, with sprites:MapTiles<SpriteContainer.EngineType>,from layer:LayerProtocol, for map:Map, `in` project:Project) throws {
       
        for gridPosition in try map.renderingOrder.tileSequence(for: map) {
            let tilePosition = try position(for: gridPosition, in: map)

            let tileGid = grid[gridPosition.x, gridPosition.y]
            
            if tileGid == 0 {
                continue
            }
            
            guard let tile = map[tileGid] else {
                throw EngineError.couldNotFindTileInMap(tileGid)
            }
            guard let tileSet = map.tileSetReference(containing: tileGid)?.tileSet else {
                throw EngineError.couldNotFindTileSetForTileInMap(tileGid)
            }
            
            var tileInstance : SpriteContainer.EngineType.SpriteType!
            
            for factory in SpriteContainer.EngineType.layerFactories() {
                if let instance = try factory.make(tileWith: tileGid, definedBy: tile, and: tileSet, at: tilePosition, with: sprites, for: layer, in: map, from: project) {
                    tileInstance = instance
                    break
                }
            }
            
            if tileInstance == nil {
                guard let sprite = sprites[tileGid] else {
                    throw EngineError.couldNotFindTileInMap(tileGid)
                }
                tileInstance = try SpriteContainer.EngineType.make(tileWith: sprite, at: tilePosition, orientation: tileGid.orientation, for: layer, in: map, from: project)
            }
            
            container.add(sprite: tileInstance)
            
            for processor in SpriteContainer.EngineType.engineLayerPostProcessors() {
                tileInstance = try processor.process(tileInstance: tileInstance, from: tile, and: tileSet, in: layer, for: map, from: project)
            }
            
        }
    }
    
}
