[![Build Status](https://travis-ci.org/SwiftStudies/TiledKit.svg?branch=master)](https://travis-ci.org/SwiftStudies/TiledKit)

# TiledKit

A Swift Package for reading [Tiled](https://www.mapeditor.org) levels that makes it easy to specialize the loaded level/sheets etc for a specifc game engine. 

To simply load a map and any associated tilesets it is as simple as 

        import TiledKit
        
        let map = Project.default.retreive(map: "Test Map")
        print ("Hello, \(map.name)!")

TiledKit works on all Apple & Linux platforms supporting Swift 5.3 or later. 

## Installation

TiledKit is distributed as a Swift package to be built with SPM. You can include it in your project by adding the following dependency to your `Package.swift` file

    .package(url: "https://github.com/SwiftStudies/TiledKit", from: "0.4")


## Available Specializations

  - [SpriteKit](https://github.com/SwiftStudies/SKTiledKit)
  
## Documentation

[Full API documentation](https://swiftstudies.github.io/TiledKit/Documentation/API/) is available for TiledKit
  
  
