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

/// Captures an object that is important for a given game engine (and will be involved in automated maping etc). In general only
/// game engine types that map directly to Tiled entities will need to support this
public protocol EngineObject {
    /// The specific game engine the object supports
    associatedtype EngineType : Engine
}

/// Container that can contain objects
public protocol EngineObjectContainer : EngineObject {
    
    /// Adds a point to the container
    /// - Parameter point: The point to add
    func add(child point:EngineType.PointObjectType)
    
    /// Adds a rectangle to the container
    /// - Parameter rectangle: The rectangle to add
    func add(child rectangle:EngineType.RectangleObjectType)
    
    /// Adds an ellipse to the container
    /// - Parameter ellipse: The ellipse to add
    func add(child ellipse:EngineType.EllipseObjectType)
    
    /// Adds a sprite to the container
    /// - Parameter sprite: The sprite to add
    func add(child sprite:EngineType.SpriteType)
    
    /// Adds text to the container
    /// - Parameter text: The text to add
    func add(child text:EngineType.TextObjectType)
    
    /// Adds a polyline to the container
    /// - Parameter polyline: The polyline to add
    func add(child polyline:EngineType.PolylineObjectType)
    
    /// Adds a polygon to the container
    /// - Parameter polygon: The polygon to add
    func add(child polygon:EngineType.PolygonObjectType)
}

/// Layer containers can contain other elements or layers.
public protocol EngineLayerContainer : EngineObject {
    
    /// Adds a tile layer to the container
    /// - Parameter layer: The layer to add
    func add(child layer:EngineType.TileLayerType)

    /// Adds a group layer to the container
    /// - Parameter layer: The layer to add
    func add(child layer:EngineType.GroupLayerType)
    
    /// Adds a sprite to the container
    /// - Parameter layer: The sprite to add
    func add(child sprite:EngineType.SpriteType)
    
    /// Adds an object layer to the container
    /// - Parameter layer: The layer to add
    func add(child layer:EngineType.ObjectLayerType)
}
