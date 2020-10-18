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

/// Adds support for adding `PostProcessor`s and `Factories` that support multiple types
public extension Engine {
    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: EngineMapFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory, Producer: EngineMapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: LayerFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: EngineMapFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: MapPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: ObjectFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: EngineMapFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: TileFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerPostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: EngineMapFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: EngineMapFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: TilePostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: EngineMapFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: EngineMapFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: TilePostProcessor, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: EngineMapFactory, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: EngineMapFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: EngineMapFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: EngineMapFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

    /// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
    /// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
    static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory {
        EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
    }

}
