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

/// The entry point for any game engine specialization. See [Game Engine Specialization](../../Game%20Engine%20Specialization.md)
public protocol Engine {
    /// The most common lossless way of expressing a float in the engine
    associatedtype FloatType : ExpressibleAsTiledFloat
    
    /// The type that captures `Color`s in the engine
    associatedtype ColorType : ExpressibleAsTiledColor
    
    /// The type that represents a `Map` in the engine
    associatedtype MapType   : EngineMap
    
    /// The type that represents a texture or bitmap that will be rendered as a Sprite
    associatedtype TextureType : EngineTexture
    
    /// The type that represents the object that can draw itself on-screen
    associatedtype SpriteType  : EngineObject, DeepCopyable
    
    /// Provide a method for loading textures
    static func load(textureFrom url:URL, in project:Project) throws -> TextureType
    
    /// Provide a default specialized map creator for the Engine
    /// - Parameter map: The `Map` to create it for
    static func make(engineMapForTiled map:Map) throws -> MapType

    /// Provide a default specialized tile creator for the Engine
    /// - Parameter map: The `Map` to create it for
    static func make(tile:Tile, from tileSet:TileSet, from project:Project) throws -> SpriteType


}

/// By implementing this protocol (required for `Engine.TextureType`
/// loading behaviour except the actual loading of the texture data will be
/// provided
public protocol EngineTexture : EngineObject,Loadable {

}

/// Provides default implementations ensuring textures are cached, and
/// a simplified loader is used
public extension EngineTexture {
    var cache: Bool {
        return true
    }
    
    /// Returns the default loader for the `Engine` simplifying what has to be
    /// implemented
    /// - Parameter project: The project the texture is refered to from
    /// - Returns: The `ResourceLoader` that knows how  to load the texture
    static func loader(for project: Project) -> ResourceLoader {
        return EngineTextureLoader<EngineType>(project)
    }
}

/// An object that can create new instances that are deep copies of itself
public protocol DeepCopyable {
    /// Create a deep copy of the object, returning a new instance
    /// Unlike new instance, a new copy should always be returned
    func deepCopy()->Self
}

/// Provides common diagnostic capabilites to any engine specialization
public extension Engine {
    
    /// Removes all factories that have been registered for the engine
    static func removeAllFactoriesAndPostProcessors() {
        EngineRegistry.removeAll(from: Self.self)
    }
        
    /// Displays a warning message to the console. You can override to display the messages
    /// more prominantly in the engine of your chosing. 
    static func warn(_ message:String){
        print("Warning: \(message)")
    }
}
