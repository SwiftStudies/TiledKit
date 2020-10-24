<p align="center">
<a href="https://swift.org/"><img src="https://img.shields.io/badge/Swift-5.3-orange.svg?style=flat" style="max-height: 300px;" alt="Swift"/></a>
<img src="https://img.shields.io/badge/platforms-Linux%20%7C%20MacOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-green.svg" alt="Platforms">

<a href="https://travis-ci.org/SwiftStudies/OysterKit">
<img src="https://travis-ci.org/SwiftStudies/TiledKit.svg?branch=master" alt="Build Status - Master">
</a>
<img src="https://img.shields.io/badge/documentation-98%25-brightgreen.svg" alt="Documentation Coverage">
</p>

# TiledKit

<p align="center"><img src="Documentation/Images/TiledKit.png" width="200" /></p>

A Swift Package for reading [Tiled](https://www.mapeditor.org) levels that makes it easy to specialize the loaded level/sheets etc for a specifc game engine. 

To simply load a map and any associated tilesets it is as simple as 

        import TiledKit
        
        let map = Project.default.retreive(map: "Test Map")
        print ("Hello, \(map.name)!")

The primary use of TiledKit will be enable you to convert the maps you design in Tiled into playable games using a game engine, and there is significant support
for doing that quickly and efficiently (as well as open source projects that already capture them such as [SpriteKit](https://github.com/SwiftStudies/SKTiledKit)). 
You can find documentation aimed at guiding you through that process [Game Engine Specialization](/Documentation/Game%20Engine%20Specialization.md). 

Here's an example of a single Tiled level being rendered by two different specializations in TiledKit (bottom right, [TextEngine](https://github.com/SwiftStudies/TextEngine) in the console output, bottom left [SpriteKit using SKTiledKit](https://github.com/SwiftStudies/SKTiledKit)))

<p align="center"><img src="https://swiftstudies.github.io/TiledKit/Documentation/Images/Multiple%20Game%20Engines.png" width="500" /></p>

TiledKit works on all Apple & Linux platforms supporting Swift 5.3 or later. 

## Installation

TiledKit is distributed as a Swift package to be built with SPM. You can include it in your project by adding the following dependency to your `Package.swift` file

    .package(url: "https://github.com/SwiftStudies/TiledKit", from: "0.5.0")

## Available Specializations

  - [SpriteKit](https://github.com/SwiftStudies/SKTiledKit)
  
## Documentation

[Full API documentation](https://swiftstudies.github.io/TiledKit/Documentation/API/) is available for TiledKit
  
  
