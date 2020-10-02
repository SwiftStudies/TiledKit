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

import XMLCoder
import TKCoding
import Foundation

/// Object types represent pre-defined sets of objects that can be applied to Tiled objects. `ObjectTypes` captures
/// these definitions and enables both reading and writing of the file of definitions. That can be useful for programmatically
/// creating the object types for use in Tiled.
public struct ObjectTypes : Loadable {
    
    /// Returns the `ResourceLoader` for `ObjectTypes`
    public static func loader(for project: Project) -> ResourceLoader {
        return ObjectTypesLoader(project: project)
    }
    
    
    /// ObjectType files are not cached
    public let cache = false
    
    /// The number of definitions
    public var count : Int {
        return definitions.count
    }
    
    /// Creates a new instance of this object
    public func newInstance() -> ObjectTypes {
        return self
    }
    
    /// The defined `ObjectType`s
    fileprivate var definitions : [String:ObjectType]
    
    /// Get or set an object with the specified name
    public subscript(_ named:String) -> ObjectType?{
        get {
            return definitions[named]
        }
        set {
            definitions[named] = newValue
        }
    }
    
    /// The names of all defined `ObjectType`s
    public var allNames : [String] {
        return definitions.keys.map({$0.description})
    }
    
    public func write(to url:URL) throws {
        let types = definitions.map { (name,objectType) -> XMLObjectType in
            
            let properties = objectType.allPropertyNames.map { (propertyName) -> XMLObjectTypeProperty in
                let propertyValue = objectType[propertyName]!
                
                return XMLObjectTypeProperty(propertyName, type: propertyValue.xmlType.rawValue, default: propertyValue.xmlValue)
            }
            
            return XMLObjectType(name, color: objectType.color.tiledFormatDescription, properties: properties)
        }
        
        let xmlVersion = XMLObjectTypes(with:types)
        let encoder = XMLEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        let data = try encoder.encode(xmlVersion, withRootKey: "objecttypes", rootAttributes: nil, header: XMLHeader(version: 1.0, encoding: "UTF-8", standalone: nil))

        try data.write(to: url)
    }
    
    /// Creates a new instance of an ObjectTypes object
    public init(){
        url = nil
        definitions = [:]
    }
    
    /// Does not load, just sets the url the definitions were loaded from
    init(_ url:URL){
        self.url = url
        definitions = [:]
    }
    
    private var url : URL?
}

/// An `ObjectType` captures a set of properties and their default values that can be applied to any
/// Tiled object
public struct ObjectType  {
    private var properties = [String:PropertyValue]()
    
    /// Retrieves or sets the named property
    public subscript(_ name:String)->PropertyValue? {
        get {
            return properties[name]
        }
        
        set {
            properties[name] = newValue
        }
    }
        
    /// The color objects of this type should be rendered in
    public var color : Color
    
    /// Returns all of the property names
    public var allPropertyNames : [String] {
        return properties.keys.map({$0})
    }
    
    /// Creates a new instance of `ObjectType` with the specified name and color
    /// - Parameters:
    ///   - color: The color of the object type
    public init(color:Color) {
        self.color = color
    }
}

struct ObjectTypesLoader : ResourceLoader {
    let project : Project
    
    func retrieve<R>(asType: R.Type, from url: URL) throws -> R where R : Loadable {
        let types = try XMLObjectTypes(from: url)
        
        var objectTypes = ObjectTypes(url)
        for type in types.types {
            var objectType = ObjectType(color: Color(from: type.color))
            
            for property in type.properties {
                objectType[property.name] = PropertyValue(as: property.type, with: property.default ?? "")
            }
            
            objectTypes[type.name] = objectType
        }
        
        
        if let loaded = objectTypes as? R {
            return loaded
        }
        
        throw ResourceLoadingError.unsupportedType(loaderType: "Object Types XML", unsupportedType: "\(R.self)")
    }
    
    
}
