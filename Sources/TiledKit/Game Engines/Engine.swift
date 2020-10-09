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

/// The entry point for any game engine specialization. See [Game Engine Specialization](../../Game%20Engine%20Specialization.md)
public protocol Engine {
    /// The most common lossless way of expressing a float in the engine
    associatedtype FloatType : ExpressibleAsTiledFloat
    
    /// The type that captures `Color`s in the engine
    associatedtype ColorType : ExpressibleAsTiledColor
}

/// Provides common diagnostic capabilites to any engine specialization
public extension Engine {
    static func warn(_ message:String){
        print("Warning: \(message)")
    }
}

/// Captures an object that is important for a given game engine (and will be involved in automated maping etc). In general only
/// game engine types that map directly to Tiled entities will need to support this
public protocol EngineObject {
    /// The specific game engine the object supports
    associatedtype EngineType : Engine
}
