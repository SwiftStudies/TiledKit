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

import TKXMLCoding
import Foundation

struct MapLoader : ResourceLoader {
    let project : Project
    
    func retrieve<R>(asType: R.Type, from url: URL) throws -> R {
        guard let loadedResource = try TMXMap.build(in: project, from: url) as? R else {
            throw ResourceLoadingError.unsupportedType(loaderType: "\(type(of: self))", unsupportedType: "\(R.self)")
        }
        return loadedResource

    }
}
