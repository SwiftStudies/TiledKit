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
import TKXMLCoding

extension XMLProperty {
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
            if let value = Double(value) {
                return .double(value)
            }
        case .file:
            return .file(url: URL(fileURLWithPath: value))
        case .color:
            return .color(Color(from: value))
        case .object:
            if let objectId = Int(value) {
                return .object(id: objectId)
            }
        }
        
        return .error(type: "\(type)", value: value)
    }
}
