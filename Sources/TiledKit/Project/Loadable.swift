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

/// Implemented by any type that wants to be loaded (and cached, and instanced) through the TiledKit `Project`
/// system. This makes it very easy to extend to a specific game engine.
public protocol Loadable {
    
    /// Construct and return a `ResourceLoader` suitable for the protocol implementer
    /// - Parameter project: The `Project` the `ResourceLoader` should work through to get any additional resources
    static func loader(for project:Project)->ResourceLoader
    
    /// Instances should return `false` if they should not be cached (perhaps they are very large, temporary, or change over time)
    var cache : Bool { get }
    
    /// When the `Loadable` has been cached this method will be called and if the object should create a copy of itself it can do it here.
    /// This is especially important for types that are classes as unless the instance is exactly the same (such as an image) and will not have
    /// been changed by previous instances, a copy should have been created. If it is acceptable that every instance of the `Loadable` is
    /// exactly the same object, the function can return `self`.
    func newInstance()->Self
}
