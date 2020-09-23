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

public struct TMXGroupLayer : XMLLayer {
    public var id: Int
    public var name: String
    public var x: Double
    public var y: Double
    public var visible: Bool

    public let layers : [XMLLayer]
    
    public init(from decoder: Decoder) throws {
        let commonAttributes = try XMLLayerCommon(from: decoder)
        
        id = commonAttributes.id
        name = commonAttributes.name
        x = commonAttributes.xoffset ?? 0
        y = commonAttributes.yoffset ?? 0
        visible = commonAttributes.visible ?? true
        
        layers = try XMLLayerContainer.decodeLayers(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        fatalError("Not implemented")
    }
}
