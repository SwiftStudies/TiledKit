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

/// Adds some functions to manage `Producer`s
public extension Engine {
    /// `true` if there are any factories or post processors registered
    static var hasProducers : Bool {
        return EngineRegistry.isEmpty(for: Self.self)
    }
    
    /// Removes all factories that have been registered for the engine
    static func removeProducers() {
        EngineRegistry.removeAll(from: Self.self)
    }
}

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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyEngineMapPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: LayerPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: LayerPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyLayerPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TileFactory {
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TileFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTileFactory(wrap: producer))
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
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: MapFactory, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyMapFactory(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: ObjectPostProcessor, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyObjectPostProcessor(wrap: producer))
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

	/// Add a new post processor to the post processors for the `Engine`, new post processors  are tried first
	/// - Parameter producer: The `EngineProducer` to be registered. All of the appropriate capabilities will be registered (e.g. MapFactory & MapPostProcessor)
	static func register<Producer>(producer:Producer) where Producer.EngineType == Self, Producer: TilePostProcessor {
		EngineRegistry.insert(for: Self.self, object: AnyTilePostProcessor(wrap: producer))
	}

}
