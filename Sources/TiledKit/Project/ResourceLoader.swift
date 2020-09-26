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

enum ResourceLoadingError : Error {
    case unknownType(unknownType:String)
    case unsupportedType(loaderType:String, unsupportedType:String)
    case noProjectSpecifiedForResourceCache
}

/// You can extend the range of resources and even the way resources are loaded by implementing your own `ResourceLoader`.
public protocol ResourceLoader {
    
    
    /// Retreives a resource of the specied type from the specified `URL`. The returned object will be cached
    /// - Parameters:
    ///   - asType: The type that the `ResourceLoader` should retreive
    ///   - url: The `URL` of the resource
    func retrieve<R:Loadable>(asType:R.Type, from url:URL) throws ->R
}
