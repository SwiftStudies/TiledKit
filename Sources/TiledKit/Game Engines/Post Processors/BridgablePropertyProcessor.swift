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

public struct BridgablePropertyProcessor<TargetType:EngineObject> : TiledKit.MapPostProcessor, TiledKit.LayerPostProcessor, TiledKit.ObjectPostProcessor {

    public typealias EngineType = TargetType.EngineType
    
    private struct AnyProperty<EngineObjectType:EngineObject> : BridgableProperty {
        var tiledName: String
        
        var tiledDefault: PropertyValue
        
        var engineObjectProperty: PartialKeyPath<EngineObjectType>
        
        init<TBP:BridgableProperty>(_ bridgableProperty:TBP) where TBP.EngineObjectType == EngineObjectType {
            tiledName = bridgableProperty.tiledName
            tiledDefault = bridgableProperty.tiledDefault
            engineObjectProperty = bridgableProperty.engineObjectProperty
        }
    }
    
    private var allBridgedProperties = [AnyProperty<TargetType>]()
    private var applicableTiledTypes : TiledType
    private var applicableTypeName   : String?
    
    public init<TBP:BridgableProperty, C:Sequence>(applies properties:C, to tiledTypes:TiledType, with typeName:String? = nil) where TBP.EngineObjectType == TargetType, C.Element == TBP {
        
        allBridgedProperties.append(contentsOf: properties.map({AnyProperty($0)}))
        applicableTiledTypes = tiledTypes
        applicableTypeName = typeName
    }
    
    func process<O:EngineObject>(target engineObject:O, source:Propertied)->O{
        guard let target = engineObject as? TargetType else {
            return engineObject
        }
        
        guard source.is(a: applicableTiledTypes) else {
            return engineObject
        }
        
        guard source.properties.hasProperty(in: allBridgedProperties) else {
            return engineObject
        }
        
        allBridgedProperties.apply(source.properties, to: target)
        
        return engineObject
    }
        
    public func process(engineMap: TargetType.EngineType.MapType, for map: Map, from project: Project) throws -> TargetType.EngineType.MapType {
        return process(target: engineMap, source: map)
    }
        
    public func process(objectLayer: EngineType.ObjectLayerType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.ObjectLayerType {
        return process(target: objectLayer, source: layer)
    }
    
    public func process(tileLayer: EngineType.TileLayerType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.TileLayerType {
        return process(target: tileLayer, source: layer)
    }
    
    public func process(tileInstance: TargetType.EngineType.SpriteType, from tile: Tile, and tileset: TileSet, in layer: LayerProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.SpriteType {
        return process(target: tileInstance, source: tile)
    }
    
    public func process(imageLayer: EngineType.SpriteType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.SpriteType {
        return process(target: imageLayer, source: layer)
    }
    
    public func process(groupLayer: EngineType.GroupLayerType, from layer: LayerProtocol, for map: Map, in project: Project) throws -> EngineType.GroupLayerType {
        return process(target: groupLayer, source: layer)
    }
    
    
    private func appliesTo(_ objectTypeName:String?)->Bool {
        guard let applicableTypeName = applicableTypeName else {
            return true
        }
        
        return applicableTypeName == objectTypeName
    }
    
    public func process(point: TargetType.EngineType.PointObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.PointObjectType {

        return appliesTo(object.type) ? process(target: point, source: object) : point
    }
    
    public func process(rectangle: TargetType.EngineType.RectangleObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.RectangleObjectType {
        return appliesTo(object.type) ? process(target: rectangle, source: object) : rectangle
    }
    
    public func process(ellipse: TargetType.EngineType.EllipseObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.EllipseObjectType {
        return appliesTo(object.type) ? process(target: ellipse, source: object) : ellipse

    }
    
    public func process(sprite: TargetType.EngineType.SpriteType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.SpriteType {
        return appliesTo(object.type) ? process(target: sprite, source: object) : sprite

    }
    
    public func process(text: TargetType.EngineType.TextObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.TextObjectType {
        return appliesTo(object.type) ? process(target: text, source: object) : text

    }
    
    public func process(polyline: TargetType.EngineType.PolylineObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.PolylineObjectType {
        return appliesTo(object.type) ? process(target: polyline, source: object) : polyline

    }
    
    public func process(polygon: TargetType.EngineType.PolygonObjectType, from object: ObjectProtocol, for map: Map, from project: Project) throws -> TargetType.EngineType.PolygonObjectType {
        return appliesTo(object.type) ? process(target: polygon, source: object) : polygon

    }
}
