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

/// Ensures a Tiled "float" can be converted into an Engine specific property value
public protocol ExpressibleAsTiledFloat {
    /// Creates an instance of the implementating type from the default type for Tiled floats (`Double`)
    /// - Parameter from: The value of the Tiled property
    static func instance(bridging value:Double)->Self
}

/// Ensures a Tiled "color" can be converted into an Engine specific property value
public protocol ExpressibleAsTiledColor {
    /// Creates an instance of the implementating type from supplied `Color`
    /// - Parameter from: The value of the tiled property
    static func instance(bridging color:Color)->Self
}

/// Enables the implementer to provide the information required to automatically translate a tiled property
/// and apply it to the game specific engine.
public protocol BridgableProperty  {
    /// Captures which game engine object is the target for this property
    associatedtype EngineObjectType : EngineObject
    
    /// Convience propagation of the type used for most floats in the target game engine
    typealias FloatType             = EngineObjectType.EngineType.FloatType
    
    /// Convience propagation of the type used to represent colors in the target game engine
    typealias ColorType             = EngineObjectType.EngineType.ColorType
    
    /// The name of the property in Tiled
    var     tiledName              : String                             {get}
    
    /// The default value of the property in Tiled
    var     tiledDefault           : PropertyValue                      {get}
    
    /// The key path to be used to write the property on `EngineObjectType`
    var     engineObjectProperty   : PartialKeyPath<EngineObjectType>   {get}
}

/// If properties are captured in an `String` enum generically returning the name of the tiled property based on the raw value of the
/// case
public extension BridgableProperty where Self : RawRepresentable, Self.RawValue == String {
    /// The name of the property in Tiled
    var tiledName : String {
       return rawValue
    }
}

/// Useful for enums that capture `BridgableProperty` to enable them to be
/// quickly and easily applied
public extension CaseIterable where Self : BridgableProperty {
    /// Bridges all cases  with the supplied Tiled properties to the supplied `EngineObject`
    /// - Parameters:
    ///   - properties: The tiled properties and values
    ///   - object: The object in the specialized engine that should be updated
    static func apply(_ properties:Properties, to object:EngineObjectType){
        allCases.apply(properties, to: object)
    }
}

/// Standard capabilities added to make mapping from Tiled data to the objects in a game engine as simple as possible
public extension BridgableProperty {
    
    
    /// Sets the appropriate property on the `EngineObjectType` instance supplied
    /// - Parameters:
    ///   - object: The object in the specialized engine that should be updated
    ///   - value: The value to apply to its property
    func apply(to object:EngineObjectType, _ value:PropertyValue){
        
        switch value {
        case .string(let value):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,String> {
                object[keyPath: keyPath] = value
                return
            }
        case .bool(let value):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,Bool> {
                object[keyPath: keyPath] = value
                return
            }
        case .int(let value):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,Int> {
                object[keyPath: keyPath] = value
                return
            }
        case .double(let value):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,FloatType> {
                object[keyPath: keyPath] = FloatType.instance(bridging: value)
                return
            }
        case .file(let url):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,URL> {
                object[keyPath: keyPath] = url
                return
            }
        case .color(let color):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,ColorType> {
                object[keyPath: keyPath] = ColorType.instance(bridging: color)
                return
            }
        case .object(let id):
            if let keyPath = engineObjectProperty as? ReferenceWritableKeyPath<EngineObjectType,Int> {
                object[keyPath: keyPath] = id
                return
            }
        case .error(let type, _):
            EngineObjectType.EngineType.warn("Do not know how to apply \(type) property to \(Swift.type(of:object)).\(engineObjectProperty). Ignoring.")
            return
        }
        
        // Should have returned before
        EngineObjectType.EngineType.warn("Could not set \(tiledName) to \(tiledDefault) using a keyPath of type \(engineObjectProperty)")
    }
}


/// Provides convience methods for applying multiple bridgable properties
public extension Collection where Element : BridgableProperty {
    /// For an array of bridgeable properties applies all of those that exist to the supplied object
    /// - Parameters:
    ///   - properties: The tiled properties and values
    ///   - object: The object in the specialized engine that should be updated
    func apply(_ properties:Properties, to object:Element.EngineObjectType){
        for tiledBridgedProperty in self {
            if let tiledValue = properties[tiledBridgedProperty.tiledName] {
                tiledBridgedProperty.apply(to: object, tiledValue)
            }
        }
    }
}

/// For any property list, rapidly determine if the bridgable properties are included
public extension Properties {
    
    /// Determines if the properties include at least one of the properties in the supplied array
    /// - Parameter properties: The properties to check for
    /// - Returns: `true` if at least one of the properties exists
    func hasProperty<EngineProperty:BridgableProperty>(in properties:[EngineProperty])->Bool {
        return filter({properties.map(\.tiledName).contains($0.key)}).count > 0
    }
}

/// Convience method for all items that have properties
public extension Propertied {
    /// Determines if the properties of the object include at least one of the properties in the supplied array
    /// - Parameter properties: The properties to check for
    /// - Returns: `true` if at least one of the properties exists
    func hasProperty<EngineProperty:BridgableProperty>(in properties:[EngineProperty])->Bool {
        return self.properties.hasProperty(in: properties)
    }
}
