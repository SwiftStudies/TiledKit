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

public enum LayerType : String, CaseIterable {
    case object = "objectgroup", group = "group", tile = "layer", image = "imagelayer"
    
    var codingKey : Level.CodingKeys {
        switch self {
        case .object:   return .objectLayer
        case .group:    return .group
        case .image:    return .imageLayer
        case .tile:     return .layers
        }
    }
}

extension Layer {
    var type : LayerType {
        if self is GroupLayer {
            return .group
        } else if self is TileLayer {
            return .tile
        } else if self is ObjectLayer{
            return .object
        } else if self is ImageLayer{
            return .image
        }
        fatalError("Layer of unknown type")
    }
}

public protocol LayerContainer {
    var parent : LayerContainer {get}
    var layers : [Layer] {get}
}

extension LayerContainer {

    var level : Level {
        if let me = self as? Level {
            return me
        }
        return parent.level
    }

    
    public func getGroups(named name:String? = nil, matching conditions:[String:Literal] = [:], recursively:Bool = false)->[GroupLayer]{
        return getLayers(ofType: .group, named: name, matching: conditions, recursively: recursively) as! [GroupLayer]
    }

    public func getObjectLayers(named name:String? = nil, matching conditions:[String:Literal] = [:], recursively:Bool = false)->[ObjectLayer]{
        return getLayers(ofType: .object, named: name, matching: conditions, recursively: recursively) as! [ObjectLayer]
    }

    public func getTileLayers(named name:String? = nil, matching conditions:[String:Literal] = [:], recursively:Bool = false)->[TileLayer]{
        return getLayers(ofType: .tile, named: name, matching: conditions, recursively: recursively) as! [TileLayer]
    }
    
    public func getLayers(ofType type:LayerType, named name:String?, matching conditions:[String:Literal], recursively:Bool)->[Layer]{
        var matchingLayers = [Layer]()
        
        for layer in layers {
            var matches = true
            if layer.type == type {
                if let name = name, layer.name != name{
                    matches = false
                } else {
                    for (requiredProperty,requiredValue) in conditions {
                        if let layerValue = layer.properties[requiredProperty] {
                            if layerValue != requiredValue {
                                matches = false
                                break
                            }
                        } else {
                            matches = false
                            break
                        }
                    }
                }
            } else {
                matches = false
            }
            
            if matches {
                matchingLayers.append(layer)
            }
            
            // Done depth first to preserve over all top-to-bottom ordering
            if let group = layer as? GroupLayer, recursively {
                matchingLayers.append(contentsOf: group.getLayers(ofType: type, named: name, matching: conditions, recursively: true))
            }
        }
        
        return matchingLayers
    }
    
    static func decodeLayers(_ container:KeyedDecodingContainer<Level.CodingKeys>) throws ->[Layer]  {
        var decodedLayers = [Layer]()
        
        var groupLayers     = try container.decode([GroupLayer].self, forKey: .group)
        var tileLayers      = try container.decode([TileLayer].self, forKey: .layers)
        var imageLayers     = try container.decode([ImageLayer].self, forKey: .imageLayer)
        var objectLayers    = try container.decode([ObjectLayer].self, forKey: .objectLayer)

        for key in container.allKeys.map({$0.stringValue}) where LayerType.allCases.map({$0.rawValue}).contains(key){
            switch LayerType.init(rawValue: key)! {
            case .group:
                decodedLayers.append(groupLayers.removeFirst())
            case .object:
                decodedLayers.append(objectLayers.removeFirst())
            case .tile:
                decodedLayers.append(tileLayers.removeFirst())
            case .image:
                decodedLayers.append(imageLayers.removeFirst())
            }
        }
        
        return decodedLayers
    }
}
