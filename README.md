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

TiledKit works on all Apple & Linux platforms supporting Swift 5.3 or later. 

## Installation

TiledKit is distributed as a Swift package to be built with SPM. You can include it in your project by adding the following dependency to your `Package.swift` file

    .package(url: "https://github.com/SwiftStudies/TiledKit", from: "0.4")


## Available Specializations

  - [SpriteKit](https://github.com/SwiftStudies/SKTiledKit)
  
## Documentation

[Full API documentation](https://swiftstudies.github.io/TiledKit/Documentation/API/) is available for TiledKit
  
  
