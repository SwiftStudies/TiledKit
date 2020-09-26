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
public enum Orientation : String, Codable, CaseIterable{
    
    /// A top-down/side-on view
    case orthogonal
    
    /// 2D plane of the map rotated around the z axis by 45 degrees
    case isometric
    
    /// A staggered view
    case staggered
    
    /// A hexagonal grid (all tiles have 6 sides)
    case hexagonal
}
