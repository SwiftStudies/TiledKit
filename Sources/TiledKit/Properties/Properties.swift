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

/// A `Dictionary` of named `PropertyValue`s used with any Tiled object that can have user defined properties (captured in `PropertyValue`)
public typealias Properties = [String : PropertyValue]

/// Any TiledKit object that can have user defined properties, that supports writing of properties
public protocol Propertied {
    /// The `Properties` of the object
    var  properties : Properties { get }
}

/// Provides the ability to merge two sets of properties
public extension Properties {
    
    
    /// Creates a new `Properties` object by merging this set with the passed `Properties`, if there is a collision the passed `Properties` value will be used
    /// - Parameter properties: The properties to merge. If there is a collision these will take priority
    /// - Returns: The resultant merged `Properties`
    func overridingWith(_ properties:Properties)->Properties {
        var combinedProperties = self
        
        for propertyTuple in properties {
            combinedProperties[propertyTuple.key] = propertyTuple.value
        }
        
        return combinedProperties
    }
}

/// Any TiledKit object that can have user defined properties, that supports writing of properties
public protocol MutablePropertied : Propertied{
    /// The `Properties` of the object
    var  properties : Properties {get set}
}

/// Extends any `Propertied` object to support dynamic member resolution for the dedicated types.
public extension Propertied {
    
    /// Retreives a `Color` from an object that can have user properties dynamically.
    ///
    ///             let fillColor : Color = layer.fillColor ?? Color.white
    ///
    /// - Parameters:
    ///   - member: The name of the property
    /// - returns: The  `Color` value or `nil` if the property does not exist, or is not of the right type
    subscript(dynamicMember member:String)->Color? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.color(value) = property {
            return value
        }
        return nil
    }

    /// Retreives a `URL` from an object that can have user properties dynamically.
    ///
    ///             let levelTheme : URL? = layer.levelMP3
    ///
    /// - Parameters:
    ///   - member: The name of the property
    /// - returns: The  `URL` value or `nil` if the property does not exist, or is not of the right type
    subscript(dynamicMember member:String)->URL? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.file(value) = property {
            return value
        }
        return nil
    }

    /// Retreives a `Double` from an object that can have user properties dynamically.
    ///
    ///             let weight : Double = object.weight ?? 100.0
    ///
    /// - Parameters:
    ///   - member: The name of the property
    /// - returns: The  `Double` value or `nil` if the property does not exist, or is not of the right type
    subscript(dynamicMember member:String)->Double? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.double(value) = property {
            return value
        }
        return nil
    }

    
    /// Retreives a `Int` from an object that can have user properties dynamically.
    ///
    ///             let extraLives : Int = layer.bonusLives ?? 0
    ///
    /// - Parameters:
    ///   - member: The name of the property
    /// - returns: The  `Int` value or `nil` if the property does not exist, or is not of the right type
    subscript(dynamicMember member:String)->Int? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.int(value) = property {
            return value
        }
        return nil
    }

    /// Retreives a `Bool` from an object that can have user properties dynamically.
    ///
    ///             let pausable : Bool = layer.pausable ?? true
    ///
    /// - Parameters:
    ///   - member: The name of the property
    /// - returns: The  `Bool` value or `nil` if the property does not exist, or is not of the right type
    subscript(dynamicMember member:String)->Bool? {
        guard let property = properties[member] else {
            return nil
        }
        if case let PropertyValue.bool(value) = property {
            return value
        }
        return nil
    }

    /// Retreives a `String` from an object that can have user properties dynamically.
    ///
    ///             let gameOverText : String = layer.gameOverText ?? "Game Over"
    ///
    /// - Parameters:
    ///   - member: The name of the property
    /// - returns: The  `String` value or `nil` if the property does not exist, or is not of the right type
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




