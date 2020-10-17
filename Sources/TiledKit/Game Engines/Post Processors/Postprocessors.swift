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

/// Processors are applied after creation and can even completely recreate the
/// specialized target. However, in most cases they will process and apply properties
public protocol PostProcessor : EngineObject {
    
}


/// Adds support for adding `PostProcessor`s that support multiple types
public extension Engine {
    #warning("API: Rename anypostprocessor to postProcessor and delete all other methods")
    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter postProcessor: The new post processor
    static func register<P:PostProcessor>(anyPostProcessor postProcessor:P) where P.EngineType == Self {
  
        
        
    }
}
