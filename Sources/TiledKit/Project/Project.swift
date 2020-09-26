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

/// Projects are the primary entry point for `TiledKit`. The project represents the root of all `Map`s and `TileSet`s and the resources (such as images) that support them.
/// The default `Project` will use the `main` Bundle as its root, making it very easy to include in a Swift Package Manager or Xcode module.
///
///         let myMap = Project.default.get("mymap")
///
/// The above code will retrieve a file named 'mymap.tmx' from the root of the main `Bundle`. You may create instances of `Project`s that have a different root (such as an
/// actual Tiled project directory, or different `Bundle`) using the standard constructurs.
///
/// `Project`s are critical as they enable the relative processing of any resources referenced in the Tiled files and provide the key entry point for specializing TiledKit for a
/// a specific game engine. Specializations only require the registration of a specific `ResourceLoader` for the type of object required by the game engine. See
///  [SKTiledKit](https://github.com/SwiftStudies/SKTiledKit) for an example of a specialization.
///
/// `Project`s also provide resource caching capabilities, ensuring that the contents of any `URL` are loaded only once. If you add your own `ResourceLoader` for types
/// you can specify that if the created object should be cached or not.
public class Project {
    let fileContainer   : FileContainer
    let folders         : [String]
    let objectTypes     : [String:String]
    var resourceCache   = ResourceCache()
    

    /// The default `Project` which uses the `Bundle.main` as its resource root
    public static let `default` : Project = Project(at: Bundle.main.bundleURL)

    
    /// Creates a new instance of a `Project` that uses a different bundle as a root.
    ///
    /// - Parameters:
    ///   - bundle: The `Bundle` to use
    public init(using bundle:Bundle){
        fileContainer = FileContainer.bundle(bundle)
        folders = []
        objectTypes = [:]
        
        resourceCache.registerLoader(MapLoader(project: self), forType: Map.self)
        resourceCache.registerLoader(TileSetLoader(project: self), forType: TileSet.self)
    }

    /// Creates a new instance of a `Project` that uses the specied directory as its root
    ///
    /// - Parameter rootDirectory: The `URL` of a directory on the local machine
    public init(at rootDirectory:URL){
        fileContainer = FileContainer.folder(rootDirectory)
        folders = []
        objectTypes = [:]
    }
    
    
    /// Retrieves the `URL` for a resource within the project
    /// - Parameters:
    ///   - file: The name of the file, excluding any extension
    ///   - subDirectory: The sub-directory path if it is not located at the root
    ///   - type: The type of file
    /// - Returns: A `URL` for the file in the `Project` or `nil` if it could not be found
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
    public func resolve(_ url:URL, relativeTo baseUrl:URL?)->URL?{
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
    
    
    /// Loads a URL for a resource (which can be relative to another resource in the project, very useful as Tiled often uses relative paths within projects, or across Maps and Tile Sets).
    /// - Parameters:
    ///   - asType: The desired type
    ///   - resourceUrl: The `URL` of the resource (can be relative)
    ///   - baseUrl: The `URL` to use as the starting point if `resourceURL` is relative. Otherwise the project root will be used
    /// - Throws: Any errors thrown while the resource is being retreived (for example, the resource can't be found)
    /// - Returns: An instance of the resource
    public func retrieve<R>(asType:R.Type, from resourceUrl:URL, relativeTo baseUrl:URL? = nil) throws ->R{
        guard let resolvedUrl = resolve(resourceUrl, relativeTo: baseUrl) else {
            throw ProjectError.fileDoesNotExist(resourceUrl.standardized.absoluteString)
        }
        return try resourceCache.retrieve(as: R.self, from: resolvedUrl)

    }
    
    /// Gets a map from the project.
    /// - Parameters:
    ///   - fileName: The filename (excluding the extension) of the map
    ///   - subDirectory: The subdirectory (if any, supply `nil` if the map is in the root of the project) of the map.
    /// - Throws: Any error while loading the map
    /// - Returns: An instance of the `Map`
    @available(*, deprecated, message: "Use retreive(Map.self, from: url(fileName,subDirectory)) instead")
    public func get(_ fileName:String, in subDirectory:String? = nil) throws -> Map {
        guard let url = url(for: fileName, in: subDirectory, of: .tmx) else {
            throw ProjectError.fileDoesNotExist("\(fileContainer)\(subDirectory ?? "")\\(fileName)")
        }
        
        return try resourceCache.retrieve(as: Map.self, from: url)
    }
}

fileprivate extension URL {
    var isReachable : Bool {
        do {
            let reachable = try checkResourceIsReachable()
            return reachable
        } catch {
            return false
        }
    }
    
    var isRelative : Bool {
        return relativeString.hasPrefix("..")
    }
    
    func url(relativeTo baseURL:URL)->URL?{
        let relativePathComponents = relativeString.split(separator: "/").map({String($0).removingPercentEncoding ?? String($0)})
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
