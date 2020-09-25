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

#warning("Rename when old API out the way")

public struct TKObject {
    public enum Kind {
        case point,
             rectangle(Size, rotation:Double),
             elipse(Size, rotation:Double),
             tile(TileGID, size:Size, rotation:Double),
             text(String, size:Size, rotation:Double, style:TextStyle),
             polygon(Path, rotation:Double),
             polyline(Path, rotation:Double)
    }
    
    public let id      : Int
    public let name    : String
    public let visible : Bool
    public let position: Location
    public let properities : Properties
    public let kind    : Kind
}
