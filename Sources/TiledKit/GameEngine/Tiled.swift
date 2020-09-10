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
    
    private func walk(_ layers:[Layer], for subscriber:GameEngine, in container:LayerContainer) throws {
        for layer in layers {
            if let tileLayer = layer as? TileLayer {
                try subscriber.add(tileLayer: tileLayer, to: container)
            } else if let objectLayer = layer as? ObjectLayer {
                try subscriber.add(objects: objectLayer, to: container)
            } else if let group = layer as? GroupLayer {
                try subscriber.add(group: group, to: container)
                try walk(group.layers, for: subscriber, in: group)
            } else if let image = layer as? ImageLayer {
                try subscriber.add(image: image, to: container)
            } else {
                throw TiledDecodingError.unknownLayerType(layerType: "\(type(of: layer))")
            }
        }
    }
        
    public func load<Output>(levelFrom url:URL) throws -> Output{
        let level = try Level(from: url)
        
        let specialisedLevel : Output = try gameEngine.create(level: level)
        try walk(level.layers, for: gameEngine, in: level)
        
        return specialisedLevel
    }
}

fileprivate struct DefaultGameEngine : GameEngine {
    func create(tileSet: TileSet) throws {
        
    }
    
    func create<SpecialisedLevel>(level: Level) throws -> SpecialisedLevel {
        guard level is SpecialisedLevel else {
            throw TiledDecodingError.cannotCreateSpecialisedLevelOfType(desiredType: "\(type(of: SpecialisedLevel.self))", supportedTypes: ["TiledKit.Level"])
        }
        return level as! SpecialisedLevel
    }
    
    func add(tile: Int, to tileSet: TileSet) throws {
        
    }
    
    func add(tileLayer: TileLayer, to container: LayerContainer) throws {
        
    }
    
    func add(group: GroupLayer, to container: LayerContainer) throws {
        
    }
    
    func add(image: ImageLayer, to container: LayerContainer) throws {
        
    }
    
    func add(objects: ObjectLayer, to container: LayerContainer) throws {
        
    }
}
