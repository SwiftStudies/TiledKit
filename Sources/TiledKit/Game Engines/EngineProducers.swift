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

/// Producers are responsible for creating and post-processing `Engine` specific objects representing Tiled objects. `Engine` implementors
/// must provide basic similar funcitonality but those can be the most generic realizations of Tiled objects, with specific producers created to
/// perform more specialized work, stopping `Engine`s from becoming overly complex in a single type.
public protocol Producer : EngineObject {
}

/// Adds support for adding `PostProcessor`s and `Factories` that support multiple types
public extension Engine {
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: TilePostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: TilePostProcessor, Producer: TileFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: MapFactory, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: MapFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapFactory, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TileFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: TileFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: LayerFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: TileFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: TilePostProcessor, Producer: TileFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: TilePostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: MapFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: MapFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TilePostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TilePostProcessor, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: LayerFactory, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: LayerFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TilePostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TilePostProcessor, Producer: TileFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TilePostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory, Producer: TilePostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: MapFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: MapFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: MapFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: MapFactory, Producer: LayerPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: LayerFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: LayerFactory, Producer: TileFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: MapFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: LayerPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: ObjectFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: ObjectPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TileFactory, Producer: LayerFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory, Producer: ObjectFactory, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

}
