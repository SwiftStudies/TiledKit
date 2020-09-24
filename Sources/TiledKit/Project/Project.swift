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
import TKXMLCoding

enum ProjectError : Error {
    case fileDoesNotExist(String)
}

public class Project {
    let fileContainer   : FileContainer
    let folders         : [String]
    let objectTypes     : [String:String]

    public static let `default` : Project = Project(at: Bundle.main.bundleURL)

    public init(using bundle:Bundle, with folders:[String]? = nil, and types:[String:String]? = nil){
        fileContainer = FileContainer.bundle(bundle)
        self.folders = folders ?? [String]()
        objectTypes = types ?? [String:String]()
    }

    
    public init(at url:URL, with folders:[String]? = nil, and types:[String:String]? = nil){
        fileContainer = FileContainer.folder(url)
        self.folders = folders ?? [String]()
        objectTypes = types ?? [String:String]()
    }
    
    public func url(for file:String, in subDirectory:String? = nil, of type:FileTypes? = nil) -> URL? {
        guard let type = type else {
            return fileContainer.url(of: file, in: subDirectory)
        }
        
        // Try the rote adding of extensions and literal use of folders
        for `extension` in type.extensions {
            if let url = fileContainer.url(of: file, in: subDirectory, with: `extension`){
                if FileManager.default.fileExists(atPath: url.standardizedFileURL.path) {
                    return url
                }
            }
        }
        
        // If this failed and it's an image type it's possible that the file has been processed and we need to ignore the subdirectory
        if type.isImage {
            for `extension` in type.extensions {
                if let url = fileContainer.url(of: file, in: nil, with: `extension`){
                    if FileManager.default.fileExists(atPath: url.standardizedFileURL.path) {
                        return url
                    }
                }
            }
        }
        
        return nil
    }
    
    public func get(map fileName:String, in subDirectory:String? = nil) throws -> Map {
        guard let url = url(for: fileName, in: subDirectory, of: .tmx) else {
            throw ProjectError.fileDoesNotExist("\(fileContainer)\(subDirectory ?? "")\\(fileName)")
        }
        
        return try TMXMap.build(in: self, from: url)
    }
}
