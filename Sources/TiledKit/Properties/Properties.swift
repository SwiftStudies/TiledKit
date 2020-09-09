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

fileprivate enum PropertyJSONKeys : String, CodingKey {
    case types = "propertytypes", values = "properties"
}

#warning("Is this needed?")
fileprivate struct FlexibleCodingKey : CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}

protocol Propertied {
    var  properties : [String : Literal] {get set}
}

fileprivate enum PropertyType : String, Decodable {
    case string, bool, int, float, file, color
}

extension Decodable where Self : Propertied {
    func decode(from decoder:Decoder) throws -> [String : Literal] {
        #warning("Properties not implemented")
        return [String:Literal]()
    }
}
