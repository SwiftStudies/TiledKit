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

/// Tiled user defined properties are typed, and captured as one of a number of `PropertyValue` cases with attached data for the specific typed value
public enum PropertyValue : Equatable, CustomStringConvertible, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByBooleanLiteral, ExpressibleByArrayLiteral {
    
    /// String properties
    case string(String)
    /// Boolean properties
    case bool(Bool)
    /// Integer properties
    case int(Int)
    /// Float properties (represented in TiledKit as a `Double`)
    case double(Double)
    /// File properties
    case file(url:URL)
    /// Color properties
    case color(Color)
    #warning("The public API should have a value that is explicitly the object")
    /// Object properties
    case object(id:Int)
    /// Unknown types
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
    
    init(as type:String, with value:String){
        switch type {
        case "string":
            self = .string(value)
        case "file":
            self = .file(url: URL(fileURLWithPath: value))
        case "bool":
            switch value {
            case "1","true","TRUE","YES","yes":
                self = .bool(true)
            default:
                self = .bool(false)
            }
        case "int":
            self = .int(Int(value) ?? 0)
        case "float":
            self = .double(Double(value) ?? 0)
        case "color":
            if value.isEmpty {
                self = .color(Color.clear)
            } else {
                self = .color(Color(from: value))
            }
        case "object":
            self = .object(id: Int(value) ?? 0)
        default:
            self = .error(type: type, value: value)
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
