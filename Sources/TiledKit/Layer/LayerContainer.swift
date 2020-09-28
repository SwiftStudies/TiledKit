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

/// Standard functions provided by all arrays with elements that can be considered a `Layer`
extension Array : LayerContainer where Element == Layer  {
    public var layers : [Layer] {
        return self
    }
}

/// The different `Error`s that can be thrown when filtering `Layer`s in a `LayerContainer`. The attached values
/// can be used to provide diagnostic information or recover from the error in many cases.
public enum LayerMatchingError : Error {
    /// No filters were provided so the size of the set will not change
    case noFiltersSpecified
    
    /// No layers matched the supplied filters
    case noLayersMatchedFilters
    
    /// When trying to select a specific layer type (e.g. with `objectLayer()`) and more than one layer
    /// matches. The matched layers are provided
    case multipleLayersMatchedFilters([Layer])
    
    /// When trying to select a specific layer type (e.g. with `objectLayer()`) and the single matching
    /// layer is of the wrong kind. The layer is included to assist with diagnostics
    case matchedLayerNonMatchingKind(Layer)
}

/// Core filtering function
public extension LayerContainer {
    func layers(filteredBy filters:[LayerFilter]) throws -> [Layer]{
        if filters.count == 0 {
            throw LayerMatchingError.noFiltersSpecified
        }
        
        let results = layers.filter { (layer) -> Bool in
            for filter in filters {
                if !filter.matches(layer){
                    return false
                }
            }
            return true
        }
        
        if results.count == 0 {
            throw LayerMatchingError.noLayersMatchedFilters
        }
        
        return results
    }
}
/// Standard functions provided by all `LayerContainer`s
public extension LayerContainer {
    
    
    
    /// Filters the `Layer`s contained by the supplied filters. It does no further type restriction although of course the `Layer.Kind`
    /// of the layer can be used to extract `Layer.Kind` specifc information
    ///
    /// - Parameter matching: Zero or more filters to use to reduce the set of matching layers
    /// - Throws: An exception will be thrown if there are no filters or no layers match
    /// - Returns: A new `LayerContainer` containing the filtered `Layer`s
    func layers(_ matching:LayerFilter...) throws -> [Layer] {
        return try layers(filteredBy: matching)
    }
    
    /// Returns a single `GroupLayer` that matches the supplied filters
    /// - Parameter matching: The filters that should result in a single `Layer` being identified
    /// - Throws: Any exception will be thrown if there are no filters, no layers match, or more than one layer matches the supplied filters
    /// - Returns: The matching `GroupLayer`
    func groupLayer(_ matching:LayerFilter...) throws -> GroupLayer {
        let matchingLayers = try layers(filteredBy: matching)
        
        if matchingLayers.count > 1 {
            throw LayerMatchingError.multipleLayersMatchedFilters(matchingLayers)
        }
        
        let matchedLayer = matchingLayers[0]
        
        if case let Layer.Kind.group(groupedLayers) = matchedLayer.kind {
            return GroupLayer(matchedLayer, children: groupedLayers.layers)
        } else {
            throw LayerMatchingError.matchedLayerNonMatchingKind(matchedLayer)
        }
    }

    /// Returns a single `ObjectLayer` that matches the supplied filters
    /// - Parameter matching: The filters that should result in a single `Layer` being identified
    /// - Throws: Any exception will be thrown if there are no filters, no layers match, or more than one layer matches the supplied filters
    /// - Returns: The matching `GroupLayer`
    func objectLayer(_ matching:LayerFilter...) throws -> ObjectLayer {
        let matchingLayers = try layers(filteredBy: matching)
        
        if matchingLayers.count > 1 {
            throw LayerMatchingError.multipleLayersMatchedFilters(matchingLayers)
        }
        
        let matchedLayer = matchingLayers[0]
        
        if case let Layer.Kind.objects(objects) = matchedLayer.kind {
            return ObjectLayer(matchedLayer, objects: objects)
        } else {
            throw LayerMatchingError.matchedLayerNonMatchingKind(matchedLayer)
        }
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
