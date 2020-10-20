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

internal struct EngineRegistry {
    private static var registry = [String:[Any]]()
    
    private static func makeKey<E:Engine>(`for` engine:E.Type)->String{
        return "\(type(of: E.self))"
    }
    
    static func isEmpty<E:Engine>(`for` engine:E.Type)->Bool{
        return !(registry[makeKey(for: engine.self)]?.isEmpty ?? true)
    }
    
    static func insert<T:EngineObject,EngineType>(`for` engine:EngineType.Type, object:T) where T.EngineType == EngineType{
        let key = makeKey(for: engine.self)
        
        if registry[key] == nil {
            registry[key] = []
        }
        registry[key]!.insert(object, at: 0)
    }
    
    static func get<T:EngineObject,EngineType>(`for` engine:EngineType.Type)->[T] where T.EngineType == EngineType{
        return registry[makeKey(for: engine.self)]?.compactMap({
            $0 as? T
        }) ?? []
    }
    
    static func removeAll<E:Engine>(`from` engine:E.Type) {
        registry[makeKey(for: engine.self)]?.removeAll()
    }
}
