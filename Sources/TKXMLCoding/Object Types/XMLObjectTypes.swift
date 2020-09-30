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

public struct XMLObjectTypes  {
    public let types : [XMLObjectType]
    
    public init(from url:URL) throws {
        let data = try Data(contentsOf: url)
        types = try XMLDecoder().decode([XMLObjectType].self, from: data)
    }
}

public struct XMLObjectType : Codable {
    public let name : String
    public let color : String
    
    public let properties : [XMLObjectTypeProperty]
    
    enum CodingKeys : String, CodingKey {
        case name, color, properties = "property"
    }
}

public struct XMLObjectTypeProperty : Codable {
    public let name : String
    public let type : String
    public let `default` : String?
}
