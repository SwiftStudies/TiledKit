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

/// Stores the tiles for a map so that they can be retreived as layers and objects are created
public class MapTiles<EngineType:Engine> {
    var     tiles = [UInt32:EngineType.SpriteType]()
    
    /// Access the the `Engine` specific tile that was created during the map loading
    /// process
    /// - Parameter tileGid: The GID of the tile required
    /// - returns The `Engine` specifc sprite
    public subscript(_ tileGid:TileGID)->EngineType.SpriteType?{
        return tiles[tileGid.globalTileOffset]?.deepCopy()
    }
}

class EngineMapLoader<E:Engine> : ResourceLoader {
    let project : Project
    
    let mapTiles = MapTiles<E>()
    
    init(_ project:Project){
        self.project = project
    }
    
    func walk(_ map:Map, bridgingTo specializedMap:E.MapType){
        //
        //        try apply(map: map, to: specializedMap)
        //
    }
    
    func build(specializedImplementationFor map:Map) throws -> E.MapType {
        for factory in E.engineMapFactories(){
            if let specializedMap : E.MapType = try factory.make(from: map, in: project) {
                return specializedMap
            }
        }
        
        return try E.make(engineMapForTiled: map)
    }
    
    func process(specializedMap:E.MapType, for map:Map) throws -> E.MapType {
        var specializedMap = specializedMap
        
        for mapProcessor in E.engineMapPostProcessors(){
            specializedMap = try mapProcessor.process(specializedMap, for: map, from: project)
        }
        
        return specializedMap
    }
    
    func loadTilesets(from map:Map, for specializedMap:E.MapType) throws {
        
        for tileSetReference in map.tileSetReferences {
            let tileSet = tileSetReference.tileSet
            var setSprites = [UInt32:E.SpriteType]()
            for tileId : UInt32  in 0..<UInt32(tileSet.count){
                guard let tile = tileSet[tileId] else {
                    throw EngineError.couldNotFindTileInTileSet(tileId, tileSet: tileSet)
                }
                var specializedTile : E.SpriteType!
                for factory in E.tileFactories() {
                    if let madeTile = try factory.make(spriteFor: tile, in: tileSet, with:  E.load(textureFrom: tile.imageSource, in: project), from: project){
                        specializedTile = madeTile
                        break
                    }
                }
                if specializedTile == nil {
                    specializedTile = try E.make(spriteFor: tile, in: tileSet, with: E.load(textureFrom: tile.imageSource, in: project), from: project)
                }
                
                setSprites[tileId] = specializedTile
            }
            
            // Post process
            for tileId : UInt32  in 0..<UInt32(tileSet.count){
                guard let tile = tileSet[tileId] else {
                    throw EngineError.couldNotFindTileInTileSet(tileId, tileSet: tileSet)
                }
                guard var sprite = setSprites[tileId] else {
                    throw EngineError.couldNotFindSpriteInTileSet(tileId, tileSet: tileSet)
                }
                
                setSprites[tileId] = try E.postProcess(sprite, from: tile, in: tileSet, with: setSprites, for: map, from: project)

                // Process stuff
                for processor in E.engineTilePostProcessors() {
                    sprite = try processor.process(sprite, from: tile, in: tileSet, with: setSprites, for: map, from: project)
                    setSprites[tileId] = sprite
                }
                
                // Store it for later use outside of the context of the single tileset
                mapTiles.tiles[tileSetReference.firstGid+tileId] = sprite
            }
        }
    }
    
    func retrieve<R>(asType: R.Type, from url: URL) throws -> R where R : Loadable {
        let tiledMap = try project.retrieve(asType: Map.self, from: url)
        
        // Use factories to build a map
        var specializedMap = try build(specializedImplementationFor: tiledMap)
        
        // Load the tiles
        try loadTilesets(from: tiledMap, for: specializedMap)
        
        /// Walk the map
        #warning("Turn back on")
//        walk(tiledMap, bridgingTo: specializedMap)
        
        // Apply map post processors
        specializedMap = try process(specializedMap: specializedMap, for: tiledMap)
        
        guard let typedSpecializedMap = specializedMap as? R else {
            throw EngineError.unsupportedTypeWhenLoadingMap(desiredType: "\(R.self)", supportedType: "\(E.MapType.self)")
        }
        
        return typedSpecializedMap
    }
}

/// Extensions that provide equivalent simplicity loading game engine specific content as is available for `Map`
public extension Project {
    
    /// Retreive a specialized map for a specific game engine. Note that the exact specialization will be determined by the
    /// receiving variable, so you must ensure the type is explicit. For example:
    ///
    ///     let level : CoolEngineScene = try Project.default.retrieve(specializedMap: "Level 1")
    ///
    /// You may wish to wrap this in further extensions to project (e.g. `func retrieve(coolEngineMap:String)`)
    ///
    /// - Parameters:
    ///   - name: The name of the map which will be resolved to a specific tiled `Map` file using the standard `Project` methodology
    ///   - subdirectory: The subdirectory the map is stored in relative to the `Project` root
    /// - Throws: Errors from loading
    /// - Returns: An instance of the specialized map
    func retrieve<E:EngineMap>(specializedMap name: String, in subdirectory:String? = nil) throws -> E {
        return try retrieve(asType: E.self, from: name, in: subdirectory, of: .tmx)
    }
}
