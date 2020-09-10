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


import TiledKit
import SpriteKit

public enum SKTiledKitError : Error {
    case notImplemented
}

open class SKTiledKit :  GameEngine {
    
    required public init(){
        
    }
    
    public func create(tileSet: TileSet) throws {
        throw SKTiledKitError.notImplemented
    }
    
    public func create<SpecialisedLevel>(level: Level) throws -> SpecialisedLevel {
        let scene = SKScene(size: CGSize(width: CGFloat(level.width*level.tileWidth), height: CGFloat(level.height*level.tileHeight)))
        
        guard scene is SpecialisedLevel else {
            throw TiledDecodingError.cannotCreateSpecialisedLevelOfType(desiredType: "\(type(of: SpecialisedLevel.self))", supportedTypes: ["SKScene"])
        }
        
        return scene as! SpecialisedLevel
    }
    
    public func add(tile: Int, to tileSet: TileSet) throws {
        throw SKTiledKitError.notImplemented
    }
    
    public func add(tileLayer: TileLayer, to container: LayerContainer) throws {
        throw SKTiledKitError.notImplemented
    }
    
    public func add(group: GroupLayer, to container: LayerContainer) throws {
        throw SKTiledKitError.notImplemented
    }
    
    public func add(image: ImageLayer, to container: LayerContainer) throws {
        throw SKTiledKitError.notImplemented
    }
    
    public func add(objects: ObjectLayer, to container: LayerContainer) throws {
        throw SKTiledKitError.notImplemented
    }
    
}
