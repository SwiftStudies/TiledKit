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

fileprivate enum PropertyXMLCodingKeys : String, CodingKey {
    case properties, property
}

public protocol Propertied {
    var  properties : [String : PropertyValue] {get set}
}

public enum PropertyValue : Equatable{
    case string(String), bool(Bool), int(Int), float(Float), file(url:URL), color(color:Color), object(id:Int), error(type:String, value:String)
}

fileprivate enum RawPropertyType : String, Decodable {
    case string, bool, int, float, file, color, object
}

fileprivate struct XMLProperty : Decodable {
    let name    : String
    let type    : RawPropertyType?
    private let value : String
    
    var property : PropertyValue {

        guard let type = type else {
            return .string(value)
        }
        
        switch type {
        case .string:
            return .string(value)
        case .bool:
            return .bool(value == "true")
        case .int:
            if let intValue = Int(value) {
                return .int(intValue)
            }
        case .float:
            if let floatValue = Float(value) {
                return .float(floatValue)
            }
        case .file:
            return .file(url: URL(fileURLWithPath: value))
        case .color:
            return .color(color: Color(from: value))
        case .object:
            if let objectId = Int(value) {
                return .object(id: objectId)
            }
        }
        
        return .error(type: "\(type)", value: value)
    }
}

extension Decodable where Self : Propertied {
    func decode(from decoder:Decoder) throws -> [String : PropertyValue] {
        let container = try decoder.container(keyedBy: PropertyXMLCodingKeys.self)
        
        let propertiesContainer = try container.nestedContainer(keyedBy: PropertyXMLCodingKeys.self, forKey: .properties)
        
        let properties = try propertiesContainer.decode([XMLProperty].self, forKey: .property).reduce(into:[String:PropertyValue]()){
            $0[$1.name] = $1.property
        }
        
        return properties
    }
}
