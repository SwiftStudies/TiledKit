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


fileprivate extension RenderingOrder {
    func tileSequence(for map:Map) throws -> [TileGridPosition]{
        var sequence = [TileGridPosition]()
        
        switch self {
        case .rightDown:
            for x in 0..<map.mapSize.width {
                for y in 0..<map.mapSize.height {
                    sequence.append(TileGridPosition(x: x, y: y))
                }
            }
        default:
            throw MapError.unsupportedRenderingOrder(self)
        }
        
        return sequence
    }
}

internal extension Orientation {
    
    func position(for gridPosition:TileGridPosition, in map:Map) throws ->Position {
        switch self {
        case .orthogonal:
            return Position(
                x: Double(gridPosition.x*map.tileSize.width),
                y: Double(gridPosition.y*map.tileSize.height))
        default:
            throw MapError.unsupportedOrientation(self)
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
                tileInstance = try SpriteContainer.EngineType.make(tileWith: sprite, at: tilePosition, for: layer, in: map, from: project)
            }
            
            container.add(sprite: tileInstance)
            
            for processor in SpriteContainer.EngineType.engineLayerPostProcessors() {
                tileInstance = try processor.process(tileInstance: tileInstance, from: tile, and: tileSet, in: layer, for: map, from: project)
            }
            
        }
    }
    
}
