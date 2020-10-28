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

import TKCoding
import Foundation

internal extension XMLProperty {
    fileprivate func propertyValue(baseUrl:URL?, and project:Project)->PropertyValue? {
        guard let type = type else {
            return .string(value)
        }
        switch type{
        case .string:
            return .string(value)
        case .bool:
            return .bool(Bool(value) ?? false)
        case .int:
            return .int(Int(value) ?? 0)
        case .float:
            return .double(Double(value) ?? 0)
        case .file:
            return .file(url: project.resolve(URL(fileURLWithPath: value), relativeTo: baseUrl) ?? URL(fileURLWithPath: value))
        case .color:
            return .color(Color(from: value))
        case .object:
            guard let objectId = Int(value) else {
                return nil
            }
            return .object(id: objectId)
        }

    }
}

internal extension PropertyValue{
    var xmlType : XMLRawPropertyType {
        switch self {
        case .string:
            return .string
        case .bool:
            return .bool
        case .int:
            return .int
        case .double:
            return .float
        case .file:
            return .file
        case .color:
            return .color
        case .object:
            return .object
        case .error:
            return .string
        }
    }
    
    var xmlValue : String {
        switch self {
        case .bool(let value):
            return value ? "1" : "0"
        case .string(let value):
            return value
        case .int(let value):
            return value.description
        case .double(let value):
            return value.description
        case .file(let value):
            return value.relativePath
        case .color(let value):
            return value.tiledFormatDescription
        case .object(let value):
            return value.description
        case .error(_, let value):
            return value
        }
    }
}

extension XMLProperties {
    func interpret(baseUrl:URL?, in project:Project) -> Properties{
        var properties = Properties()
        for property in self.properties {
            properties[property.name] = property.propertyValue(baseUrl: baseUrl, and: project)
        }
        return properties
    }
}
