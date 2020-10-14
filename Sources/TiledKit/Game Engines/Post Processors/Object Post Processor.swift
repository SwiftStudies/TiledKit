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

/// A specialized form of a `PostProcessor` that applies to `Tile`s. It is called after the first factory
/// has created the specialized sprite for the tile
public protocol ObjectPostProcessor : PostProcessor {
    
    /// Perform post processing on a point object
    /// - Parameters:
    ///   - point: The point to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ point:EngineType.PointObjectType, from object:ObjectProtocol,  for map:Map, from project:Project) throws -> EngineType.PointObjectType
    
    /// Perform post processing on a rectangle object
    /// - Parameters:
    ///   - rectangle: The rectangle to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ rectangle:EngineType.RectangleObjectType, from object:ObjectProtocol, for map:Map, from project:Project) throws -> EngineType.RectangleObjectType

    /// Perform post processing on a ellipse object
    /// - Parameters:
    ///   - ellipse: The ellipse to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ ellipse:EngineType.EllipseObjectType, from object:ObjectProtocol, for map:Map, from project:Project) throws -> EngineType.EllipseObjectType

    /// Perform post processing on a sprite  object created for a tile
    /// - Parameters:
    ///   - sprite: The sprite to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ sprite:EngineType.SpriteType, from object:ObjectProtocol, for map:Map, from project:Project) throws -> EngineType.SpriteType

    /// Perform post processing on a text object
    /// - Parameters:
    ///   - text: The text to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ text:EngineType.TextObjectType, from object:ObjectProtocol, for map:Map, from project:Project) throws -> EngineType.TextObjectType

    /// Perform post processing on a polyline object
    /// - Parameters:
    ///   - polyline: The polyline to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ polyline:EngineType.PolylineObjectType, from object:ObjectProtocol, for map:Map, from project:Project) throws -> EngineType.PolylineObjectType

    /// Perform post processing on a polygon object
    /// - Parameters:
    ///   - polygon: The polygon to be processed
    ///   - object: The object it was created from
    ///   - map: The map it is in
    ///   - project: The project the map was loaded from
    func process(_ polygon:EngineType.PolygonObjectType, from object:ObjectProtocol, for map:Map, from project:Project) throws -> EngineType.PolygonObjectType
    
}

/// Adds support for `TilePostProcessor`s  to `Engine`
public extension Engine {

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter postProcessor: The new post processor
    static func register<P:ObjectPostProcessor>(postProcessor:P) where P.EngineType == Self {
        EngineRegistry.insert(
            for: Self.self,
            object: AnyObjectPostProcessor<Self>(wrap:postProcessor)
        )
    }
    
    /// Returns all engine map factories registered
    /// - Returns: The available tile post processors for this engine
    internal static func engineObjectPostProcessors() -> [AnyObjectPostProcessor<Self>] {
        return  EngineRegistry.get(for: Self.self)
    }
}

internal struct AnyObjectPostProcessor<EngineType:Engine> : ObjectPostProcessor {

    let pointProcessor : (_ point: EngineType.PointObjectType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.PointObjectType
    let rectangleProcessor : (_ rectangle: EngineType.RectangleObjectType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.RectangleObjectType
    let ellipseProcessor : (_ ellipse: EngineType.EllipseObjectType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.EllipseObjectType
    let spriteProcessor : (_ sprite: EngineType.SpriteType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.SpriteType
    let textProcessor : (_ text: EngineType.TextObjectType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.TextObjectType
    let polylineProcessor : (_ polyline: EngineType.PolylineObjectType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.PolylineObjectType
    let polygonProcessor : (_ polygon: EngineType.PolygonObjectType, _ object: ObjectProtocol, _ map: Map, _ project: Project) throws -> EngineType.PolygonObjectType
    
    init<F:ObjectPostProcessor>(wrap factory:F) where F.EngineType == EngineType {
        pointProcessor = factory.process
        rectangleProcessor = factory.process
        ellipseProcessor = factory.process
        spriteProcessor = factory.process
        textProcessor = factory.process
        polylineProcessor = factory.process
        polygonProcessor = factory.process
    }
    
    func process(_ point: EngineType.PointObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.PointObjectType {
        return try pointProcessor(point, object, map, project)
    }
    
    func process(_ rectangle: EngineType.RectangleObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.RectangleObjectType {
        return try rectangleProcessor(rectangle, object, map, project)
    }
    
    func process(_ ellipse: EngineType.EllipseObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.EllipseObjectType {
        return try ellipseProcessor(ellipse, object, map, project)
    }
    
    func process(_ sprite: EngineType.SpriteType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.SpriteType {
        return try spriteProcessor(sprite, object, map, project)
    }
    
    func process(_ text: EngineType.TextObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.TextObjectType {
        return try textProcessor(text, object, map, project)
    }
    
    func process(_ polyline: EngineType.PolylineObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.PolylineObjectType {
        return try polylineProcessor(polyline, object, map, project)
    }
    
    func process(_ polygon: EngineType.PolygonObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> EngineType.PolygonObjectType {
        return try polygonProcessor(polygon, object, map, project)
    }
}
