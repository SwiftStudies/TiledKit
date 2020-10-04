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

/// An `ObjectFilter` is used when querying `LayerContainer`s to select one or more matching `Objects`s and
/// are responsible for determining if any given `Object` meets a set of criteria
public protocol ObjectFilter {
    
    /// Determines If the supplied `Object` meets the criteria of the `ObjectFilter`
    /// - Parameter object: The `Object` to evaluate
    /// - returns `true` if it matches, `false` if not
    func matches(_ object:Object) -> Bool
}

internal struct BlockObjectFilter : ObjectFilter {
    let block : (Object)->Bool
    
    func matches(_ object: Object) -> Bool {
        return block(object)
    }
}

/// Extends arrays of objects to enable filtration and searching
internal extension Array where Element == Object {
    /// Filters the elements of the array by the supplied flters
    /// - Parameter filters: The `ObjectFilter`s to use
    /// - Returns: A filtered array
    func objects(matching filters: [ObjectFilter]) -> Self {
        return filter { (object) -> Bool in
            for filter in filters {
                if !filter.matches(object) {
                    return false
                }
            }
            return true
        }
    }
}

/// Extends all `LayerContainer`s to support filtering
public extension LayerContainer {
    
    /// Retreives all of the objects contained by the layers of the container that match the supplied filters
    /// - Parameters:
    ///   - recursiveSearch: If `true` any groups will be recursively searched for the objects
    ///   - filters: The `LayerFilter`s objects must match
    /// - Returns: All matching `Object`s
    internal func objects(deep recursiveSearch:Bool = true, matching filters: [ObjectFilter] ) -> [Object] {
        var filteredObjects = [Object]()
        for layer in layers {
            switch layer.kind {
            case .objects(let objects):
                filteredObjects.append(contentsOf: objects.objects(matching: filters))
            case .group(let group) where recursiveSearch:
                filteredObjects.append(contentsOf: group.objects(deep: recursiveSearch, matching: filters))
            default: break
            }
        }
        
        return filteredObjects
    }
    
    /// Retreives all of the objects contained by the layers of the container that match the supplied filters
    /// - Parameters:
    ///   - recursiveSearch: If `true` any groups will be recursively searched for the objects
    ///   - filters: The `LayerFilter`s objects must match
    /// - Returns: All matching `Object`s
    func objects(deep recursiveSearch:Bool = true, matching filters: ObjectFilter...) -> [Object] {
        var filteredObjects = [Object]()
        for layer in layers {
            switch layer.kind {
            case .objects(let objects):
                filteredObjects.append(contentsOf: objects.objects(matching: filters))
            case .group(let group) where recursiveSearch:
                filteredObjects.append(contentsOf: group.objects(deep: recursiveSearch, matching: filters))
            default: break
            }
        }
        
        return filteredObjects
    }
}

/// Adds common `ObjectFilter`s
extension Object {
    /// Combines two filters into one that is matched if either of the two filters matches
    /// - Parameters:
    ///   - firstfilter: If matched, this filter will match
    ///   - secondFilter: If matched, this filter will match
    /// - Returns: `true` if either filter is matched
    static func isEither(_ firstfilter:ObjectFilter, or secondFilter:ObjectFilter)->ObjectFilter{
        return BlockObjectFilter(block: {firstfilter.matches($0) || secondFilter.matches($0)})
    }
    
    /// Returns a filter for objects with the supplied name
    /// - Parameter name: The desired `name` of the object
    /// - Returns: An `ObjectFilter` for `Object`s with that name
    static func isNamed(_ name:String)->ObjectFilter {
        return BlockObjectFilter(block: {$0.name == name})
    }
    
    /// Returns a filter for objects of the supplied type
    /// - Parameter type: The desired `type` of the object
    /// - Returns: An `ObjectFilter` for `Object`s with that type
    static func isOf(type:String)->ObjectFilter {
        return BlockObjectFilter(block: {$0.type != nil ? $0.type! == type : false})
    }
    
    /// An object filter for points
    static var isPoint : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.point = $0.kind {
                return true
            } else {
                return false
            }
        })
    }

    /// An object filter for rectangles
    static var isRectangle : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.rectangle = $0.kind {
                return true
            } else {
                return false
            }
        })
    }

    /// An object filter for ellipses
    static var isEllipse : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.ellipse = $0.kind {
                return true
            } else {
                return false
            }
        })
    }

    /// An object filter for tiles
    static var isTile : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.tile = $0.kind {
                return true
            } else {
                return false
            }
        })
    }
    
    /// An object filter for text
    static var isText : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.text = $0.kind {
                return true
            } else {
                return false
            }
        })
    }

    /// An object filter for lines
    static var isPolyline : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.polyline = $0.kind {
                return true
            } else {
                return false
            }
        })
    }

    /// An object filter for polygons
    static var isPolygon : ObjectFilter {
        return BlockObjectFilter(block: {
            if case Object.Kind.polygon = $0.kind {
                return true
            } else {
                return false
            }
        })
    }
}
