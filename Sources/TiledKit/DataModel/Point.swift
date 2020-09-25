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

public typealias TilePosition = Point<Int>
public typealias TileSize  = Dimension<Int>

public typealias PixelPoint = Point<Int>
public typealias PixelSize  = Dimension<Int>
public typealias PixelBounds = Rectangle<Int>

#warning("Rename this to Position when it's available")
public typealias Location = Point<Double>
public typealias Size = Dimension<Double>
public typealias Path = Array<Location>

public struct Point<N:Numeric> : Equatable{
    var x : N
    var y : N
    
    public init(x:N, y:N){
        self.x = x
        self.y = y
    }
}

public struct Dimension<N:Numeric> : Equatable{
    var width : N
    var height : N
    
    public init(width:N, height:N){
        self.width = width
        self.height = height
    }
}

public struct Rectangle<N:Numeric> : Equatable{
    var origin : Point<N>
    var size   : Dimension<N>
    
    public init(x:N, y:N, width:N, height:N){
        origin = Point(x: x, y: y)
        size = Dimension(width: width, height: height)
    }
    
    public init(origin:Point<N>, size:Dimension<N>){
        self.origin = origin
        self.size = size
    }
}
