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

public struct Identifier : Hashable {
    let stringSource      : String?
    let integerSource     : Int?
    
    public func hash(into hasher: inout Hasher) {
        if let string = stringSource {
            string.hash(into: &hasher)
        } else if let integer = integerSource {
            integer.hash(into: &hasher)
        } else {
            fatalError("Identifier must have integer or string source, but both are nil")
        }
    }
    
}

extension Identifier : ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        integerSource = value
        stringSource = nil
    }
}

extension Identifier : ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        stringSource = value
        integerSource = nil
    }
}

extension Identifier : CustomStringConvertible{
    public var description : String {
        return stringSource ?? "\(integerSource!)"
    }
}

extension Identifier : Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self.init(stringLiteral: string)
        } else {
            try self.init(integerLiteral: container.decode(Int.self))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let string = stringSource {
            try container.encode(string)
        } else {
            try container.encode(integerSource!)
        }
    }
}
