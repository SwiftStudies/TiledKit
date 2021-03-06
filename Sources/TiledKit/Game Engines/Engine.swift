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
    associatedtype TileLayerType  : EngineSpriteContainer where TileLayerType.EngineType == Self

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

    /// The prefix for the engine, used for engine object type generation
    static var prefix : String { get }
    
    /// The specialized Tiled object types for the Engine
    static var objectTypes : ObjectTypes { get }
    
    /// Register any default factories or post-processors
    static func registerProducers()
    
    /// Provide a method for loading textures, should not be called directly as it is intended to provide a point for a specific `Engine`
    /// specialization to provide concrete low-level loading behaviour.
    /// - Parameters:
    ///   - url: The location of the image
    ///   - loader: The loader object, this will be supplied by the `Engine` (not a specific implementation of it).
    static func load<LoaderType:EngineImageLoader>(textureFrom url:URL, by loader:LoaderType) throws -> TextureType

    /// Make an instance of a given texture given the supplied clipping bounds and properites for this instance
    static func make(texture:TextureType, with bounds:PixelBounds?, and properties:Properties, in project:Project) throws -> TextureType

    
    /// Provide a default specialized map creator for the Engine
    /// - Parameter map: The `Map` to create it for
    static func make(mapFor tiledMap:Map) throws -> MapType
    
    /// Hook for specializations to provide post processing actvities
    /// - Parameters:
    ///   - specializedMap: The specialized map created by a factory or the engine
    ///   - tiledMap: The tiled map it was created from
    ///   - project: The project it is being loaded from
    static func process(engineMap specializedMap:MapType, for tiledMap:Map, in project:Project) throws -> MapType 
    
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
    ///   - tileset: The `TileSet` the tile belongs to
    ///   - setSprites: All other sprites created for the `TileSet`
    ///   - map: The map the `TileSet`s were loaded from
    ///   - project: The project the `Map`& `TileSet` was loaded from
    static func process(_ sprite:SpriteType, from tile:Tile, in tileset:TileSet, with setSprites:[UInt32:SpriteType], for map:Map, from project:Project) throws ->SpriteType
    
    /// Creates a sprite for the supplied image layer
    /// - Parameters:
    ///   - texture: The texture to use
    ///   - layer: The additional data from the layer
    ///   - map: The map the layer is part of
    ///   - project: The project the map is being loaded from
    static func make(spriteFrom texture:TextureType, for layer:LayerProtocol, in map:Map, from project:Project) throws -> SpriteType?
    
    /// Creates a layer to contain objects
    /// - Parameters:
    ///   - layer: The additional data from the layer
    ///   - map: The map the layer is part of
    ///   - project: The project the map is being loaded from
    static func make(objectContainerFrom layer:LayerProtocol,in map:Map, from project:Project) throws -> ObjectLayerType?
    
    /// Creates a layer containing other layers
    /// - Parameters:
    ///   - layer: The details of the grouping layer
    ///   - map: The `Map` the layer belongs to
    ///   - project: The project the map is being loaded from
    static func make(groupFrom layer:LayerProtocol,in map:Map, from project:Project) throws -> GroupLayerType?
    
    /// Creates a tile layer with the supplied tiles in using the sprites loaded during map building
    /// - Parameters:
    ///   - layer: The meta data about the layer
    ///   - sprites: The sprites (indexed by gid) that can be used
    ///   - map: The map the layer is in
    ///   - project: The project the layer is loaded from
    static func make(tileLayer layer:LayerProtocol, with sprites:MapTiles<Self>, in map:Map, from project:Project) throws -> TileLayerType?

    /// Called for each tile in a tile layer. The position in the layer is supplied in Tiled coordinates
    /// - Parameters:
    ///   - tile: A new instance of the tile representation in your specific game engine
    ///   - position: The location, in tiled coordinates, to position the tile at
    ///   - tileLayer: The tile layer containing the tile
    ///   - map: The map containing the tile layer
    ///   - project: The project containing the map
    static func make(tileWith tile:SpriteType, at position:Position, orientation flip:TileFlip, for tileLayer:LayerProtocol, in map:Map, from project:Project) throws -> SpriteType
    
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


/// Provides common diagnostic capabilites to any engine specialization
public extension Engine {
    /// Displays a warning message to the console. You can override to display the messages
    /// more prominantly in the engine of your chosing. This is a default implementation that just
    /// prints the output to the console. Specific engines may want to display more prominently.
    /// - Parameter message: The message to display.
    static func warn(_ message:String){
        print("Warning: \(message)")
    }
    
    /// TK is provided as the default prefix.
    static var prefix : String {
        return "TK"
    }
}
