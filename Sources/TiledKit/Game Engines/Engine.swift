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

/// The entry point for any game engine specialization. See [Game Engine Specialization](../../Game%20Engine%20Specialization.md)
public protocol Engine {
    /// The most common lossless way of expressing a float in the engine
    associatedtype FloatType : ExpressibleAsTiledFloat
    
    /// The type that captures `Color`s in the engine
    associatedtype ColorType : ExpressibleAsTiledColor
    
    /// The type that represents a `Map` in the engine
    associatedtype MapType   : EngineMap where MapType.EngineType == Self
    
    /// The type that represents a texture or bitmap that will be rendered as a Sprite
    associatedtype TextureType : EngineTexture where TextureType.EngineType == Self
    
    /// The type that represents the object that can draw itself on-screen
    associatedtype SpriteType  : EngineObject, DeepCopyable where SpriteType.EngineType == Self

    /// The type that represents a layer of tiles
    associatedtype TileLayerType  : EngineObject where TileLayerType.EngineType == Self

    /// The type that represents a group of other layers
    associatedtype GroupLayerType  : EngineLayerContainer where GroupLayerType.EngineType == Self

    /// The type that represents a layer populated by objects
    associatedtype ObjectLayerType  : EngineObjectContainer where ObjectLayerType.EngineType == Self

    /// The type that represents a point in the engine scene
    associatedtype PointObjectType : EngineObject where PointObjectType.EngineType == Self
    
    /// The type that represents a rectangle in the engine scene
    associatedtype RectangleObjectType : EngineObject where RectangleObjectType.EngineType == Self
    
    /// The type that represents an ellipse in the engine scene
    associatedtype EllipseObjectType : EngineObject where EllipseObjectType.EngineType == Self
        
    /// The type that represents a text object in the engine scene
    associatedtype TextObjectType : EngineObject where TextObjectType.EngineType == Self
    
    /// The type that represents a polyline object in the engine scene
    associatedtype PolylineObjectType : EngineObject where PolylineObjectType.EngineType == Self
    
    /// The type that represents a polygon object in the engine scene
    associatedtype PolygonObjectType : EngineObject where PolygonObjectType.EngineType == Self

    /// Provide a method for loading textures
    static func load(textureFrom url:URL, in project:Project) throws -> TextureType
    
    /// Provide a default specialized map creator for the Engine
    /// - Parameter map: The `Map` to create it for
    static func make(engineMapForTiled map:Map) throws -> MapType
    
    /// Provide a default specialized tile creator for the Engine
    /// - Parameter map: The `Map` to create it for
    /// - Parameter tile: The `Tile` to create a sprite for
    /// - Parameter tileset: The `TileSet` the tile is from
    /// - Parameter texture: The texture (not cropped) to use for the tile
    /// - Parameter project: The `Project` data is being cloaded from
    static func make(spriteFor tile:Tile, in tileset:TileSet, with texture:TextureType, from project:Project) throws ->SpriteType
    
    /// Enables post processing of tiles which is performed after all tiles for a tileset have been created. It will be called _before_ any other registered
    ///  `TilePostProcessor`
    /// - Parameters:
    ///   - sprite: The previously created `SpriteType`
    ///   - tile: The `Tile` it was created from
    ///   - tileSet: The `TileSet` the tile belongs to
    ///   - setSprites: All other sprites created for the `TileSet`
    ///   - map: The map the `TileSet`s were loaded from
    ///   - project: The project the `Map`& `TileSet` was loaded from
    static func postProcess(_ sprite:SpriteType, from tile:Tile, in tileSet:TileSet, with setSprites:[UInt32:SpriteType], for map:Map, from project:Project) throws ->SpriteType
    
    /// Creates a sprite for the supplied image layer
    /// - Parameters:
    ///   - texture: The texture to use
    ///   - layer: The additional data from the layer
    ///   - map: The map the layer is part of
    ///   - project: The project the map is being loaded from
    static func makeSpriteFrom(_ texture:TextureType, for layer:LayerProtocol, in map:Map, from project:Project) throws -> SpriteType?
    
    /// Creates a layer to contain objects
    /// - Parameters:
    ///   - layer: The additional data from the layer
    ///   - map: The map the layer is part of
    ///   - project: The project the map is being loaded from
    static func makeObjectContainer(_ layer:LayerProtocol,in map:Map, from project:Project) throws -> ObjectLayerType?
    
    /// Creates a layer containing other layers
    /// - Parameters:
    ///   - layer: The details of the grouping layer
    ///   - map: The `Map` the layer belongs to
    ///   - project: The project the map is being loaded from
    static func makeGroupLayer(_ layer:LayerProtocol,in map:Map, from project:Project) throws -> GroupLayerType?
    
    /// Creates a tile layer with the supplied tiles in using the sprites loaded during map building
    /// - Parameters:
    ///   - tileGrid: The grid of tiles to present
    ///   - layer: The meta data about the layer
    ///   - sprites: The sprites (indexed by gid) that can be used
    ///   - map: The map the layer is in
    ///   - project: The project the layer is loaded from
    static func makeTileLayerFrom(_ tileGrid:TileGrid, for layer:LayerProtocol, with sprites:MapTiles<Self>, in map:Map, from project:Project) throws -> TileLayerType?
    
    /// Creates a point object
    /// - Parameters:
    ///   - object: The meta-data for the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    static func make(pointFor object:ObjectProtocol, in map:Map, from project:Project) throws -> PointObjectType
    
    /// Creates a rectangle object of the specified size
    /// - Parameters:
    ///   - size: The `Size` of the rectangle
    ///   - angle: The angle the rectangle should be displayed in (in degrees)
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project content is being loaded from
    static func make(rectangleOf size:Size, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> RectangleObjectType

    /// Creates a ellipse object of the specified size
    /// - Parameters:
    ///   - size: The `Size` of the ellipse
    ///   - angle: The angle the ellipse should be displayed in (in degrees)
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project content is being loaded from
    static func make(ellipseOf size:Size, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EllipseObjectType
    
    /// Creates a sprite for the specified tile
    /// - Parameters:
    ///   - tile: The tile node to place/change
    ///   - size: The size of the sprite
    ///   - angle: The angle the sprite should be displayed at
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    static func make(spriteWith tile:SpriteType,of size:Size, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> SpriteType
    
    /// Creates a text object
    /// - Parameters:
    ///   - string: The string to display
    ///   - size: The size of the clipping rectangle of the text
    ///   - angle: The angle the text should be displayed at
    ///   - style: The style the text should be rendered in
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    static func make(textWith string:String, of size:Size, at angle:Double, with style:TextStyle, for object:ObjectProtocol, in map:Map, from project:Project) throws -> TextObjectType
    
    /// Creates a polyline (non-closed path) object
    /// - Parameters:
    ///   - path: The points of the path
    ///   - angle: The angle the object should be shown at
    ///   - object: Meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    static func make(polylineWith path:Path, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> PolylineObjectType

    /// Creates a polygon (closed path) object
    /// - Parameters:
    ///   - path: The points of the path
    ///   - angle: The angle the object should be shown at
    ///   - object: Meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    static func make(polygonWith path:Path, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> PolygonObjectType
}

/// By implementing this protocol (required for `Engine.TextureType`
/// loading behaviour except the actual loading of the texture data will be
/// provided
public protocol EngineTexture : EngineObject,Loadable {

}

/// Provides default implementations ensuring textures are cached, and
/// a simplified loader is used
public extension EngineTexture {
    var cache: Bool {
        return true
    }
    
    /// Returns the default loader for the `Engine` simplifying what has to be
    /// implemented
    /// - Parameter project: The project the texture is refered to from
    /// - Returns: The `ResourceLoader` that knows how  to load the texture
    static func loader(for project: Project) -> ResourceLoader {
        return EngineTextureLoader<EngineType>(project)
    }
}

/// An object that can create new instances that are deep copies of itself
public protocol DeepCopyable {
    /// Create a deep copy of the object, returning a new instance
    /// Unlike new instance, a new copy should always be returned
    func deepCopy()->Self
}

/// Provides common diagnostic capabilites to any engine specialization
public extension Engine {
    
    /// Removes all factories that have been registered for the engine
    static func removeAllFactoriesAndPostProcessors() {
        EngineRegistry.removeAll(from: Self.self)
    }
        
    /// Displays a warning message to the console. You can override to display the messages
    /// more prominantly in the engine of your chosing. 
    static func warn(_ message:String){
        print("Warning: \(message)")
    }
}
