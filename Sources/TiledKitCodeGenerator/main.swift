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


let allProducers : Set = [
    ProducerType(name: "MapFactory", wrapperType: "AnyMapFactory"),
    ProducerType(name: "MapPostProcessor", wrapperType: "AnyEngineMapPostProcessor"),
    ProducerType(name: "TilePostProcessor", wrapperType: "AnyTilePostProcessor"),
    ProducerType(name: "TileFactory", wrapperType: "AnyTileFactory"),
    ProducerType(name: "LayerFactory", wrapperType: "AnyLayerFactory"),
    ProducerType(name: "LayerPostProcessor", wrapperType: "AnyLayerPostProcessor"),
    ProducerType(name: "ObjectFactory", wrapperType: "AnyObjectFactory"),
    ProducerType(name: "ObjectPostProcessor", wrapperType: "AnyObjectPostProcessor"),
]

print("Generating Engine.register() for Producer variants...")
let result = generateProducerRegistrationFunctions(for: allProducers)

let engineProducersUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("TiledKit/Game Engines/EngineProducers.swift")

do {
    try result.write(to: engineProducersUrl, atomically: true, encoding: .utf8)
    print("Done, saved to \(engineProducersUrl.path)")
} catch {
    print("Failed to save to \(engineProducersUrl.path):\n\(error.localizedDescription)")
}

