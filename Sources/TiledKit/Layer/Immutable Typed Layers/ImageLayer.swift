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

public struct ImageLayer : LayerProtocol {
    private let     layer   : Layer
    
    /// The reference to the image, that you can use to load the image
    public  let     image:ImageReference

    /// A filter that can be used for selecting layers that have the `Layer.kind` attribute of group
    public static let kind: LayerFilter = KindLayerFilter()
    
    internal init(_ layer:Layer, image:ImageReference){
        self.layer = layer
        self.image = image
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
    
    /// If `true` no editing operations should be applied to the `Layer`
    public var locked: Bool {
        return layer.locked
    }
    
    /// Any tint that should be applied to the `Layer`, or none if `nil`
    public var tintColor: Color? {
        return layer.tintColor
    }


}

fileprivate struct KindLayerFilter : LayerFilter {
    func matches(_ layer: Layer) -> Bool {
        if case Layer.Kind.image = layer.kind {
            return true
        }
        
        return false
    }
}

