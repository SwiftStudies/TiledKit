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

public struct TSXTileFrame : Codable {
    public let tileid : UInt32
    public let duration : Int
}

public struct TSXTile : Codable {
    public let id : UInt32
    public let collisionObject : XMLObjectLayer?
    public let animationFrames : [TSXTileFrame]
    public let image : XMLImageElement?
    
    enum CodingKeys : String, CodingKey {
        case id, collisionObject = "objectgroup", animationFrames = "animation", image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UInt32.self, forKey: .id)
        collisionObject = try container.decodeIfPresent(XMLObjectLayer.self, forKey: .collisionObject)
        image = try container.decodeIfPresent(XMLImageElement.self, forKey: .image)
        
        // needs to be nested unkeyed and iterated?
        var animationFrames = [TSXTileFrame]()
        var frameContainer = try container.nestedUnkeyedContainer(forKey: .animationFrames)
        while !frameContainer.isAtEnd{
            animationFrames.append(try frameContainer.decode(TSXTileFrame.self))
        }
        self.animationFrames = animationFrames
    }
}
