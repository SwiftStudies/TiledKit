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

public final class Tiled {

    public static let `default` = Tiled()
    
    private var     gameEngine : GameEngine = DefaultGameEngine()
    
    private init(){
        
    }
    
    internal func set(specialization engine:GameEngine){
        gameEngine = engine
    }
    
    internal func tileSetLoaded(_ tileSet:TileSet) throws {
        try gameEngine.create(tileSet: tileSet)
    }
    
    public func load(tileSetFrom url:URL) throws {
        
    }
    
    #warning("Again, absolutely hideous I need to decide how I'm going to deal with the generics and get rid of Any")
    private func walk(_ layers:[Layer], for engine:GameEngine, in specialisedContainer:Any) throws {
        for layer in layers {
            if let tileLayer = layer as? TileLayer {
                try engine.add(tileLayer: tileLayer, to: specialisedContainer)
            } else if let objectLayer = layer as? ObjectLayer {
                try engine.add(objects: objectLayer, to: specialisedContainer)
            } else if let group = layer as? GroupLayer {
                let specializedGroup = try engine.add(group: group, to: specialisedContainer)
                try walk(group.layers, for: engine, in: engine.container(for: specializedGroup))
            } else if let image = layer as? ImageLayer {
                try engine.add(image: image, to: specialisedContainer)
            } else {
                throw TiledDecodingError.unknownLayerType(layerType: "\(type(of: layer))")
            }
        }
    }
        
    public func load<Output>(levelFrom url:URL) throws -> Output{
        let level = try Level(from: url)
        
        let specialisedLevel : Output = try gameEngine.create(level: level)
        try walk(level.layers, for: gameEngine, in: gameEngine.container(for: specialisedLevel))
        
        return specialisedLevel
    }
}

fileprivate struct DefaultGameEngine : GameEngine {

    func container(for object: Any) -> Any {
        return object
    }
    
    func create(tileSet: TileSet) throws {
        throw TiledDecodingError.noGameEngineSpecified
    }
    
    func create<SpecialisedLevel>(level: Level) throws -> SpecialisedLevel {
        throw TiledDecodingError.noGameEngineSpecified
    }
    
    func add(tile: Int, to tileSet: TileSet) throws {
        throw TiledDecodingError.noGameEngineSpecified
    }
    
    func add(tileLayer: TileLayer, to container: Any) throws {
        throw TiledDecodingError.noGameEngineSpecified
    }
    
    func add(group: GroupLayer, to container: Any) throws -> Any {
        throw TiledDecodingError.noGameEngineSpecified
    }
    
    func add(image: ImageLayer, to container: Any) throws {
        throw TiledDecodingError.noGameEngineSpecified
    }
    
    func add(objects: ObjectLayer, to container: Any) throws {
        throw TiledDecodingError.noGameEngineSpecified
    }
}
