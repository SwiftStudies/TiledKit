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

import XMLCoder
import Foundation

public struct XMLObjectTypes : Encodable {
    public let types : [XMLObjectType]
    
    public enum CodingKeys : String, CodingKey {
        case types = "objecttype"
    }
    
    public init(from url:URL) throws {
        let data = try Data(contentsOf: url)
        types = try XMLDecoder().decode([XMLObjectType].self, from: data)
    }
    
    public init(with types:[XMLObjectType]){
        self.types = types
    }
}

public struct XMLObjectType : Codable, DynamicNodeEncoding {
    public let name : String
    public let color : String
    
    public let properties : [XMLObjectTypeProperty]
    
    enum CodingKeys : String, CodingKey {
        case name, color, properties = "property"
    }
    
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key.stringValue {
        case CodingKeys.name.stringValue, CodingKeys.color.stringValue:
            return .attribute
        default:
            return .element
        }
    }
    
    public init(_ name:String, color:String, properties:[XMLObjectTypeProperty]){
        self.name = name
        self.color = color
        self.properties = properties
    }
}

public struct XMLObjectTypeProperty : Codable, DynamicNodeEncoding {
    public let name : String
    public let type : String
    public let `default` : String?
    
    public init(_ name:String, type:String, `default`:String){
        self.name = name
        self.type = type
        self.default = `default`
    }
    
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }
    

}
