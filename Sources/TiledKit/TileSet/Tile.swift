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

/// Frames are attached to `Tile`s and reference another `Tile` within the same Tile Set as well as the duration it that `Tile` should be displayed
/// when shown as part of an animation
public struct Frame {
    /// The tile to display
    public let tile : Tile
    
    /// Duration the frame should be displayed in seconds
    public let duration : Double
}

/// A `Tile` represents a 2D image that should be rendered when referenced on by an `Object` or `Layer`.
/// It contains a reference to the image, and the portion of that image that should be used to generate the image.
public class Tile {
    /// The URL of the image used
    public let imageSource : URL
    
    /// The color used in the image that should be treated as transparent (if any). This should not impact the interpretation of any
    /// alpha values also used for a color (i.e. it is addative)
    public let transparentColor : Color?
    
    /// The rectangle within the image that should be used to as the final `Tile` image. This enables a single image source to contain
    /// multiple `Tile` images
    public let bounds : PixelBounds
    
    /// Any `Frame`s of animation
    public var frames : [Frame]? = nil
    
    /// An array of `Object`s that make up the collision area for the `Tile`
    public var collisionBodies : [Object]? = nil

    /// A unique identifier for the tile (where unique means another `Tile` with the same `bounds` would have the same uuid
    public var uuid : String {
        return "\(imageSource.absoluteString):\(bounds)"
    }
    
    
    /// Creates a new instance of a tile
    /// - Parameters:
    ///   - imageSource: The `URL` of the image the tile is or is in
    ///   - bounds: The portion of the speciied image that should be used for the tile. If the whole image should be used, it will be a point with an origin of `Point.zero` and a size the same as the source image
    ///   - transparentColor: The color in the image that should be treated as transparent (defaults to `nil` as modern formats typically contain alpha)
    public init(_  imageSource:URL, bounds : PixelBounds, transparentColor:Color? = nil){
        self.imageSource = imageSource
        self.transparentColor = transparentColor
        self.bounds = bounds
    }
}
