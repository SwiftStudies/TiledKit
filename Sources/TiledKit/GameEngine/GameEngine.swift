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

#warning("Absolutely hideous, I need to decide how I'm going to deal with the generics")
public protocol GameEngine {
    init()
    
    func create(tileSet:TileSet) throws
    func create<SpecialisedLevel>(level:Level) throws -> SpecialisedLevel
    
    func add(tile:Int, to tileSet:TileSet) throws
    func add(tileLayer:TileLayer, to container:Any) throws
    func add(group:GroupLayer, to container:Any) throws -> Any
    func add(image:ImageLayer, to container:Any) throws
    func add(objects:ObjectLayer, to container:Any) throws
    
    func container(for object:Any)->Any
}

public extension GameEngine {
    static func enable(){
        Tiled.default.set(specialization: Self.init())
    }
}
