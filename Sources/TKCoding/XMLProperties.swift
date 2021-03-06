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

import Foundation

protocol XMLPropertied {
    var properties : XMLProperties {get}
}

public struct XMLProperties : Codable {
    public let properties : [XMLProperty]
    
    enum CodingKeys : String, CodingKey {
        case properties = "property"
    }
    
    public init(_ properties:[XMLProperty]){
        self.properties = properties
    }
    
    static func decode(from decoder:Decoder) throws ->XMLProperties {
        enum CodingKeys : String, CodingKey {
            case properties
        }
        return try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent(XMLProperties.self, forKey: .properties) ?? XMLProperties([XMLProperty]())
    }
}

public enum XMLRawPropertyType : String, Codable {
    case string, bool, int, float, file, color, object
}

public struct XMLProperty : Codable {
    public let name    : String
    public let type    : XMLRawPropertyType?
    public let value : String
    
    public enum AllCodingKeys : String, CodingKey {
        case name, type, value, element = ""
    }
    
    public init(_ name:String, type:XMLRawPropertyType, value:String){
        self.name = name
        self.type = type
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AllCodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        type = try container.decodeIfPresent(XMLRawPropertyType.self, forKey: .type)
        
        if let valueInAttribute = try container.decodeIfPresent(String.self, forKey: .value) {
            value = valueInAttribute
        } else if type == nil {
            value = try container.decode(String.self, forKey: .element)
        } else {
            throw XMLDecodingError.propertyHasNoValue(name, type: type ?? .string)
        }
    }
}
