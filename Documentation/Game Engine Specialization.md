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
 
 In general as a first pass specialization you simply need to create a new object to represent the engine, identify the specific types, and impelment the required methods of the protocol. The basic approach you should take is:
 
  1. Create your `Engine` type
  2. Identify your target game engine types that map to the tiled kit types (see Basic Types and Mapping Map Entities)
  3. Achieve required protocol conformance for your target types. This will help you shake out any issues with your plan (such as the protocol requires a type can have child entities, but your game engine type doesn't support that). All of the requirements are described in detail below
  4. Achieve protocol conformance for your `Engine` type
  5. Extend standard behaviour with any further specialization of your choice!
 
 ### Worked Example
 
 The first consideration is the types that represent the tiled entities with the specific game engine. To help with this I've created a simple game engine called [TextEngine](https://github.com/SwiftStudies/TextEngine) to use to render the our Tiled Maps. Getting started is very easy, normally we aren't developing our own game engine, but using one that's already available. In this case, [TextEngine](https://github.com/SwiftStudies/TextEngine). 
     
     import TiledKit
     import TextEngine

     public struct TextEngine : Engine {
         
     }

Note that we've simply defined a `TextEngine` object which implements TiledKit's `Engine`. The first thing you are going to get is an error telling you `TextEngine` doesn't conform to `Engine`, so let's get started working through the requirements. 

#### Basic Types

The first thing we need to do is ensure the varies values from Tiled's data structure can be converted into our target engines format. We will need to deal with things like tiles and polygons, but before we get there it's best to start with the fundamental types. The type requirements are communicated through associated types in the `Engine` protocol. The two key data types you should address first are these

    public typealias FloatType = Double
    public typealias ColorType = Character

By defining these you get a lot of automation mapping between the data in Tiled and your specific game engine. Note the color type is a bit strange in this case, but [TextEngine](https://github.com/SwiftStudies/TextEngine) is just a textual game engine (Rouge anyone?) so all we have is a `Character`. In order to do the automatic mapping there are some requirements for these two types. There's no need to do anything if your type is already a `BinaryFloatingPoint` but if your engine has a fixed point or indeed you want to control the converstion you can extend your target type to meet `ExpressibleAsTiledFloat`. 

In general you will know how colors are represented in your engine and you'll have a target type. You just need to extend it to conform to `ExpressibleAsTiledColor` which has a single requirement:

    static func instance(bridging color: Color) -> Self

As you can see, it just lets you define how a TiledKit (Color)[] maps to your specific color type. 

#### Mapping Map Entities

Once these are defined the next set of decisions to make are how Tiled maps and the entities in them (like groups and tile layers) are giong to be represented. Again, this is done with a set of associated types for you to type alias. It looks like quite a long list, but it's a very simple process. Let's go through them one by one. The little code snippets map to the type in [TextEngine](https://github.com/SwiftStudies/TextEngine), but you should obviously replace with your target. All of these type need to be extended to implement a protocol called `EngineObject`. We will come back to this later, it's very simple to do as you'll see later. In general this is the only requirement for the different types you reference, and in most engines there's a smart place to do it (e.g. in `SpriteKit` `SKNode` is a great place to do it, as almost everything else is automatically done)

 - `public typealias MapType = Screen` The map type is exactly what it sounds like, the type that will represent the entire map in the game engine. This maps directly to the screen object in [TextEngine](https://github.com/SwiftStudies/TextEngine), if we were to look at SpriteKit it would be `SKScene`. We will look at this in more detail below but `MapType` must conform to an additional protocol unique to it and `GroupLayerType`, and that is `LayerContainer`. In short these two types must be able to contain other layers. You'll see more on it later, and the requirements are very easy to satisy. They also must support `Loadable`, although most of the requirements of `Loadable` will be met autoatically, a couple of decisions are left available to you the implementer, depending on your needs and the environment your games will be running in. 
 - `public typealias TextureType = Character` typically this is type that your game engine loads images into. It's not directly rendered into the map, but will be used to create sprites and tiles. In this case we can only use characters (because [TextEngine](https://github.com/SwiftStudies/TextEngine) is just a textual engine), but you'll be able to see more later. 
 - `public typealias SpriteType = Sprite` The type used to draw actual tiles in a tile layer, an image layer, or an image object. [TextEngine](https://github.com/SwiftStudies/TextEngine) has a sprite object, so this is perfect! `SpriteType` must support a protocol called `DeepCopyable`, this means that it is possible to create a new instance, that is completely distinct but has all of the same attributes and values. If you are familiar with Apple's APIs, this is similar to conforming to `NSCopyable` in ObjectiveC. As with all the other protocols, we will discuss the requirements in more detail later. Game engines normally support this for all of the objects that can appear in their scene so that you can for example, create a single space invader, and then cloan it tens of times to create a challenge for the player. 
 - `public typealias TileLayerType = Node` The type used to contain the grid of tiles, note that it's not unusual for all of the layer types to be the same type. You can get some simplification from your impllementation later on using that fact, but specialization requires you to be explicit. 
 - `public typealias GroupLayerType = Node` The type used represent Tiled groups, which can contain other layers and capture hierarchy. As mentioned above  `GroupLayerType` must conform to an additional protocol `LayerContainer`.  
 - `public typealias ObjectLayerType = Node` The type used represent a layer that contains objects in Tiled. As you can see all of the different layer types (with the exception of image layers, they are represented by the `SpriteType`) are the same. Object layers contain objects, and as a result have an additional constraint to satisy, `ObjectContainerType`. We will look at what's involved in that later.  
 - `public typealias PointObjectType = Dot` The remaining entities to map are all Tiled objects that live in Tiled layers. The simplest is of course just a point. 
 - `public typealias RectangleObjectType = Box` The type that will represent a rectangle object. These types can be extreemley useful for creating special engine specific behaviours and structures, but we will get to that later. Let's move quickly through the rest
 - `public typealias EllipseObjectType = Ellipse` The type to represent an ellipse in Tiled
 - `public typealias TextObjectType = Node` The type to represent a text object in tiled. [TextEngine](https://github.com/SwiftStudies/TextEngine) doesn't support this (now I come to think of it... that's not smart!) so I'll just use an empty `Node`. When you start you might want to do something similar, and just start with something simple like `RectangleType` to get something up on the screen.
 - `public typealias PolylineObjectType = Polygon` The type to represent a polyline in Tiled. 
 - `public typealias PolygonObjectType = Polygon` The type to represent a closed polygon in Tiled. Note that the type in [TextEngine](https://github.com/SwiftStudies/TextEngine) is the same as that for `PolylineObjectType`, that's not unusual and I'll show you how you can control the creation of the actual instance later. 
 
 #### Conforming to `EngineObject`
 
 To automate a lot of the process of mapping `EngineObject` actually has only one requirement, here's the pertinent part of the protocol definition:
 
     public protocol EngineObject {
         /// The specific game engine the object supports
         associatedtype EngineType : Engine
     }

That really is it... you just need to extend to support the requirement. The `EngineType` is used to ensure that all of the different types form a single whole that can represent anything in Tiled.

#### Conforming to `DeepCopyable`
As mentioned earlier, DeepCopyable is very similar to Apple's NSCopying protocol. Here's how they describe it

> NSCopying
>
> A protocol that objects adopt to provide functional copies of themselves.
>
> The exact meaning of “copy” can vary from class to class, but __a copy must be a functionally independent object with values identical to the original at the time the copy was made...__

The section in bold is key. Think of the anything that is `DeepCopyable` as being clonable. The clone is exactly the same, with exactly the same attributes... but it is independant. We can put it in a different place, we can change those attributes without changing the source. The protocol has a single required function

    func deepCopy()->Self

You are responsible for creating that copy. Here's an example from [TextEngine](https://github.com/SwiftStudies/TextEngine) for the `Sprite` type

    public func copy() -> Self {
        return Sprite(at: position, with: size, rendering: character) as! Self
    }

As you can see, it explicitly creates a new instance, using it's position, size, and "texture". 

#### Conforming to `EngineMap` 

Your `MapType` must conform to `EngineMap`. This protocol combines another protocol `LayerContainer`, but that is covered below. Let's focus on the other two protocol requirements first... here they are from the `Screen` class in [TextEngine](https://github.com/SwiftStudies/TextEngine)

    extension Screen : EngineMap {
        // Conformances for LayerContainer are described below
        
        // Should Screen's be cached? 
        public var cache: Bool {
            return true
        }
        
        // Should screens clone themselves, or are do they have type semenatics? 
        public func newInstance() -> Self {
            return copy()
        }
    }

If you return or set `cache` to `true` then TiledKit will automatically cache your map once it has been loaded, and subsequent requests to load that map will result in a copy() of that cached copy being made. In most cases you will want to return `true` here, but it has been left to you to decide. 

> __Note__
> In the future a `cache` implementation will not be required if your  `MapType` also conforms to `DeepCopyable` as we know we can safely create functional equivalent new instances at that point

`newInstance()` enables you to implement any specific behaviour when a new instance is created from a cached copy. If you are not caching, just return `self`. If you are and your `MapType` has reference semantics you will want to make a copy. Essentially you should think about this in the same way as `DeepCopyable` described above.  

#### Conforming to `EngineTexture`
Unless you need to do something special with texture loading, you can ignore this completely. The right behaviour will be synthesized for you when you implement the protocol requirements for `EngineTexture`. Think very carefully before overriding these default synthesized behaviours, they are implemented to minimize memory consumption and maximize re-use.

    extension Character : EngineTexture {    
        public typealias EngineType = TextEngine

        public func newInstance() -> Character {
            return self
        }
    }
    
The requirement for newInstance as that you return a new instance which is independent but ideally does not have multiple copies of the source image in memory. In this example our `TextureType` is just a character 
so it really doesn't matter, but if you imagine you have an image type but your texture could have different post processing effects you would store the details about those post processing effects in the `TextureType` but just reference the same image. 

#### Conforming to `LayerContainer`

Both `MapType`s and `GroupLayerType`s must conform to `LayerContainer`. The protocol requires four functions for compliance

    func add(layer:EngineType.TileLayerType)
    func add(layer:EngineType.GroupLayerType)
    func add(sprite:EngineType.SpriteType)
    func add(layer:EngineType.ObjectLayerType)

As you can see, essentially four functions for adding child layers of each of the four types. Note however that typically game engines have a homogenous rendering hierarchy.... that means "everything can contain everything". You can see this in [TextEngine](https://github.com/SwiftStudies/TextEngine). Everything inherits from `Node`. In SpriteKit, everything inherits from `SKNode`. Typically you will have a specific type for `SpriteType`, but other layers will all be the same type. This results in `MapType` and `GroupType` (both of which are derived from `Node`) just needing to extend `Node` with two methods to conform to the protocol. 

    extension Node : EngineLayerContainer {
        public func add(layer: Node) {
            add(child: layer)
        }

        public func add(sprite: Sprite) {
            add(child: sprite)
        }
    }
    
And that's it, you have nothing else to consider. This pattern is almost always applicable (at least I've not used a modern game engine where it isnt').

#### Conforming to `ObjectContainer`

`ObjectLayerType`s must implement `ObjectContainer`. Essentially it's analogous to `LayerContainer`, but this time there is a protocol require a function to add one of each of the different object types that Tiled supports. 

Again, most modern game engines have some base "node" type that any other node type can be added to, and [TextEngine](https://github.com/SwiftStudies/TextEngine) is no different. This results in a very simple functions to conform, and typically you will have exactly the same thing

    extension Node : EngineObjectContainer {
        public func add(text: Node) {
            add(child: text)
        }

        public func add(ellipse: TextEngine.EllipseObjectType) {
            add(child: ellipse)
        }

        public func add(polygon: TextEngine.PolygonObjectType) {
            add(child: polygon)
        }

        public func add(polyline: TextEngine.PolylineObjectType) {
            add(child: polyline)
        }

        public func add(rectangle: TextEngine.RectangleObjectType) {
            add(child: rectangle)
        }

        public func add(sprite: Sprite) {
            add(child: sprite)
        }

        public func add(point: TextEngine.PointObjectType) {
            add(child: point)
        }
    }

 #### That was easy... what's next? 
 
Now it is a simple matter of filling out the remaining methods to actually create an instance of a Tiled Map. The specialization engine will do the hard work of walking through the structure and creating as many of the objects as it can, and just asking you to make any instances you need to and giving you can chance to read and adjust basdd on the tiled object properties. We'll group them into five sections: Loading Images, Tilesets, Creating the Map, Creating Layers, and Adding Objects. In each, and example is shown from [TextEngine](https://github.com/SwiftStudies/TextEngine). 

 #### Loading Images
 
 Rember the `TextureType` from above. It's the container for images loaded, and the specialization engine will manage figuring out exactly what needs to be loaded and caching. It will ask you to do just two things: actually load the image data in the format your sprites will need (`TextureType`) and creating "slices" of them if your tile-set uses a single image. Let's take a look at those two functions and their implementation for [TextEngine](https://github.com/SwiftStudies/TextEngine). 

    public static func load<LoaderType>(textureFrom url: URL, by loader: LoaderType) throws -> Character where LoaderType : EngineImageLoader {
        return url.lastPathComponent.first!
    }

    public static func make(texture: Character, with bounds: PixelBounds?, and properties: Properties, in project: Project) throws -> Character {
        return texture
    }

 The `load()` function is exactly that, here you load and create the image and return it for caching. In this case we can't really load an image into a character, so we just make the "texture" the first character of the `URL`. Often your code will be as simple as calling an initializer with the URL. 
 
 The `make()` funciton can require a little bit more work, when creating tiles later on, if your Tileset is of a Single Image type you will need to create a sub-image for just that regiion. The `make()` function lets you do that, passing in `bounds` if there is a sub-region needed. It's also supplied with any properites of the individual tile, and that provides you an oppertunity, if needed, to adjust how you create the texture (perhaps pre-applying a tint to a texture).  

#### Tilesets

There are two functions that will be called for each tile in a tilset. The first, `make()` requires you create the basic tile object you will render and it is called for every tile in the tileset, before a second pass is made. In this case we look for a `"Character"` property on the tile which as a `String` value. If so we use that as the texture for the tile, otherwise we use the one that was created by the loaded image (see above). Obviously this isn't what you will want to do, but it does illustrate the principle... make and instance of the tile looking at any of its properties to control specializaed behavior that makes sense for your engine. 

    public static func make(spriteFor tile: Tile, in tileset: TileSet, with texture: Character, from project: Project) throws -> Sprite {
        
        var texture = texture
        if let characterProperty = tile.properties["Character"] {
            if case let PropertyValue.string(value) = characterProperty {
                texture = value.first ?? texture
            }
        }
        
        return Sprite(at: (0,0), with: (tileset.tileSize.width, tileset.tileSize.height), rendering: texture)
    }

The second pass calls `process()` for each tile, and this is your chance, now all tiles have been made with any images created, to add in any animation effects that depend on the other tiles existing. 

    public static func process(_ sprite: Sprite, from tile: Tile, in tileset: TileSet, with setSprites: [UInt32 : Sprite], for map: Map, from project: Project) throws -> Sprite {
        return sprite
    }

The specialization engine will deal with any sectioning of images, leaving you to focus on creating the tile object that will be repeated multiple times as layers are built up. 

#### Creating the Map

Map creation works very much like tile creation. You will be first be asked to create the basic map object for your engine, and then the content of the map will be loaded (creating layers and adding in the objects), before finally you will be given a chance to do any post-processing on your map. 

    public static func make(mapFor tiledMap: Map) throws -> Screen {
        return Screen(size: (tiledMap.pixelSize.width, tiledMap.pixelSize.height))
    }

When `make()` is called you are typically going to simply ensure your representation of map is created with the right size etc, but of course you may chose to do more work if you wish (such as looking at the properties and loading other files you have specified as properites on the map). 

    public static func process(engineMap specializedMap: Screen, for tiledMap: Map, in project: Project) throws -> Screen {
        return specializedMap
    }
    
Again, the `process()` function is a chance for you to do any special post-processing of the map, now fully populated with all of the layers and objects you created. For example, if the Tiled map is huge, you may want to have a tiled Rectangle that represents the viewport or camera onto the level. Now would be a great time to grab that rectangle and apply it. You can see an example of this in the SpriteKit specialization in [SKTiledKit](https://github.com/SwiftStudies/SKTiledKit) where a rectangle represents the `SKCamera` object, and can be set to track a sprite in the level, all from within Tiled. 

#### Creating Layers

I'm sure by this point you can guess how this is working. You will implement four functions, one for each type of layer. To create that layer. You don't need to do anything more than create the layer in each case, TiledKit will walk into that layer and make subsequent calls to add in the specific objects or sub-layers needed allowing you to keep the code simple and clean; focused on just creating the right object. Because of this, if your specific game engine is homogenous (any node in the rendering hierarchy conforms to some super implmentation), these methods might all call a single "just make a container node" function. You might however want to do different things based on properites of the layers, such as creating a complex object in your game engine for a special property on a group layer. 

    public static func make(spriteFrom texture: Character, for layer: LayerProtocol, in map: Map, from project: Project) throws -> Sprite? {
        #warning("Need to actually represent textures that have a size")
        let position = layer.position.transform
        let size : TextEngine.Size = (1,1)
        return Sprite(at: position, with: size, rendering: "S")
    }

The above function will be called for an image layer. Note that essentailly an image layer is treated as a sprite for an image that doesn't exist in a tileset. Again, the specialization engine will use your `load()` function to load the image, passing it to you here so that you can just focus on getting it in the game engine view. 

    public static func make(objectContainerFrom layer: LayerProtocol, in map: Map, from project: Project) throws -> Node? {
        return Node(at: layer.position.transform)
    }
    
For object layers you will typically want to just create a container layer, but again you could chose to do something specific based on properties. In this example, we just create a node at the required position. It will be passed back to you later on when the specialization engine starts asking you to create specific objects. 

    public static func make(groupFrom layer: LayerProtocol, in map: Map, from project: Project) throws -> Node? {
        return Node(at: layer.position.transform)
    }

Group layers are really just containers, but they do give you an opppertunity to apply effects to everythign they contain for example. In the above example we just create a node at the correct position.  

    public static func make(tileLayer tileGrid: TileGrid, for layer: LayerProtocol, with sprites: MapTiles<TKTextEngine>, in map: Map, from project: Project) throws -> Node? {

        let layerNode = Node(at: layer.position.transform)
        
        for x in 0..<tileGrid.size.width{
            for y in 0..<tileGrid.size.height {
                if let sprite = sprites[tileGrid[x,y]] {
                    sprite.position = (x*map.tileSize.width, y*map.tileSize.height)
                    layerNode.add(child: sprite)
                } else {
                    TKTextEngine.warn("Not not get a sprite for the tile at \(x),\(y) in tile layer \(layer.name)")
                }
            }
        }

        return layerNode
    }

Tile layers are the most complex, you are passed the grid which you must interpret and add a new instance of each tile. At the moment as TiledKit only supports orthogonal tile layers this is not complex, but as support is extended you will need to ensure that you understand each different layout.  

> __Note__ The API here will change in 0.6 of TiledKit. Instead of you being passed the grid of tiles, you will just be asked to create a tile
> layer container, and the specialization engine will make multiple calls to the same `make(sprite...)` function for adding an object 
> allowing the specializaiton engine to do the work of interpretting the grid for you. 

#### Adding Objects

There's quite a few functions to implement here, but each of them is very simple. You just have to create an object of the right type and put it in the right place for each of the objects Tiled can represent. If you don't want to use one of the tiled objects... don't. Just return an empty object or some placeholder. You can see we don't represent text objects in [TextEngine](https://github.com/SwiftStudies/TextEngine) so I just return an empty node. 

    public static func make(pointFor object: ObjectProtocol, in map: Map, from project: Project) throws -> Dot {
        return Dot(at:object.position.transform)
    }
    
You are typically going to use point objects to capture something you don't render about a level, but your game needs to know (perhaps something is triggered there) so exactly what you do is often specific to not just your engine, but your game. As a result I typically return something generic here and then override this later for a specific game (see [Super Specialization](/Super%20Specialization.md) when you are ready to take things a little further). 

    public static func make(rectangleOf size: TiledKit.Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> Box {
        return Box(at: object.position.transform, of: size.transform)
    }
    
Like many of these objects, you are probably providing some very game specific information with objects, here we are asked to create a rectangle. In [TextEngine](https://github.com/SwiftStudies/TextEngine) we actually create a `Box` object, place it in the right location and send it back. 

    public static func make(ellipseOf size: TiledKit.Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> Ellipse {
        return Ellipse(at: object.position.transform, of: size.transform)
    }
    
I think you are getting the idea now! Create something to represent an ellipse, perhaps looking at the properties to determine exactly how the ellipse should be interpretted. 

    public static func make(polylineWith path: Path, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TextEngine.Polygon {
        return TextEngine.Polygon(at: object.position.transform, path: path.compactMap({$0.transform}), closed: false)
    }

    public static func make(polygonWith path: Path, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> TextEngine.Polygon {
        return TextEngine.Polygon(at: object.position.transform, path: path.compactMap({$0.transform}), closed: true)
    }
    
I've grouped polylines and polygons together. They are essentially the same except one is a chain of points, and one is a loop. All of the other shape principles apply. I often use these objects to represent rigid bodies in a game engine... but your game might be an original asteroids clone and you want to draw the line!

    public static func make(textWith string: String, of size: TiledKit.Size, at angle: Double, with style: TextStyle, for object: ObjectProtocol, in map: Map, from project: Project) throws -> Node {
        return Node(at: object.position.transform)
    }
    
It is perhaps unexpected that the most complex object to create is often text. All of the tiled styling information is passed along for you to create and display text (perhaps it's character dialog or the level introduction text). Create the appropriate object in your game engine and return it. In this case [TextEngine](https://github.com/SwiftStudies/TextEngine)  doesn't support text so I just return an empty node. 

    public static func make(spriteWith tile: Sprite, of size: TiledKit.Size, at angle: Double, for object: ObjectProtocol, in map: Map, from project: Project) throws -> Sprite {
        let copy = tile.deepCopy()
        copy.position = object.position.transform
        copy.size = size.transform
        return copy
    }
    
Finally image objects are really just "bespoke" tile placements. You are passed an instance of the tile to create which will subsequently be placed appropriately in the secene.

### Wrapping Up

It can feel like a lot of things to get implemented but they key here is TiledKit tries to keep each function very self contained and focused on asking you create an instance of some tiled object, giving you _just_ the right context you need and allowing you to keep each implementation very very simple. It typically only takes an hour or so to make the decisions about which game engine objects are best for each Tiled type... and then fill in the stubs... you will find you are up and running very quickly. Wondering about how things turned out in [TextEngine](https://github.com/SwiftStudies/TextEngine)? Here's the output of a Tiled Level (and just for a little flair... you can see the console output from [TextEngine](https://github.com/SwiftStudies/TextEngine)  on the right, and the same map being rendered by SpriteKit using [SKTiledKit](https://github.com/SwiftStudies/SKTiledKit) on the left!).

![One Tiled Map, Two Engines Rendering It](Documentation/Images/TiledKit.png)





