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

/// This type should not be implemented outside of TiledKit and is used solely pass
/// information about the current project to the `Engine`s load texture implementation.
/// Outside of TiledKit you should use the automatically provided `Engine.load(textureFrom url:URL, project: Project)` method
public protocol EngineImageLoader {
    var project: Project { get }
}

class EngineTextureLoader<EngineType:Engine> : ResourceLoader, EngineImageLoader {
    let project : Project
    
    init(_ project:Project){
        self.project = project
    }
    
    func retrieve<R>(asType: R.Type, from url: URL) throws -> R where R : Loadable {
        guard let loadedTexture =  try EngineType.load(textureFrom: url, by: self) as? R else {
            throw EngineError.couldNotCreateTextureFrom(url)
        }
        
        if let engineTexture = loadedTexture as? EngineType.TextureType {
            try engineTexture.verify()
        } else {
            EngineType.warn("Loaded texture (\(type(of: loadedTexture))) does not match (\(EngineType.self))'s Texture Type (\(EngineType.TextureType.self))")
        }
        
        return loadedTexture
    }
}
