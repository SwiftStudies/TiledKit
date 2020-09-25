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

public struct TMXImageLayer : XMLLayer {
    public var id: Int
    public var name: String
    public var x: Double
    public var y: Double
    public var visible: Bool
    public var opacity : Double
    public var properties: XMLProperties

    private let image : XMLImageElement
    
    public var width : Int {
        return image.width
    }
    
    public var height : Int {
        return image.height
    }
    
    public var path : String {
        return image.source
    }
    
    public init(from decoder: Decoder) throws {
        let commonAttributes = try XMLLayerCommon(from: decoder)
        
        id = commonAttributes.id
        name = commonAttributes.name
        x = commonAttributes.offsetx ?? 0
        y = commonAttributes.offsety ?? 0
        visible = commonAttributes.visible ?? true
        opacity = commonAttributes.opacity ?? 1
        properties = try XMLProperties.decode(from: decoder)

        image = try decoder.container(keyedBy: CodingKeys.self).decode(XMLImageElement.self, forKey: .image)
    }

}
