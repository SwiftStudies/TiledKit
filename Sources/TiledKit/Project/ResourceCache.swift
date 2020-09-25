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

class ResourceCache {
    private     var resourceLoaders = [String:ResourceLoader]()
    private     var cache           = [URL:Any]()
    
    init(){
        
    }

    private func typeKey<T>(_ type:T.Type)->String{
        return "\(type)"
    }
    
    func registerLoader<ResourceType>(_ loader:ResourceLoader, forType type:ResourceType.Type){
        resourceLoaders[typeKey(type)] = loader
    }
    
    func retrieve<R>(as type:R.Type, from url:URL, relativeTo baseURL:URL? = nil) throws ->R{
        let typeKey = self.typeKey(type)
        
        if let cachedResource = cache[url] as? R {
            return cachedResource
        }
        
        guard let loader = resourceLoaders[typeKey] else {
            throw ResourceLoadingError.unknownType(unknownType: "\(typeKey)")
        }
        
        let loadedResource = try loader.retrieve(asType: type, from: url)
        cache[url] = loadedResource
        
        return loadedResource
    }
}
