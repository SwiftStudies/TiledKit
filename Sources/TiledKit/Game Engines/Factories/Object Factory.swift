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

/// Tile factories create the sprites that will be rendered for tiles
public protocol ObjectFactory : Factory {
    
    /// Creates a point object
    /// - Parameters:
    ///   - object: The meta-data for the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    func make(pointFor object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.PointObjectType?
    
    /// Creates a rectangle object of the specified size
    /// - Parameters:
    ///   - size: The `Size` of the rectangle
    ///   - angle: The angle the rectangle should be displayed in (in degrees)
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project content is being loaded from
    func make(rectangleOf size:Size, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.RectangleObjectType?

    /// Creates a ellipse object of the specified size
    /// - Parameters:
    ///   - size: The `Size` of the ellipse
    ///   - angle: The angle the ellipse should be displayed in (in degrees)
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project content is being loaded from
    func make(ellipseOf size:Size, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.EllipseObjectType?
    
    /// Creates a sprite for the specified tile
    /// - Parameters:
    ///   - tileId: The Gid of the tile
    ///   - size: The size of the sprite
    ///   - angle: The angle the sprite should be displayed at
    ///   - tiles: The tiles loaded by the map (indexable by GID)
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    func make(spriteWith tileId:TileGID,of size:Size, at angle:Double, with tiles:MapTiles<EngineType>, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.SpriteType?
    
    /// Creates a text object
    /// - Parameters:
    ///   - string: The string to display
    ///   - size: The size of the clipping rectangle of the text
    ///   - angle: The angle the text should be displayed at
    ///   - style: The style the text should be rendered in
    ///   - object: The meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    func make(textWith string:String, of size:Size, at angle:Double, with style:TextStyle, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.TextObjectType?
    
    /// Creates a polyline (non-closed path) object
    /// - Parameters:
    ///   - path: The points of the path
    ///   - angle: The angle the object should be shown at
    ///   - object: Meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    func make(polylineWith path:Path, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.PolylineObjectType?

    /// Creates a polygon (closed path) object
    /// - Parameters:
    ///   - path: The points of the path
    ///   - angle: The angle the object should be shown at
    ///   - object: Meta-data about the object
    ///   - map: The map the object is in
    ///   - project: The project the map was loaded from
    func make(polygonWith path:Path, at angle:Double, for object:ObjectProtocol, in map:Map, from project:Project) throws -> EngineType.PolygonObjectType?

}

/// Adds support for `EngineObjectFactories` to `Engine`
public extension Engine {

    /// Add a new factory to the factories for the `Engine`, new factories are tried first
    /// - Parameter factory: The new factory
    static func register<F:ObjectFactory>(factory:F) where F.EngineType == Self {
        EngineRegistry.insert(
            for: Self.self,
            object: AnyObjectFactory<Self>(wrap:factory)
        )
    }
    
    /// Returns all object factories registered
    /// - Returns: The available object factories for this engine
    internal static func objectFactories() -> [AnyObjectFactory<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}


internal struct AnyObjectFactory<EngineType:Engine> : ObjectFactory {

    let pointFactory : (_ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.PointObjectType?
    
    let rectFactory : (_ size: Size, _ angle: Double, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.RectangleObjectType?
    
    let ellipseFactory : (_ size: Size, _ angle: Double, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.EllipseObjectType?
    
    let tileFactory : (_ tileId: TileGID, _ size: Size, _ angle: Double, _ tiles: MapTiles<EngineType>, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.SpriteType?
    
    let textFactory : (_ string: String, _ size: Size, _ angle: Double, _ style: TextStyle, _ object: ObjectProtocol, _ map: Map,  _ project: Project) throws -> EngineType.TextObjectType?
    
    let polylineFactory : (_ path: Path, _ angle: Double, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.PolylineObjectType?
    
    let polygonFactory : (_ path: Path, _ angle: Double, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.PolygonObjectType?

    init<F:ObjectFactory>(wrap factory:F) where F.EngineType == EngineType {
        pointFactory = factory.make
        rectFactory = factory.make
        ellipseFactory = factory.make
        tileFactory = factory.make
        textFactory = factory.make
        polylineFactory = factory.make
        polygonFactory = factory.make
    }

    func make(pointFor object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.PointObjectType? {
        return try pointFactory(object, map, project)
    }
 
    func make(rectangleOf size: Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.RectangleObjectType? {
        return try rectFactory(size, angle, object, map, project)
    }
    
    func make(ellipseOf size: Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.EllipseObjectType? {
        return try ellipseFactory(size, angle, object, map, project)
    }
    
    func make(spriteWith tileId: TileGID, of size: Size, at angle: Double, with tiles: MapTiles<EngineType>, for object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.SpriteType? {
        return try tileFactory(tileId, size, angle, tiles, object, map, project)
    }
    
    func make(textWith string: String, of size: Size, at angle: Double, with style: TextStyle, for object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.TextObjectType? {
        return try textFactory(string, size, angle, style, object, map, project)
    }
    
    func make(polylineWith path: Path, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.PolylineObjectType? {
        return try polylineFactory(path, angle, object, map, project)
    }
    
    func make(polygonWith path: Path, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> EngineType.PolygonObjectType? {
        return try polygonFactory(path, angle, object, map, project)
    }
    
}
