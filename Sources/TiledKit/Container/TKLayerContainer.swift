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

#warning("Rename when I move the old API out")

public protocol TKLayerContainer {
    var     layers : [TKLayer] {get}
}

public extension TKLayerContainer {
    /// Retreives a layer with the specified name
    subscript(layerNamed name:String)->TKLayer?{
        for layer in layers {
            if layer.name == name {
                return layer
            }
        }
        return nil
    }
    
    /// Retrieves all tile layers in a tuple container both the generic layer and the tile grid
    var tileLayers : [(layer:TKLayer, grid:TileGrid)] {
        return layers.compactMap(){ (layer) -> (TKLayer, TileGrid)? in
            if case let TKLayer.Kind.tile(tileGrid) = layer.kind {
                return (layer,tileGrid)
            }
            return nil
        }
    }
    
    /// Retrieves all group layers in a tuple container both the generic layer and the grouped layers
    var groupLayers : [(layer:TKLayer, group:Group)] {
        return layers.compactMap(){ (layer) -> (TKLayer, Group)? in
            if case let TKLayer.Kind.group(group) = layer.kind {
                return (layer,group)
            }
            return nil
        }
    }
    
    /// Retrieves all object layers in a tuple container both the generic layer and the contained objects
    var objectLayers : [(layer:TKLayer, objects:[TKObject])] {
        return layers.compactMap(){ (layer) -> (TKLayer, [TKObject])? in
            if case let TKLayer.Kind.objects(objects) = layer.kind {
                return (layer,objects)
            }
            return nil
        }
    }

    
    /// Retrieves all image layers in a tuple container both the generic layer and the associated image
    var imageLayers : [(layer:TKLayer, image:TKImage)] {
        return layers.compactMap(){ (layer) -> (TKLayer, TKImage)? in
            if case let TKLayer.Kind.image(image) = layer.kind {
                return (layer,image)
            }
            return nil
        }
    }


}
