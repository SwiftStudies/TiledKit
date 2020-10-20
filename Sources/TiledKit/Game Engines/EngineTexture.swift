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

/// Adds convience method to enable simple loading of a sub-texture
public extension Engine {
    
    /// Make an instance of a given texture given the supplied clipping bounds and properites for this instance
    static func make(textureFrom url:URL, with bounds:PixelBounds?, and properties:Properties, in project:Project) throws -> TextureType {
        let texture = try project.retrieve(asType: TextureType.self, from: url)
        
        return try make(texture: texture, with: bounds, and: properties, in: project)
    }
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
