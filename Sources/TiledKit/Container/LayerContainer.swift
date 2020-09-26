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

/// Implemented by any object that can contain `Layer`s (such as a `Map`)
public protocol LayerContainer {
    /// The `Layer`s inside the container
    var     layers : [Layer] {get}
}

/// Standard functions provided by all `LayerContainer`s
public extension LayerContainer {

    /// Retreives the first `Layer` with the specified name
    ///     - Parameters:
    ///         - name : The name of the `Layer`
    ///     - returns: The `Layer` or `nil` if not found
    subscript(layerNamed name:String)->Layer?{
        for layer in layers {
            if layer.name == name {
                return layer
            }
        }
        return nil
    }
    
    /// All tile `Layer`s in the container together with their `TileGrid`
    var tileLayers : [(layer:Layer, grid:TileGrid)] {
        return layers.compactMap(){ (layer) -> (Layer, TileGrid)? in
            if case let Layer.Kind.tile(tileGrid) = layer.kind {
                return (layer,tileGrid)
            }
            return nil
        }
    }
    
    /// All group `Layer`s in the container together with the `Group` object, which is itself a `LayerContainer`
    var groupLayers : [(layer:Layer, group:Group)] {
        return layers.compactMap(){ (layer) -> (Layer, Group)? in
            if case let Layer.Kind.group(group) = layer.kind {
                return (layer,group)
            }
            return nil
        }
    }
    
    /// All object `Layer`s in the container together with their `Object`s
    var objectLayers : [(layer:Layer, objects:[Object])] {
        return layers.compactMap(){ (layer) -> (Layer, [Object])? in
            if case let Layer.Kind.objects(objects) = layer.kind {
                return (layer,objects)
            }
            return nil
        }
    }

    
    /// All image `Layer`s in the container together with their `ImageReference`s
    var imageLayers : [(layer:Layer, image:ImageReference)] {
        return layers.compactMap(){ (layer) -> (Layer, ImageReference)? in
            if case let Layer.Kind.image(image) = layer.kind {
                return (layer,image)
            }
            return nil
        }
    }


}
