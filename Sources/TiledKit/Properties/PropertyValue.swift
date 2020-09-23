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

public enum PropertyValue : Equatable, CustomStringConvertible, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByBooleanLiteral, ExpressibleByArrayLiteral {
    
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)
    case file(url:URL)
    case color(Color)
    #warning("The public API should have a value that is explicitly the object")
    case object(id:Int)
    case error(type:String, value:String)
    
    public typealias ArrayLiteralElement = Byte
    public typealias FloatLiteralType = Double
    public typealias IntegerLiteralType = Int
    public typealias StringLiteralType = String
    public typealias BooleanLiteralType = Bool
    
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
    
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
    
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
    
    public init(stringLiteral value: String) {
        self = .string(value)
    }
    
    public init(arrayLiteral elements: Byte...) {
        assert(elements.count == 3 || elements.count == 4, "Array should be in the form [r,g,b] or [r,g,b,a]")
        if elements.count == 3 {
            self = .color(Color(r: elements[0], g: elements[1], b: elements[2]))
        } else {
            self = .color(Color(r: elements[0], g: elements[1], b: elements[2], a: elements[3]))
        }
    }

    public var description: String {
        switch self {
        case .string(let value):
            return value
        case .file(let value):
            return "\(value)"
        case .bool(let value):
            return "\(value)"
        case .int(let value):
            return "\(value)"
        case .double(let value):
            return "\(value)"
        case .color(let value):
            return "\(value)"
        case .object(id: let id):
            return "\(id)"
        case .error(type: let type, value: let value):
            return "\(type).\(value)"
        }
    }
}
