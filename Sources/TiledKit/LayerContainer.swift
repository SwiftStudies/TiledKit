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

public enum LayerType : Decodable {
    case object, group, tile
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        switch try container.decode(String.self, forKey: .type){
        case "objectgroup":
            self = .object
        case "group":
            self = .group
        case "tilelayer":
            self = .tile
        default:
            fatalError("Unknown layer type")
        }
    }
    
    private enum CodingKeys : String, CodingKey {
        case type
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
//        var typeExposer     = try container.nestedUnkeyedContainer(forKey: Level.CodingKeys.layers)
//        var undecodedLayers = try container.nestedUnkeyedContainer(forKey: Level.CodingKeys.layers)
        var decodedLayers = [Layer]()
        
        var continueDecoding = true
        while continueDecoding {
            if let groupLayer = try? container.decode(GroupLayer.self, forKey: .group){
                decodedLayers.append(groupLayer)
            } else if let objectLayer = try? container.decode(ObjectLayer.self, forKey: .objectLayer) {
                decodedLayers.append(objectLayer)
            } else if let tileLayer = try? container.decode(TileLayer.self, forKey: .layers) {
                decodedLayers.append(tileLayer)
            } else if let imageLayer = try? container.decode(ImageLayer.self, forKey: .imageLayer) {
                decodedLayers.append(imageLayer)
            } else {
                continueDecoding = false
            }
        }
         
        
        
//        while !undecodedLayers.isAtEnd {
//            let layerType = try typeExposer.decode(LayerType.self)
//            switch layerType {
//            case .group:
//                decodedLayers.append(try undecodedLayers.decode(GroupLayer.self))
//            case .object:
//                decodedLayers.append(try undecodedLayers.decode(ObjectLayer.self))
//            case .tile:
//                decodedLayers.append(try undecodedLayers.decode(TileLayer.self))
//            }
//        }
        return decodedLayers
    }
}
