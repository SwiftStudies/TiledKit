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
public protocol TiledEngineBridgableProperty  {
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


/// Standard capabilities added to make mapping from Tiled data to the objects in a game engine as simple as possible
public extension TiledEngineBridgableProperty {
    
    
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

