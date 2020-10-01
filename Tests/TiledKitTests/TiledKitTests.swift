import XCTest
@testable import TiledKit

final class TiledKitTests: XCTestCase {
    
    fileprivate enum TestError : Error {
        case message(String)
    }
    
    func testResources() {
        XCTAssertNotNil(Bundle.module.path(forResource: "Test Map 1", ofType: "tmx", inDirectory: "Maps"))
    }
    
    func testSingleImageTileSet(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "SingleImageAutoTransparency", in: "Tilesets", of: .tsx)!)
            
            XCTAssertEqual(tileSet.tileSize.width, 16)
            XCTAssertEqual(tileSet.tileSize.width, 16)
            XCTAssertEqual(tileSet.count, 4)
            XCTAssertEqual(tileSet.properties.count, 1)
            XCTAssertEqual(tileSet.properties["filteringMode"], .string("nearest"))
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testSingleImageTileSetWithOptionals(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "SingleImageMarginsAndSpacing", in: "Tilesets", of: .tsx)!)
            
            XCTAssertEqual(tileSet.tileSize.width, 12)
            XCTAssertEqual(tileSet.tileSize.height, 12)
            XCTAssertEqual(tileSet.count, 4)
            XCTAssertEqual(tileSet[0]?.transparentColor ?? Color(r: 0, g: 0, b: 0), Color(r: 255, g: 0, b: 255))
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }

    func testMultiImageTileSetWithSingleTile(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "SeparateSingleImage", in: "Tilesets", of: .tsx)!)

            
            XCTAssertEqual(tileSet.tileSize.width, 16)
            XCTAssertEqual(tileSet.tileSize.height, 16)
            XCTAssertEqual(tileSet.count, 1)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testMultiImageTileSet(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "SeparateMultipleImages", in: "Tilesets", of: .tsx)!)

            
            
            XCTAssertEqual(tileSet.tileSize.width, 16)
            XCTAssertEqual(tileSet.tileSize.height, 16)
            XCTAssertEqual(tileSet.count, 2)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    lazy var moduleBundleProject : Project = {
        Project(using: Bundle.module)
    }()
    
    func loadTestMap(from project:Project, name:String? = nil, in subDirectory:String = "Maps") throws -> Map {
        if let name = name {
            return try project.get(name, in: subDirectory)
        }
        return try project.get("Test Map 1", in: "Maps")
    }
    
    func testMap(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        XCTAssertEqual(map.mapSize.width, 10)
        XCTAssertEqual(map.mapSize.height, 10)
        XCTAssertEqual(map.tileSize.width, 16)
        XCTAssertEqual(map.tileSize.height, 16)
        XCTAssertEqual(map.pixelSize.width, 160)
        XCTAssertEqual(map.pixelSize.height, 160)

        XCTAssertEqual(map.layers.count, 6)
        XCTAssertEqual(map.properties.count, 7)

        do {
            XCTAssertEqual(try map.layers(TileLayer.kind).count, 2) //level.getTileLayers().count
            
            XCTAssertEqual(try? map.layers(ObjectLayer.kind).count, 1) //level.getObjectLayers().count
            XCTAssertEqual(try? map.layers(GroupLayer.kind).count, 2) //level.getGroups().count

            let nestedImageLayer = try map.groupLayer(Layer.named("Group")).imageLayer(Layer.named("Grouped Image Layer"))
                        
            XCTAssertEqual(nestedImageLayer.name, "Grouped Image Layer")
            XCTAssertEqual(try map.tileLayer(TileLayer.kind, at:0).grid[0,0], TileGID(tileId: 0, flip: []))
            
            XCTAssertEqual(try map.tileLayer(TileLayer.kind,at:1).grid[0,0], TileGID(tileId: 5, flip: []))
            XCTAssertEqual(try map.tileLayer(TileLayer.kind, at:0).grid.size,  map.mapSize)
            XCTAssertEqual(nestedImageLayer.image.size, PixelSize(width: 16, height: 16))
            XCTAssertTrue(nestedImageLayer.image.source.path.hasSuffix("F.png"))
            XCTAssertEqual(try? map.layers(ObjectLayer.kind)[0].objects.count, 7)
        } catch {
            return XCTFail("Failed to filter layers \(error)")
        }

        
    }
    
    func testTileGrid(){
        
        guard let url = moduleBundleProject.url(for: "One of Everything", in: "Maps", of: .tmx), let map = try? moduleBundleProject.retrieve(asType: Map.self, from: url) else {
            XCTFail("Could not load map")
            return
        }
        
        XCTAssertEqual(try? map.tileLayer(TileLayer.kind, at:0).grid[0,1], 3)
        XCTAssertEqual(try? map.tileLayer(TileLayer.kind, at:0).grid[0,8], 3)
        XCTAssertEqual(try? map.tileLayer(TileLayer.kind, at:0).grid[9,9], 1)
    }
    
    func testColor(){
        XCTAssertEqual(Color(from: "ff00ff"), Color(r: 255, g: 00, b: 255))
        XCTAssertEqual(Color(from: "#ff00ff"), Color(r: 255, g: 00, b: 255))
        XCTAssertEqual(Color(from: "7f000000"), Color(r: 0, g: 0, b: 0, a: 127))
        XCTAssertEqual(Color(from: "#7f000000"), Color(r: 0, g: 0, b: 0, a: 127))
        
        let failure = Color(r: 255, g: 0, b: 255, a: 255)
        XCTAssertEqual(Color(from: "gggggg"), failure)
        XCTAssertEqual(Color(from: "#gggggg"), failure)
        XCTAssertEqual(Color(from: "gggggggg"), failure)
        XCTAssertEqual(Color(from: "#gggggggg"), failure)
    }
    
    func testObjectLayer(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = try? map.layers(ObjectLayer.kind).first else {
            XCTFail("No object layer")
            return
        }
        
        XCTAssertEqual(objectLayer.objects[name: "Elipse"].count, 1)
        guard let imageObject = objectLayer.objects[id:7] else {
            XCTFail("Could not find imageObject by id")
            return
        }

        XCTAssertEqual(imageObject.name, "Tile")
    }
    
    func testTextObject(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = try? map.layers(ObjectLayer.kind).first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer.objects[name:"Text"].first else {
            XCTFail("Could not get object")
            return
        }
        
        switch  object.kind {
        case .text(let string, let size, let rotation, let style):
            XCTAssertEqual(string, "Bottom")
            XCTAssertEqual(style.horizontalAlignment, .left)
            XCTAssertEqual(style.verticalAlignment, .top)
            XCTAssertEqual(style.fontFamily, "Courier New")
            XCTAssertEqual(style.pixelSize, 8)
            XCTAssertEqual(style.wrap, true)
            XCTAssertEqual(style.color, Color(r: 32, g: 255, b: 255, a: 255))
            XCTAssertEqual(style.bold, false)
            XCTAssertEqual(style.italic, false)
            XCTAssertEqual(style.underline, false)
            XCTAssertEqual(style.strikeout, false)
            XCTAssertEqual(rotation, 0)
            XCTAssertEqual(size, Size(width: 31.5087, height: 8.20547))
        default:
            XCTFail("Object is not a text object")
        }
                
}

    func testElipseObject(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = try? map.layers(ObjectLayer.kind).first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer.objects[name: "Elipse"].first else {
            XCTFail("Could not get object")
            return
        }
        
        switch object.kind {
        case .ellipse(let size, let rotation):
            XCTAssertEqual(rotation, 45)
            XCTAssertEqual(size, Size(width: 96, height: 96))
        default:
            XCTFail("Object is not an ElipseObject")
        }
        
    }

    func testRectangleObject(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = try? map.layers(ObjectLayer.kind).first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer.objects[name: "Rectangle"].first else {
            XCTFail("Could not get object")
            return
        }
        XCTAssertEqual(object.id, 4)
        XCTAssertEqual(object.position.x, 128.027)
        XCTAssertEqual(object.position.y, 19.5807)

        switch object.kind {
        case .rectangle(let size, let rotation):
            XCTAssertEqual(rotation, 0)
            XCTAssertEqual(size, Size(width: 15.8151, height: 12.3007))
        default:
            XCTFail("Object is not a Rectangle")
        }
    }

    func testImageObject(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = try? map.layers(ObjectLayer.kind).first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer.objects[name: "Tile"].first else {
            XCTFail("Could not get object")
            return
        }
        XCTAssertEqual(object.id, 7)
        XCTAssertEqual(object.position.x, 13.2425)
        XCTAssertEqual(object.position.y, 40.4335)

        switch object.kind {
        case .tile(let gid, let size, let rotation):
            XCTAssertEqual(gid, TileGID(tileId: 1, flip: []))
            XCTAssertEqual(rotation, 45)
            XCTAssertEqual(size, Size(width: 16, height: 16))
            guard let tile = map[gid] else {
                XCTFail("Tile is not in level tile dictionary")
                return
            }
            
            XCTAssertEqual(tile.imageSource.lastPathComponent, "4 Tiles.png")
            XCTAssertEqual(tile.bounds, PixelBounds(origin: Point.zero, size: Dimension(width:16,height: 16)))
        default:
            XCTFail("Object is not a Tile")
        }
    }

    func testImageLayer(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject)
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let imageLayer = try? map.imageLayer(ImageLayer.kind, at:0 ) else {
            XCTFail("No image layer")
            return
        }
        
        
        XCTAssertEqual(imageLayer.position.x, 72)
        XCTAssertEqual(imageLayer.position.y, 48)
        XCTAssertTrue(imageLayer.image.source.standardized.path.hasSuffix("Resources/Images/Individual/F.png"), "URL is incorrect \(imageLayer.image.source)")
    }
    
    func testOneOfEverything(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject, name: "One of Everything" )
        } catch {
            XCTFail("\(error)")
            return
        }

        guard let objectLayer = try? map.layers(ObjectLayer.kind).first else {
            return XCTFail("Could not find object layer")
        }

        guard let groupLayer = try? map.layers(GroupLayer.kind).first else {
            return XCTFail("Could not find group layer")
        }
        
        XCTAssertEqual(objectLayer.position.x, 16)
        XCTAssertEqual(objectLayer.position.y, 16)
        
        XCTAssertEqual(groupLayer.position.x, 144)
        XCTAssertEqual(groupLayer.position.y, 80)
    }

    func testMultipleProperties(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "Animation", in: "Tilesets", of: .tsx)!)


            //Confirm loading multiline properties works OK
            XCTAssertEqual(tileSet.properties["filteringMode"],"nearest")
            XCTAssertNotNil(tileSet.properties["User Property"])
        } catch {
            XCTFail("\(error)")
        }
    }

    
    func testTileSetCollisionObjects(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "Animation", in: "Tilesets", of: .tsx)!)

            guard let collisionBodies = tileSet[0]?.collisionBodies else {
                XCTFail("Tile or collision bodies not found")
                return
            }
            
            XCTAssertEqual(collisionBodies.count, 2)
            XCTAssertLessThan(collisionBodies[0].position.x - 7.92176, 0.1)
            XCTAssertLessThan(collisionBodies[1].position.y - 3.00272, 0.1)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testTileSetAnimationFrames(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TileSet.self, from: moduleBundleProject.url(for: "Animation", in: "Tilesets", of: .tsx)!)

            
            guard let frames = tileSet[1]?.frames else {
                XCTFail("No tile with id 1, or no frames")
                return
            }
            
            XCTAssertEqual(frames.count, 4)
            XCTAssertEqual(frames[0].tile.bounds.origin, Point(x: 0, y: 0))
            XCTAssertEqual(frames[0].duration, 1)
            XCTAssertEqual(frames[1].tile.bounds.origin, Point(x: 16, y: 0))
            XCTAssertEqual(frames[1].duration, 1)
            XCTAssertEqual(frames[2].tile.bounds.origin, Point(x: 0, y: 16))
            XCTAssertEqual(frames[2].duration, 1)
            XCTAssertEqual(frames[3].tile.bounds.origin, Point(x: 16, y: 16))
            XCTAssertEqual(frames[3].duration, 1)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testTileObjectScaling(){
        guard let map = try? loadTestMap(from: moduleBundleProject) else {
            XCTFail("Could not load map")
            return
        }
        
        let objectLayer : ObjectLayer
        do {
            objectLayer = try map.groupLayer(Layer.named("Translating Group")).layers.objectLayer(Layer.named("Translated Objects"))
        } catch {
            return XCTFail("Failed to get object layer \(error)")
        }
        
        if let tileObject = objectLayer.objects(named: "Stretched Tile")?.first {
            if case let Object.Kind.tile(_,size,_) = tileObject.kind {
                XCTAssertEqual(size, Size(width: 16, height: 32))
                return
            } else {
                XCTFail("Incorrect object type")
            }
        } else {
            XCTFail("Could not find object with name")
        }
    }
    
    func testObjectTypeDefinitions(){
        guard var objectTypes = try? moduleBundleProject.retrieve(asType: ObjectTypes.self, from: "Object Types", of: .objectTypeDefinitionFile) else {
            return XCTFail("Could not load object type definitions")
        }
        
        XCTAssertEqual(objectTypes.count, 1)
        XCTAssertEqual(objectTypes["Object Type"]?.color, Color(from: "#fd6fcf"))
        XCTAssertEqual(objectTypes["Object Type"]?["File Unset"], .file(url: URL(fileURLWithPath: "")))
        XCTAssertEqual(objectTypes["Object Type"]?.allPropertyNames.count, 11)
        
        var objectDefinition = objectTypes["Object Type"]!
        objectDefinition["File Unset"] = .file(url: URL(fileURLWithPath: "Something else"))
        
        
        objectTypes["Object Type"] = objectDefinition
        
        XCTAssertNotEqual(objectTypes["Object Type"]?["File Unset"], .file(url: URL(fileURLWithPath: "")))
    }
    
    func testWritingObjectTypeDefinition(){
        do {
            var objectTypes = ObjectTypes()
            
            objectTypes["Test"] = ObjectType(color: Color(r: 255, g: 0, b: 0))
            objectTypes["Test"]?["String Property"] = "Hello"
            objectTypes["Test"]?["Int Property"] = 42

            objectTypes["Test 2"] = ObjectType(color: Color(r: 0, g: 0, b: 255))
            objectTypes["Test 2"]?["Float Property"] = 42.42
            objectTypes["Test 2"]?["Bool Property"] = true

            let url = FileManager.default.temporaryDirectory.appendingPathComponent("test write.xml")
            try objectTypes.write(to: url)
            
            let readObjectTypes = try Project.default.retrieve(asType: ObjectTypes.self, from: url)
            
            XCTAssertEqual(readObjectTypes.count, objectTypes.count)
            XCTAssertEqual(readObjectTypes.allNames.sorted(), objectTypes.allNames.sorted())
            for objectTypeName in readObjectTypes.allNames {
                guard let originalObjectType = objectTypes[objectTypeName] else {
                    return XCTFail("Could not get original object type")
                }
                guard let writtenAndReadObjectType = readObjectTypes[objectTypeName] else {
                    return XCTFail("Could not get re-read object type")
                }
                
                XCTAssertEqual(originalObjectType.color, writtenAndReadObjectType.color)
                XCTAssertEqual(originalObjectType.allPropertyNames.sorted(), writtenAndReadObjectType.allPropertyNames.sorted())
                for property in writtenAndReadObjectType.allPropertyNames {
                    let originalProperty = originalObjectType[property]
                    let writtenAndReadProperty = writtenAndReadObjectType[property]
                    XCTAssertEqual(originalProperty, writtenAndReadProperty)
                }
            }
        } catch {
            return XCTFail("Could not write object types")
        }
    }
    
    static var allTests = [
        ("testWritingObjectTypeDefinition",testWritingObjectTypeDefinition),
        ("testObjectTypeDefinitions", testObjectTypeDefinitions),
        ("testTileObjectScaling",testTileObjectScaling),
        ("testTileGrid", testTileGrid),
        ("testMap",testMap),
        ("testMultiImageTileSetWithSingleTile",testMultiImageTileSetWithSingleTile),
        ("testMultiImageTileSet",testMultiImageTileSet),
        ("testSingleImageTileSetWithOptionals", testSingleImageTileSetWithOptionals),
        ("testResources", testResources),
        ("testSingleImageTileSet", testSingleImageTileSet),
        ("testColor", testColor),
        ("testTextObject", testTextObject),
        ("testElipseObject", testElipseObject),
        ("testRectangleObject", testRectangleObject),
        ("testImageObject", testImageObject),
        ("testImageLayer", testImageLayer),
        ("testOneOfEverything", testOneOfEverything),
        ("testTileSetCollisionObjects", testTileSetCollisionObjects),
        ("testTileSetAnimationFrames", testTileSetAnimationFrames),
    ]
}
