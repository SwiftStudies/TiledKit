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

/// Extensions to support augmentation of user defined Tiled object types with standard object types
public extension ObjectTypes {
    /// Creates a new instance of the object types with old types defined for the engine (identified as having the `Engine.prefix`)
    /// removed, and the current types added. User defined object types (in Tiled) are preserved unchanged
    /// - Parameter engineType: The `Engine` to use
    /// - Returns: A new `ObjectTypes` object that is updated and can be used to save (to the same location) or assign to the
    /// a `Project`
    func extendedWith<EngineType:Engine>(_ engineType: EngineType.Type)->ObjectTypes{
        var newObjectTypes = url == nil ? ObjectTypes() :  ObjectTypes(url!)
        
        for definition in definitions {
            if definition.key != EngineType.prefix {
                newObjectTypes[definition.key] = definition.value
            }
        }
        
        for definition in EngineType.objectTypes.definitions {
            newObjectTypes[definition.key] = definition.value
        }
        
        return newObjectTypes
    }
}

/// Augments core `ObjectType` with convience functions that make it easy to work with bridgeable properties
public extension ObjectType {
    
    /// Creates an object type based on a list of bridgeable properties
    /// - Parameters:
    ///   - color: The color to use for the object type in tiled
    ///   - properties: The properties to assign to the newly created `ObjectType`
    init<S:Sequence>(_ color:Color, with properties:S) where S.Element : BridgableProperty {
        self.init(color: color)
        
        
        for property in properties {
            self[property.tiledName] = property.tiledDefault
        }
    }
    
    /// Add the sequence of `BridgableProperties` to the `ObjectType`
    /// - Parameter properties: The additional properites
    /// - Returns: A new instance of the object type
    func and<S:Sequence>(_ properties:S) -> ObjectType where S.Element : BridgableProperty {
        
        var newType = ObjectType(color: color)
        
        for property in self.allPropertyNames {
            newType[property] = self[property]
        }
        
        for property in properties {
            newType[property.tiledName] = property.tiledDefault
        }
        
        return newType
    }
}

/// Convience to for working with Bridgeable properites
public extension Sequence where Element : BridgableProperty {
    
    /// The sequence of bridgeable properties rendered with defaults into a `Properties` object
    var tiledProperties : Properties {
        var results = Properties()
        
        for property in self {
            results[property.tiledName] = property.tiledDefault
        }
        
        return results
    }
}
