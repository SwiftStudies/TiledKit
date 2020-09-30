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

/// Provides an immutable view of a `Layer` that is an object layer
public struct ObjectLayer : LayerProtocol {
    private let     allObjects : [Object]
    private let     layer   : Layer
    
    /// A filter that can be used for selecting layers that have the `Layer.kind` attribute of `.objects`
    public static let kind: LayerFilter = KindLayerFilter()
    
    internal init(_ layer:Layer, objects:[Object]){
        self.layer = layer
        allObjects = objects
    }
    
    /// The name of the layer, or an empty `String` if none was specified
    public var name    : String {
        return layer.name
    }
    
    /// `true` if the layer should be visible
    public var visible : Bool {
        return layer.visible
    }
    
    /// A level of transparent the layer (and therefore its contents) should be rendered with
    public var opacity : Double {
        return layer.opacity
    }
    
    /// An offset from the `Layer`s parent's origin
    public var position: Position {
        return layer.position
    }
    
    /// User specified `Properties` of the layer
    public var properties : Properties {
        return layer.properties
    }
    
    /// All of the objects in the layer
    public var objects : [Object] {
        return allObjects
    }
    
    /// If `true` no editing operations should be applied to the `Layer`
    public var locked: Bool {
        return layer.locked
    }
    
    /// Any tint that should be applied to the `Layer`, or none if `nil`
    public var tintColor: Color? {
        return layer.tintColor
    }
    
    /// Retreive `Object`s based on their name
    ///  - Parameter name: The name of the desired `Object`
    ///  - returns: An array containing all the matching `Object`s or `nil` if none match
    public func objects(named name:String)->[Object]? {
        let objects = self.objects.filter({$0.name == name})
        
        return objects.count == 0 ? nil : objects
    }
    
    /// Retreive an `Object`s based on it's `id`
    ///  - Parameter name: The id of the desired `Object`
    ///  - returns: The matching `Object` or `nil` if no objects with that `id` exist
    public subscript(withId id:Int)->Object? {
        return self.objects.filter({$0.id == id}).first
    }
}

fileprivate struct KindLayerFilter : LayerFilter {
    func matches(_ layer: Layer) -> Bool {
        if case Layer.Kind.objects = layer.kind {
            return true
        }
        
        return false
    }
}
