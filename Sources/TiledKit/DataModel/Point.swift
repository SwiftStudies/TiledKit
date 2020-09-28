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


/// The `Point` generic captures a single in space.
public struct Point<N:Numeric> : Equatable, CustomStringConvertible{
    /// The x coordinate of the point
    public var x : N
    
    /// The y coordinate of the point
    public var y : N
    
    /// Creates a new instance of a point from the given parameters
    ///
    /// - Parameters:
    ///   - x: Desired x coordinate
    ///   - y: Desired y coordinate
    public init(x:N, y:N){
        self.x = x
        self.y = y
    }
    
    /// A `point` with x and y equal to 0
    public static var zero : Self {
        return Self(x:0, y:0)
    }
    
    /// The description of the point
    public var description: String {
        return "(\(x),\(y)"
    }
}

/// A generic type that stores a 2D dimenion (with width and height)
public struct Dimension<N:Numeric> : Equatable, CustomStringConvertible{
    /// The width of the dimension
    public var width : N
    
    /// The height of the dimension
    public var height : N
    
    
    /// Creates a new instance of the `Dimension` object with the specified parameters
    /// - Parameters:
    ///   - width: The width value of the dimension
    ///   - height: The height value of the dimension
    public init(width:N, height:N){
        self.width = width
        self.height = height
    }

    /// The description of the point
    public var description: String {
        return "\(width)x\(height)"
    }
}

/// A generic type that captrues a rectangular region in 2D space with an origin and size
public struct Rectangle<N:Numeric> : Equatable, CustomStringConvertible {
    /// The origin of the rectangle
    public var origin : Point<N>
    /// The size of the rectangle
    public var size   : Dimension<N>
    
    
    /// Creates a new instance with individual parameters for the origin and size
    /// - Parameters:
    ///   - x: The origin x coordinate
    ///   - y: The origin y coordinate
    ///   - width: The width of the rectangle
    ///   - height: The height of the rectangle
    public init(x:N, y:N, width:N, height:N){
        origin = Point(x: x, y: y)
        size = Dimension(width: width, height: height)
    }
    
    /// Creates a new instance with the supplied origin and size
    /// - Parameters:
    ///   - origin: The origin of the rectangle
    ///   - size: The size of the rectangle
    public init(origin:Point<N>, size:Dimension<N>){
        self.origin = origin
        self.size = size
    }
    
    /// The description of the rectangle
    public var description: String {
        return "origin=\(origin) size=\(size)"
    }
}

/// A point on a tile grid (such as a tile layer)
public typealias TileGridPosition = Point<Int>

/// The dimensions of a tile grid (such as map or tile layer)
public typealias TileGridSize  = Dimension<Int>

/// A point in a rasterised image
public typealias PixelPoint = Point<Int>

/// A dimension for rasterized images
public typealias PixelSize  = Dimension<Int>

/// A rectangle inside a rasterized image
public typealias PixelBounds = Rectangle<Int>

/// A point in 2D space
public typealias Position = Point<Double>

/// A dimension in 2D space
public typealias Size = Dimension<Double>

/// Any array of of positions describing a path in 2D space
public typealias Path = Array<Position>
