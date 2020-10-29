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
import TiledKit

#warning("Temporary Solution until https://bugs.swift.org/browse/SR-13714 is fixed and I can reference TiledResources from here")
protocol ResourceContainer {
    static var url : URL { get }
}

protocol ProjectResource {
    static var project : ResourceContainer.Type { get }
}

protocol Resource {
    var url : URL { get }
}

protocol TileSetResource : Resource, ProjectResource {
}

protocol MapResource : Resource, ProjectResource {
    
}

extension TileSetResource {
    func load<O:TileSet>() throws -> O {
        return try Project(at: Self.project.url).retrieve(asType: O.self, from: url)
    }
}

extension MapResource {
    func load() throws -> Map {
        return try Project(at: Self.project.url).retrieve(asType: Map.self, from: url)
    }
    
    func load<E:Engine>(for engine:E.Type) throws ->E.MapType {
        return try Project(at: Self.project.url).retrieve(asType: E.MapType.self, from: url)
    }
}

fileprivate struct ResourceInstance : Resource{
    var url : URL
}

extension Resource where Self : RawRepresentable, Self.RawValue == String, Self : ResourceContainer {
    var url : URL {
        return Self.url.appendingPathComponent(rawValue)
    }
}

struct TiledResources {
    static let rootURL = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent(".build/checkouts/TiledResources/Sources/TiledResources")
    
    struct GenericTiledProject : ResourceContainer {
        static var url : URL {
            return TiledResources.rootURL.appendingPathComponent("Generic Tiled Project")
        }
                
        static let projectFile : Resource = ResourceInstance(url: url.appendingPathComponent("Generic Tiled Project.tiled-project"))
        static let objectTypesFile : Resource = ResourceInstance(url: url.appendingPathComponent("Object Types.xml"))
        
        enum Maps : String, CaseIterable, ResourceContainer, MapResource {
            static var project: ResourceContainer.Type {
                return GenericTiledProject.self
            }
            static var url : URL {
                return GenericTiledProject.url.appendingPathComponent("Maps")
            }
            case topDown2D = "2D Top Down.tmx", isometric = "Isometric.tmx", testMap1 = "Test Map 1.tmx", testMap2 = "Test Map 2.tmx"
            case oneOfEverything = "One of Everything.tmx"
        }
        
        enum TileSets : String, CaseIterable, ResourceContainer, TileSetResource {
            static var project: ResourceContainer.Type {
                return GenericTiledProject.self
            }
            
            static var url : URL {
                return GenericTiledProject.url.appendingPathComponent("TileSets")
            }
            case animation = "Animation.tsx", isometric="Isometric.tsx"
            case topDownNoMarginNoSpacing = "Top Down [Sheet M-0 S-0].tsx", topDownMarginAndSpacing = "Top Down [Sheet M-4 S-4].tsx"
            case alphabet = "Alphabet.tsx", singleTile = "Single Tile.tsx"
        }
    }
}
