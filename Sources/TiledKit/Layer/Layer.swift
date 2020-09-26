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

#warning("Rename to Layer when old class out the way")

public struct Layer  {
    public enum Kind {
        case tile(TileGrid), objects([Object]), group(Group), image(ImageReference)
    }
    
    public let name    : String
    public let visible : Bool
    public let opacity : Double
    public let position: Position
    public let kind    : Kind
    public let properties : Properties
    
    public var objects : [Object] {
        switch kind {
        case .objects(let objects):
            return objects
        default:
            return [Object]()
        }
    }
}
