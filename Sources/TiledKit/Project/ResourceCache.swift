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

/// Add's a new initializer that is used for identifying in memory assets that should be cached and restored
public extension URL {
    /// The name for the protocol to use to identify in memory resources
    internal static var tiledKitResouceCacheScheme : String {
        return "tkrc"
    }
    
    internal var isInMemoryResource : Bool {
        return scheme ?? "Unknown" == URL.tiledKitResouceCacheScheme
    }
    
    
    /// Creates a new instance of a URL intended for retrieving in memory objects from a TiledKit `Project`'s
    /// cache
    ///
    /// - Parameter path: The elements of the `URL`'s path that will be used to reference the object
    init?(inMemory path:String ...){
        
        let objectPath = path.reduce("\(URL.tiledKitResouceCacheScheme)://", {
            "\($0)/\($1)"
        })
        
        self.init(string: objectPath)
    }
}

class ResourceCache {
    internal    var project         : Project? = nil
    private     var resourceLoaders = [String:ResourceLoader]()
    private     var cache           = [URL:Loadable]()
    
    init(){
    }

    private func typeKey<T>(_ type:T.Type)->String{
        return "\(type)"
    }
    
    func registerLoader<ResourceType:Loadable>(_ loader:ResourceLoader, forType type:ResourceType.Type){
        resourceLoaders[typeKey(type)] = loader
    }
    
    /// Stores an asset in the `ResourceCache` for later retreival via the supplied `URL`. In this way `ResourceLoaders` can exploit the ability
    /// to create common cached assets. A `ResourceLoader` will not be created (or needed if every `URL` is cached as they are created lazily.
    /// - Parameters:
    ///   - asset: The asset
    ///   - assetUrl: The URL of the asset/resource
    public func store<R:Loadable>(_ asset:R, as assetUrl:URL) {
        cache[assetUrl] = asset
    }

    
    func retrieve<R:Loadable>(as type:R.Type, from url:URL, relativeTo baseURL:URL? = nil) throws ->R{
        let typeKey = self.typeKey(type)
        
        if let cachedResource = cache[url] as? R {
            return cachedResource
        }

        let loader : ResourceLoader
        if let existingLoader = resourceLoaders[typeKey] {
            loader = existingLoader
        } else {
            guard let project = project else {
                throw ResourceLoadingError.noProjectSpecifiedForResourceCache
            }
            loader = R.loader(for: project)
            registerLoader(loader, forType: R.self)
        }
                
        let loadedResource = try loader.retrieve(asType: type, from: url)
        
        // Only cache if appropriate
        if loadedResource.cache {
            cache[url] = loadedResource
        }
        
        return loadedResource.newInstance()
    }
}
