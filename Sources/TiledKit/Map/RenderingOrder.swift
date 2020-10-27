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

/// The rendering order for a `Map`
public enum RenderingOrder : String, Codable, CaseIterable {
    /// Moving right, then down
    case rightDown = "right-down"
    /// Moving right, then up
    case rightUp = "right-up"
    /// Moving left, then down
    case leftDown = "left-down"
    /// Moving left, then up
    case leftUp = "left-up"
    
    
    /// Generatas a series of tile grid positions for the supplied map using the rendering order
    /// - Parameter map: The map to use
    /// - Throws: An error if the rendering order is not support
    /// - Returns: An array of `TileGridPositions`
    public func tileSequence(for map:Map) throws -> [TileGridPosition]{
        var sequence = [TileGridPosition]()
        
        switch self {
        case .leftUp:
            for y in (0..<map.mapSize.height).reversed() {
                for x in (0..<map.mapSize.width).reversed() {
                    sequence.append(TileGridPosition(x: x, y: y))
                }
            }
        case .leftDown:
            for y in 0..<map.mapSize.height {
                for x in (0..<map.mapSize.width).reversed() {
                    sequence.append(TileGridPosition(x: x, y: y))
                }
            }
        case .rightUp:
            for y in (0..<map.mapSize.height).reversed() {
                for x in 0..<map.mapSize.width {
                    sequence.append(TileGridPosition(x: x, y: y))
                }
            }
        case .rightDown:
            for y in 0..<map.mapSize.height {
                for x in 0..<map.mapSize.width {
                    sequence.append(TileGridPosition(x: x, y: y))
                }
            }
        default:
            throw MapError.unsupportedRenderingOrder(self)
        }
        
        return sequence
    }

}
