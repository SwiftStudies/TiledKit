#  Getting TiledKit to get Tiled Maps into a Game Engine
Whilst it's academically interesting to build maps in Tiled and getting access to the data in Swift, the end goal is almost always (unless you are writing something to augment the data) to have that Tiled map as the foundation for level designs in your game. Before you go any further, it's worth looking to see if someone has already done the hard work. Here are the specialisations that are already availble. 

 - __SpriteKit__ [SKTiled](https://github.com/SwiftStudies/SKTiledKit) A sprite kit implementation that even integrates with Tiled itself to let you quickly test your level in Tiled & SpriteKit without even going to Xcode!
 - __TextEngine__ [TextEngine (TKTextEngine package)](https://github.com/SwiftStudies/TextEngine) Actually this example walks through how you build this implementation. It's not a fully fledged game engine, but it is a good simple example. 

If you don't see what you want, read on. When you've done it then please create a PR or raise an issue so I can add a link here

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
 
 The first consideration is the types that represent the tiled entities with the specific game engine. To help with this I've created a simple game engine called [TextEngine]() to use to render the our Tiled Maps. Getting started is very easy, normally we aren't developing our own game engine, but using one that's already available. In this case, TextEngine. 
     
     import TiledKit
     import TextEngine

     public struct TextEngine : Engine {
         
     }

Note that we've simply defined a `TextEngine` object which implements TiledKit's `Engine`. The first thing you are going to get is an error telling you `TextEngine` doesn't conform to `Engine`, so let's get started working through the requirements. 

#### Basic Types

The first thing we need to do is ensure the varies values from Tiled's data structure can be converted into our target engines format. We will need to deal with things like tiles and polygons, but before we get there it's best to start with the fundamental types. The type requirements are communicated through associated types in the `Engine` protocol. The two key data types you should address first are these

    public typealias FloatType = Double
    public typealias ColorType = Character

By defining these you get a lot of automation mapping between the data in Tiled and your specific game engine. Note the color type is a bit strange in this case, but TextEngine is just a textual game engine (Rouge anyone?) so all we have is a `Character`. In order to do the automatic mapping there are some requirements for these two types. There's no need to do anything if your type is already a `BinaryFloatingPoint` but if your engine has a fixed point or indeed you want to control the converstion you can extend your target type to meet `ExpressibleAsTiledFloat`. 

In general you will know how colors are represented in your engine and you'll have a target type. You just need to extend it to conform to `ExpressibleAsTiledColor` which has a single requirement:

    static func instance(bridging color: Color) -> Self

As you can see, it just lets you define how a TiledKit (Color)[] maps to your specific color type. 

#### Mapping Map Entities

Once these are defined the next set of decisions to make are how Tiled maps and the entities in them (like groups and tile layers) are giong to be represented. Again, this is done with a set of associated types for you to type alias. It looks like quite a long list, but it's a very simple process. Let's go through them one by one. The little code snippets map to the type in TextEngine, but you should obviously replace with your target. All of these type need to be extended to implement a protocol called `EngineObject`. We will come back to this later, it's very simple to do as you'll see later. In general this is the only requirement for the different types you reference, and in most engines there's a smart place to do it (e.g. in `SpriteKit` `SKNode` is a great place to do it, as almost everything else is automatically done)

 - `public typealias MapType = Screen` The map type is exactly what it sounds like, the type that will represent the entire map in the game engine. This maps directly to the screen object in TextEngine, if we were to look at SpriteKit it would be `SKScene`. 
 - `public typealias TextureType = Character` typically this is type that your game engine loads images into. It's not directly rendered into the map, but will be used to create sprites and tiles. In this case we can only use characters (because TextEngine is just a textual engine), but you'll be able to see more later. 
 - `public typealias SpriteType = Sprite` The type used to draw actual tiles in a tile layer, an image layer, or an image object. TextEngine has a sprite object, so this is perfect!
 - `public typealias TileLayerType = Node` The type used to contain the grid of tiles, note that it's not unusual for all of the layer types to be the same type. You can get some simplification from your impllementation later on using that fact, but specialization requires you to be explicit. 
 - `public typealias GroupLayerType = Node` The type used represent Tiled groups, which can contain other layers and capture hierarchy. 
 - `public typealias ObjectLayerType = Node` The type used represent a layer that contains objects in Tiled. As you can see all of the different layer types (with the exception of image layers, they are represented by the `SpriteType`) are the same. 
 - `public typealias PointObjectType = Dot` The remaining entities to map are all Tiled objects that live in Tiled layers. The simplest is of course just a point. 
 - `public typealias RectangleObjectType = Box` The type that will represent a rectangle object. These types can be extreemley useful for creating special engine specific behaviours and structures, but we will get to that later. Let's move quickly through the rest
 - `public typealias EllipseObjectType = Ellipse` The type to represent an ellipse in Tiled
 - `public typealias TextObjectType = Node` The type to represent a text object in tiled. TextEngine doesn't support this (now I come to think of it... that's not smart!) so I'll just use an empty `Node`. When you start you might want to do something similar, and just start with something simple like `RectangleType` to get something up on the screen.
 - `public typealias PolylineObjectType = Polygon` The type to represent a polyline in Tiled. 
 - `public typealias PolygonObjectType = Polygon` The type to represent a closed polygon in Tiled. Note that the type in TextEngine is the same as that for `PolylineObjectType`, that's not unusual and I'll show you how you can control the creation of the actual instance later. 
 
 #### EngineObject
 
 To automate a lot of the process of mapping `EngineObject` actually has only one requirement, here's the pertinent part of the protocol definition:
 
     public protocol EngineObject {
         /// The specific game engine the object supports
         associatedtype EngineType : Engine
     }
     
That really is it... you just need to extend to support the requirement
 
 #### That was easy... what's next? 
 
 That's it, and you can 90% of the code just by asking Swift to fill out the stubs for you, just leaving you to make a few decisions. Of course... the next thing Swift will want to do is create all the stubs for the funcitons. I'm going to step through these one by one below, using the order to describe them to let you incrementally build up your understanding of the structure of a specialization. 
 
 #### Loading Images
 
 Rember the `TextureType` from above. It's the container for images loaded. 

