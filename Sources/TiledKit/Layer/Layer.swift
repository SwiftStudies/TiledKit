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

/// Layers capture the contents of a `Map` can be one of four kinds
///
///  - __Tile__ A grid of `Tile`s
///  - __ Object__ A collection of `Object`s
///  - __Group__ A collection of `Layer`s enabling hierarchy within the `Map`
///  - __Image__ An image not in a `TileSet`
///
/// Every layer has a set of common attributes (such as an offest) and can capture user specified properites too.
public struct Layer : Propertied {
    
    /// An enumeration for each kind of layer, together with the specifc information about that kind of layer (e.g. the `ImageReference` for an Image Layer
    public enum Kind {
        /// Provides a  grid of `Tile`s in a `TileGrid`
        case tile(TileGrid)
        
        /// Provides an `Array` of `Objects`
        case objects([Object])
        
        /// Provides a `Group` of child `Layer`s
        case group(Group)
        
        /// Provides an `ImageReference` to an image
        case image(ImageReference)
    }
    
    /// The name of the layer, or an empty `String` if non was specified
    public let name    : String
    
    /// `true` if the layer should be visible
    public let visible : Bool
    
    /// A level of transparent the layer (and therefore its contents) should be rendered with
    public let opacity : Double
    
    /// An offset from the `Layer`s parent's origin
    public let position: Position
    
    /// The `Layer.Kind` of the `Layer` together with the information specific to that kind
    public let kind    : Kind
    
    /// User specified `Properties` of the layer
    public var properties : Properties
    
    
    /// The `Object`s contained in the `Layer`. Will be an empty `Array` if it is not an object `Layer`
    public var objects : [Object] {
        switch kind {
        case .objects(let objects):
            return objects
        default:
            return [Object]()
        }
    }
}
