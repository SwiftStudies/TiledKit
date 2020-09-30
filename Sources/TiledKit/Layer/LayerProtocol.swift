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

/// All `Layer` types, or types that represent specialisations of `Layer` implement this common set of
/// properties.
public protocol LayerProtocol : Propertied {
    /// The name of the layer, or an empty `String` if non was specified
    var name    : String { get }
    
    /// `true` if the layer should be visible
    var visible : Bool { get }
    
    /// A level of how transparent the layer (and therefore its contents) should be rendered with
    var opacity : Double { get }
    
    /// An offset from the `Layer`s parent's origin
    var position: Position { get }

    /// Any tint color that should be applied to the `Layer` and its contents. If nil then no tint should be applied
    var tintColor : Color? { get }
    
    /// If true the layer is locked. If you are providing editing functionality no changes should be made to this layer
    var locked : Bool { get }
}
