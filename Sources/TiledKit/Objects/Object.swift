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

/// Represents a Tiled object (which are contained inside Object `Layer`s). All objects share some common attributes (e.g. their position inside their containing `Layer`).
public struct Object : MutablePropertied {
    /// The kind of object, together with attached data specific to that kind of object
    public enum Kind {
        /// The object is a single point (use the `position` property for its coordinate
        case point
        
        /// A rectangle (with origin at `position`) of the specied `Size` and `angle` (in degrees)
        case rectangle(Size, angle:Double)
                
        /// An ellipse  (with origin at `position`) of the specied `Size` and `angle` (in degrees)
        case ellipse(Size, angle:Double)
        
        /// A reference to a `Map` `Tile` (you must used the `Map` to retreive the correct tile) and a specied `angle` (in degrees) to draw it at
        case tile(TileGID, size:Size, angle:Double)
                
        /// a `String` to render within the specied `Size`, at the specified `angle` (in degrees). The `TextStyle` defines the `style` that should be used to
        /// render the `String`
        case text(String, size:Size, angle:Double, style:TextStyle)
                
        /// A closed polygon  (with origin at `position`) with the specied `Path` and `angle` (in degrees)
        case polygon(Path, angle:Double)
        
        
        /// An open polygon  (with origin at `position`) with the specied `Path` and `angle` (in degrees)
        case polyline(Path, angle:Double)
    }
    
    /// An identifier for an `Object` that is unique with the `Map`
    public let id      : Int
    
    /// The name of the `Object`, or an empty `String`
    public let name    : String
    
    /// `true` if the `Object` should be rendered
    public let visible : Bool
    
    /// The location of the `Object` relative to its containing `Layer`
    public let position: Position
    
    /// User specified properties of the `Object`
    public var properties: Properties
    
    /// The type of `Object` together with any type specific attributes
    public let kind    : Kind
}
