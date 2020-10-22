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
    
    func walk<Container:EngineObjectContainer>(objects:[Object], in map:Map, containedIn container:Container) throws where Container.EngineType == E {
        
        for object in objects {
            switch object.kind {
            case .point:
                var madeObject : E.PointObjectType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(pointFor: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    madeObject = try E.make(pointFor: object, in: map, from: project)
                }
                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(point: madeObject, from: object, for: map, from: project)
                }
                
                try madeObject.verify()
                
                container.add(point: madeObject)
            case .rectangle(let size, angle: let angle):
                var madeObject : E.RectangleObjectType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(rectangleOf: size, at: angle, for: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    madeObject = try E.make(rectangleOf: size, at: angle, for: object, in: map, from: project)
                }
                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(rectangle: madeObject, from: object, for: map, from: project)
                }

                try madeObject.verify()
                
                container.add(rectangle: madeObject)
            case .ellipse(let size, angle: let angle):
                var madeObject : E.EllipseObjectType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(ellipseOf: size, at: angle, for: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    madeObject = try E.make(ellipseOf: size, at: angle, for: object, in: map, from: project)
                }
                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(ellipse: madeObject, from: object, for: map, from: project)
                }

                try madeObject.verify()
                
                container.add(ellipse: madeObject)
            case .tile(let tileGID, let size, let angle):
                var madeObject : E.SpriteType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(spriteWith: tileGID, of: size, at: angle, with: mapTiles, for: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    guard let spriteCopy = mapTiles[tileGID] else {
                        throw EngineError.couldNotFindTileInMap(tileGID)
                    }
                    madeObject = try E.make(spriteWith: spriteCopy, of: size, at: angle, for: object, in: map, from: project)
                }
                                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(sprite: madeObject, from: object, for: map, from: project)
                }

                try madeObject.verify()
                
                container.add(sprite: madeObject)
            case .text(let string, let size, let angle, let style):
                var madeObject : E.TextObjectType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(textWith: string, of: size, at: angle, with: style, for: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    madeObject = try E.make(textWith: string, of: size, at: angle, with: style, for: object, in: map, from: project)
                }
                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(text: madeObject, from: object, for: map, from: project)
                }
                
                try madeObject.verify()
                
                container.add(text: madeObject)
            case .polygon(let points, let angle):
                var madeObject : E.PolygonObjectType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(polygonWith: points, at: angle, for: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    madeObject = try E.make(polygonWith: points, at: angle, for: object, in: map, from: project)
                }
                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(polygon: madeObject, from: object, for: map, from: project)
                }

                try madeObject.verify()
                
                container.add(polygon: madeObject)
            case .polyline(let points, let angle):
                var madeObject : E.PolylineObjectType! = nil
                for factory in E.objectFactories() {
                    madeObject = try factory.make(polylineWith: points, at: angle, for: object, in: map, from: project)
                    if madeObject != nil {
                        break
                    }
                }
                if madeObject == nil {
                    madeObject = try E.make(polylineWith: points, at: angle, for: object, in: map, from: project)
                }
                
                for processor in E.engineObjectPostProcessors() {
                    madeObject = try processor.process(polyline: madeObject, from: object, for: map, from: project)
                }

                try madeObject.verify()
                
                container.add(polyline: madeObject)
            }
        }
        
    }
    
    func walk<Container:EngineLayerContainer>(layers:[Layer], in map:Map, containedIn container:Container) throws where Container.EngineType == E {
        
        for layer in layers {
            switch layer.kind {
            case .group(let group):
                var madeLayer : E.GroupLayerType!
                for factory in E.layerFactories() {
                    if let factoryMadeLayer = try factory.make(groupFor: layer, in: map, from: project){
                        madeLayer = factoryMadeLayer
                        break
                    }
                }
                
                if madeLayer == nil {
                    madeLayer = try E.make(groupFrom: layer, in: map, from: project)
                }
                
                try walk(layers: group.layers, in: map, containedIn: madeLayer)
                
                for postProcessor in E.engineLayerPostProcessors() {
                    madeLayer = try postProcessor.process(groupLayer: madeLayer, from: layer, for: map, in: project)
                }
                
                try madeLayer.verify()
                
                container.add(layer: madeLayer)
            case .image(let imageReference):
                var madeLayer : E.SpriteType!
                for factory in E.layerFactories() {
                    if let factoryMadeLayer = try factory.make(spriteFor: imageReference, for: layer, in: map, from: project){
                        madeLayer = factoryMadeLayer
                        break
                    }
                }
                
                if madeLayer == nil {
                    let texture = try project.retrieve(asType: E.TextureType.self, from: imageReference.source)
                    madeLayer = try E.make(spriteFrom: texture, for: layer, in: map, from: project)
                }
                
                for postProcessor in E.engineLayerPostProcessors() {
                    madeLayer = try postProcessor.process(imageLayer: madeLayer, from: layer, for: map, in: project)
                }
                
                try madeLayer.verify()
                
                container.add(sprite: madeLayer)
            case .objects(let objects):
                var madeLayer : E.ObjectLayerType! = nil
                for factory in E.layerFactories() {
                    if let factoryMadeLayer = try factory.make(objectContainerFor: layer, in: map, from: project){
                        madeLayer = factoryMadeLayer
                        break
                    }
                }
                
                if madeLayer == nil {
                    madeLayer = try E.make(objectContainerFrom: layer, in: map, from: project)
                }
                
                try walk(objects: objects, in: map, containedIn: madeLayer)
                
                for postProcessor in E.engineLayerPostProcessors() {
                    madeLayer = try postProcessor.process(objectLayer: madeLayer, from: layer, for: map, in: project)
                }
                
                try madeLayer.verify()
                
                container.add(layer: madeLayer)
            case .tile(let tileGrid):
                var madeLayer : E.TileLayerType! = nil
                for factory in E.layerFactories() {
                    if let factoryMadeLayer = try factory.make(tileLayerFor: tileGrid, for: layer, with: mapTiles, in: map, from: project){
                        madeLayer = factoryMadeLayer
                        break
                    }
                }
                
                if madeLayer == nil {
                    madeLayer = try E.make(tileLayer: tileGrid, for: layer, with: mapTiles, in: map, from: project)
                }
                
                for postProcessor in E.engineLayerPostProcessors() {
                    madeLayer = try postProcessor.process(tileLayer: madeLayer, from: layer, for: map, in: project)
                }
                
                try madeLayer.verify()
                
                container.add(layer: madeLayer)
            }
            
        }
        
    }
    
    func build(specializedImplementationFor map:Map) throws -> E.MapType {
        for factory in E.engineMapFactories(){
            if let specializedMap : E.MapType = try factory.make(mapFor: map, in: project) {
                return specializedMap
            }
        }
        
        return try E.make(mapFor: map)
    }
    
    func process(specializedMap:E.MapType, for map:Map) throws -> E.MapType {
        var specializedMap = specializedMap
        
        specializedMap = try E.process(engineMap: specializedMap, for: map, in: project)
        
        for mapProcessor in E.engineMapPostProcessors(){
            specializedMap = try mapProcessor.process(engineMap: specializedMap, for: map, from: project)
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
                
                setSprites[tileId] = try E.process(sprite, from: tile, in: tileSet, with: setSprites, for: map, from: project)

                // Process stuff
                for processor in E.engineTilePostProcessors() {
                    sprite = try processor.process(sprite: sprite, from: tile, in: tileSet, with: setSprites, for: map, from: project)
                    setSprites[tileId] = sprite
                }
                
                // Verify
                try sprite.verify()
                
                // Store it for later use outside of the context of the single tileset
                mapTiles.tiles[tileSetReference.firstGid+tileId] = sprite
            }
        }
    }
    
    func retrieve<R>(asType: R.Type, from url: URL) throws -> R where R : Loadable {
        /// Register defaults if present
        if !E.hasProducers {
            E.registerProducers()
        }
        
        let tiledMap = try project.retrieve(asType: Map.self, from: url)
        
        // Use factories to build a map
        var specializedMap = try build(specializedImplementationFor: tiledMap)
        
        // Load the tiles
        try loadTilesets(from: tiledMap, for: specializedMap)
        
        /// Walk the map
        try walk(layers: tiledMap.layers, in: tiledMap, containedIn: specializedMap)
        
        // Apply map post processors
        specializedMap = try process(specializedMap: specializedMap, for: tiledMap)
        
        // Verify
        try specializedMap.verify()
        
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
    func retrieve<EngineType:Engine>(_ engine:EngineType.Type, mapNamed name: String, in subdirectory:String? = nil) throws -> EngineType.MapType {
        return try retrieve(asType: EngineType.MapType.self, from: name, in: subdirectory, of: .tmx)
    }
}
