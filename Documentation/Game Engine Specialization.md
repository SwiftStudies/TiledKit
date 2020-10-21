#  Getting TiledKit to get Tiled Maps into a Game Engine
Whilst it's academically interesting to build maps in Tiled and getting access to the data in Swift, the end goal is almost always (unless you are writing something to augment the data) to have that Tiled map as the foundation for level designs in your game. 

__Note__ that this piece of the API is being built ready for 0.5 of TiledKit and is subject to breaking changes outside of the normal semantic versioning system. Now would be a great time to highlight complexities and issues in applying it! 

## Artisinal Integrations
In the end you can skip this whole section, jump off to the Project or Map [API documentation](https://swiftstudies.github.io/TiledKit/Documentation/API/) and just load one up and parse the data structures yourself. Keeping that API easy and useful, particually for reading, is the primary goal of this module.

    import TiledKit

    let map = Project.default.retreive(map: "Test Map")
    
    
    for layer in map.layers {
        // Build your level from the map!
    }

There is absolutely nothing wrong with crafting your interpretation of the Tiled data through TiledKit this way, it's certainly much more efficient than trying to read the data directly. However, making it as quick as possible to turn the data into a playbable level is priority number 2. 

The following sections describe a different methodology that is much more prescriptive and enables you to focus on turning the objects Tiled captures into the appropriate entities in the specific game engine. Furthermore, it also allows gradual exposure of further specializaiton and custom behaviour _if_ it is needed, again with the intent of letting you focus on what you must do and understand rather than navigating
Tiled data structures. 

## Engine

The entry point for doing this is the Engine protocol. The goal of this protocol is to 

 * Capture the key types that are needed to represent Tiled objects in the specific game engine. For example, in Apple's SpriteKit each Tiled `Map` maps to a `SKScene`. It represents _most_ floating point properties with `CGFloat` and its family of types. 
 * Provide default implementations that enable the TiledKit consumer to focus on implementing that mapping with through focused protocol requirements. An example is that by default `Engine` will traverse the objects in a Tiled object layer, asking the protocol implementer to provide the game engine specific object that implements each object
 * Provide additional small API that can enable further automation of the mapping. Examples would include mapping the properties on a Tiled object to a property on the game engine's implementation. 
 
 In general as a first pass specialization you simply need to create a new object to represent the engine, identify the specific types, and impelment the required methods of the protocol. 
 
 ### Worked Example
 
 The first consideration is the types that represent the tiled entities with the specific game engine. 
