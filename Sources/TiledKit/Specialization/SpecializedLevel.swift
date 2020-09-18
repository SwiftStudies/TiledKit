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

public protocol SpecializedLevel {
    associatedtype Container
        
    var primaryContainer : Container { get }
    
    init()
    func apply(tiledLevel level:Level)
    
    func create(tileSet:TileSet) throws
    func add(tile:Int, to tileSet:TileSet) throws
    
    func add(tileLayer:TileLayer, to container:Container) throws
    func add(group:GroupLayer, to container:Container) throws -> Container
    func add(image:ImageLayer, to container:Container) throws
    func add(objects:ObjectLayer, to container:Container) throws
}

public extension SpecializedLevel {
    init(tiledLevel url:URL) throws {
        let level = try Level(from: url)
        
        self.init()
        apply(tiledLevel: level)
        
        for tileSet in level.tileSets {
            try create(tileSet: tileSet)
        }
        
        try walk(level.layers, in: primaryContainer)
    }
}

internal extension SpecializedLevel {
    private func walk(_ layers:[TiledKit.Layer], in specialisedContainer:Container) throws {
        for layer in layers {
            if let tileLayer = layer as? TileLayer {
                try add(tileLayer: tileLayer, to: specialisedContainer)
            } else if let objectLayer = layer as? ObjectLayer {
                try add(objects: objectLayer, to: specialisedContainer)
            } else if let group = layer as? GroupLayer {
                let specializedGroup = try add(group: group, to: specialisedContainer)
                try walk(group.layers, in: specializedGroup)
            } else if let image = layer as? ImageLayer {
                try add(image: image, to: specialisedContainer)
            } else {
                throw TiledDecodingError.unknownLayerType(layerType: "\(type(of: layer))")
            }
        }
    }
}
