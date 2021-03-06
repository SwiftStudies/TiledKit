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

/// Extends `Array`s of objects (as returned by `LayerContainer`s) so that `Object`s can be esily retreived
public extension Array where Element == Object {
    
    /// Get an `Object` from the array with matching based on the `objectId`
    /// - Parameters
    ///     - objectId: The desired id of the object
    /// - returns `nil` if no `Object` is found with that id
    subscript(id objectId:Int) -> Object? {
        for object in self {
            if object.id == objectId {
                return object
            }
        }
        return nil
    }
    
    /// Get an `Object` from the array with matching based on the object's `name`
    /// - Parameters
    ///     - objectName: The desired name of the object
    /// - returns `nil` if no `Object` is found with that name.
    subscript(name objectName:String) -> [Object] {
        return filter({$0.name == objectName})
    }
}
