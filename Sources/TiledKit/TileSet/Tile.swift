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

public struct Frame {
    /// The tile to display
    public let tile : Tile
    
    /// Duration the frame should be displayed in seconds
    public let duration : Double
}

public class Tile {
    public let image : URL
    public let transparentColor : Color? 
    public let bounds : PixelBounds
    
    public var frames : [Frame]? = nil
    public var collisionBodies : [TKObject]? = nil

    public var uuid : String {
        return "\(image.absoluteString):\(bounds)"
    }
    
    public init(_  imageSource:URL, transparentColor:Color? = nil, bounds : PixelBounds){
        self.image = imageSource
        self.transparentColor = transparentColor
        self.bounds = bounds
    }
}
