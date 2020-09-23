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

public struct TMXImageLayer : TMXInternalLayerRepresentation {
    public var id: Int
    public var name: String
    var xoffset: Double?
    var yoffset: Double?
    var visible: Bool?

    private struct ImageElement : Codable {
        let source : String
        let width : Int
        let height : Int
    }
    
    private let image : ImageElement
    
    public var width : Int {
        return image.width
    }
    
    public var height : Int {
        return image.height
    }
    
    public var path : String {
        return image.source
    }
}
