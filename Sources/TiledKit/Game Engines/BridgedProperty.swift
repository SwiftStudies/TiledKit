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

/// Provides a concreate wrapper to store mapped properties
public struct BridgedProperty<EngineObjectType : EngineObject> : TiledEngineBridgableProperty {
    /// Name of the property in tiled
    public var tiledName: String
    
    /// The default value of the property
    public var tiledDefault: PropertyValue
    
    /// The `KeyPath` to the property on the `EngineObject`
    public var engineObjectProperty: PartialKeyPath<EngineObjectType>
    
    /// Creates a new instance of the BridgedProperty for a specific `EngineObject`
    /// - Parameter instance: A `TiledEngineBridgableProperty` to store/wrap
    public init<MPT : TiledEngineBridgableProperty>(_ instance:MPT) where MPT.EngineObjectType == EngineObjectType {
        tiledName = instance.tiledName
        tiledDefault = instance.tiledDefault
        engineObjectProperty = instance.engineObjectProperty
    }
    
}
