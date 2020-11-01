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

/// Captures the different orientations supported by Tiled `Map`s
public enum Orientation {
    
    /// A top-down/side-on view
    case orthogonal
    
    /// 2D plane of the map rotated around the z axis by 45 degrees
    case isometric
    
    /// A staggered view
    case staggered
    
    /// A hexagonal grid, captures the axis and index of the stagger
    case hexagonal(axis:StaggerAxis, index:StaggerIndex, sideLength:Int)
    
    public init(_ stringValue:String, staggerAxis:StaggerAxis?, staggerIndex:StaggerIndex?, hexSideLength:Int?) throws {
        switch stringValue {
        case "orthogonal":
            self = .orthogonal
        case "isometric":
            self = .isometric
        case "staggered":
            self = .staggered
        case "hexagonal":
            guard let axis = staggerAxis, let index = staggerIndex, let sideLength = hexSideLength else {
                throw MapError.missingOrientationInformation(axis: staggerAxis, index: staggerIndex, hexSideLength: hexSideLength)
            }
            self = .hexagonal(axis: axis, index: index, sideLength: sideLength)
        default:
            throw MapError.unknownOrientation(stringValue)
        }
    }
}
