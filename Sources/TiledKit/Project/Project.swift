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
    case noResourceLoaderSpecified
}

public class Project {
    let fileContainer   : FileContainer
    let folders         : [String]
    let objectTypes     : [String:String]
    var resourceCache   = ResourceCache()
    

    public static let `default` : Project = Project(at: Bundle.main.bundleURL)

    public init(using bundle:Bundle, with folders:[String]? = nil, and types:[String:String]? = nil){
        fileContainer = FileContainer.bundle(bundle)
        self.folders = folders ?? [String]()
        objectTypes = types ?? [String:String]()
        
        resourceCache.registerLoader(MapLoader(project: self), forType: Map.self)
        resourceCache.registerLoader(TileSetLoader(project: self), forType: TKTileSet.self)
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
    
    /// Resources a url within the project, if it may be relative, then you should supply the URL it is relative to
    /// - Parameters:
    ///   - url: The `URL` to be resolved (it does not need to be in the project if it is a fully specified URL)
    ///   - relativeTo: If the URL could be or is relative, then this will be used as the base
    /// - Returns: A URL or nil if the the URL is not reachable
    public func url(`for` url:URL, relativeTo baseUrl:URL?)->URL?{
        // Start with any relative URL
        if let baseURL = baseUrl {
            if let url = url.url(relativeTo: baseURL) {
                return url
            }
        }
        
        // Now look within the project itself
        if let url = url.url(relativeTo: self.fileContainer.baseUrl) {
            if url.isReachable {
                return url
            }
        }
        
        // If it's an image resource, perhaps it's in a bundle and has been processed
        if let fileType = FileTypes(rawValue: url.lastPathComponent), fileType.isImage {
            if let url = self.url(for: url.deletingPathExtension().lastPathComponent, in: nil, of: fileType), url.isReachable {
                return url
            }
        }
        
        // If I can't find it within the project then give up
        if url.isReachable {
            return url
        }
        return nil
    }
    
    public func retrieve<R>(asType:R.Type, from url:URL, relativeTo baseUrl:URL? = nil) throws ->R{
        guard let resolvedUrl = self.url(for: url, relativeTo: baseUrl) else {
            throw ProjectError.fileDoesNotExist(url.standardized.absoluteString)
        }
        return try resourceCache.retrieve(as: R.self, from: resolvedUrl)

    }
    
    public func get(map fileName:String, in subDirectory:String? = nil) throws -> Map {
        guard let url = url(for: fileName, in: subDirectory, of: .tmx) else {
            throw ProjectError.fileDoesNotExist("\(fileContainer)\(subDirectory ?? "")\\(fileName)")
        }
        
        return try resourceCache.retrieve(as: Map.self, from: url)
    }
}

fileprivate extension URL {
    var isReachable : Bool {
        return (try? checkResourceIsReachable()) ?? false
    }
    
    var isRelative : Bool {
        return relativeString.hasPrefix("..")
    }
    
    func url(relativeTo baseURL:URL)->URL?{
        let relativePathComponents = relativeString.split(separator: "/")
        var baseURL = baseURL
        
        if baseURL.pathExtension != "" {
            baseURL = baseURL.deletingLastPathComponent()
        }
        
        var firstNonRelativeComponent = 0
        for pathComponent in relativePathComponents where pathComponent == ".." {
            firstNonRelativeComponent += 1
            baseURL = baseURL.deletingLastPathComponent()
        }
        
        for pathComponent in relativePathComponents[firstNonRelativeComponent..<relativePathComponents.count] {
            baseURL = baseURL.appendingPathComponent(String(pathComponent))
        }
        
        if !baseURL.isReachable {
            return nil
        }
        
        return baseURL
    }
}
