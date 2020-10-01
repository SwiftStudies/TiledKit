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

extension XMLProperty {
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

extension XMLProperties {
    #warning("This should be done AFTER everything else has been loaded so that files and objects can be fully resolved")
    func interpret(baseUrl:URL?, in project:Project) -> Properties{
        var properties = Properties()
        for property in self.properties {
            properties[property.name] = property.propertyValue(baseUrl: baseUrl, and: project)
        }
        return properties
    }
}
