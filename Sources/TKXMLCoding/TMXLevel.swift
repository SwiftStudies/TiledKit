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

public struct TMXLevel : Codable {
    public let version : String
    public let tiledVersion : String
    public let orientation : String
    public let renderOrder : String
    public let width : Int
    public let height : Int
    public let tileWidth : Int
    public let tileHeight : Int
    public let infinite : Bool
    public let tileSet : [TMXTileSetReference]
    public let layers : [TMXLayer]
    public let properties : [XMLProperty]
}
