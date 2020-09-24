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

typealias TilePosition = Point<Int>
typealias TileSize  = Dimension<Int>

typealias PixelPoint = Point<Int>
typealias PixelSize  = Dimension<Int>

#warning("Rename this to Position when it's available")
typealias Location = Point<Double>
typealias Size = Dimension<Double>

public struct Point<N:Numeric>{
    var x : N
    var y : N
    
    public init(x:N, y:N){
        self.x = x
        self.y = y
    }
}

public struct Dimension<N:Numeric>{
    var width : N
    var height : N
    
    public init(width:N, height:N){
        self.width = width
        self.height = height
    }
}
