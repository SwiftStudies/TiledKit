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

public typealias Properties = [String : PropertyValue]

public protocol Propertied {
    var  properties : Properties {get set}
}

public extension Propertied {
    
    subscript(dynamicMember member:String)->Color? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.color(value) = property {
            return value
        }
        return nil
    }

    
    subscript(dynamicMember member:String)->URL? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.file(value) = property {
            return value
        }
        return nil
    }

    
    subscript(dynamicMember member:String)->Double? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.double(value) = property {
            return value
        }
        return nil
    }

    
    subscript(dynamicMember member:String)->Int? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.int(value) = property {
            return value
        }
        return nil
    }

    subscript(dynamicMember member:String)->Bool? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.bool(value) = property {
            return value
        }
        return nil
    }

    subscript(dynamicMember member:String)->String? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.string(value) = property {
            return value
        }
        return nil
    }
}




