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

public struct XMLDimension {
    public let width : Double
    public let height : Double
    
    private enum CodingKeys : String, CodingKey {
        case width, height
    }
    
    static func decode(from decoder:Decoder) throws -> XMLDimension {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        return XMLDimension(
            width: try container.decode(Double.self, forKey: .width),
            height: try container.decode(Double.self, forKey: .height))
    }
}
