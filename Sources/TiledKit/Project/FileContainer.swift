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

fileprivate extension URL {
    var isImageFile : Bool {
        switch pathExtension {
        case "png","gif","tif","apng","jpg","jpeg","svg","pdf":
            return true
        default:
            return false
        }
    }
}

enum FileContainer {
    case bundle(Bundle)
    case folder(URL)
    case project(URL)
    
    var baseUrl : URL {
        switch self {
        case .project(let projectFileUrl):
            return projectFileUrl.deletingLastPathComponent()
        case .bundle(let bundle):
            return bundle.bundleURL
        case .folder(let url):
            return url
        }
    }
    
    func url(of file:String, in subDirectory:String? = nil, with extension:String? = nil) -> URL?{
        switch self {
        case .project:
            return FileContainer.folder(baseUrl).url(of: file, in: subDirectory, with: `extension`)
        case .bundle(let bundle):
            if let subDirectory = subDirectory {
                return bundle.url(forResource: file, withExtension: `extension`, subdirectory: subDirectory)
            } else {
                return bundle.url(forResource: file, withExtension: `extension`)
            }
        case .folder(let url):
            var url = url
            if let subDirectory = subDirectory {
                url = url.appendingPathComponent(subDirectory, isDirectory: true)
            }
            if let `extension` = `extension` {
                return url.appendingPathComponent("\(file).\(`extension`)")
            }
            return url.appendingPathComponent(file)
        }
    }
}
