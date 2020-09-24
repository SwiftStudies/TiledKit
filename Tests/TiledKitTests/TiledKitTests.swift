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
            guard let url = Bundle.module.url(forResource: "SingleImageAutoTransparency", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            
            let tileSet = try TileSet(from: url)
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tiles.count, 4)
            XCTAssertEqual(tileSet.properties.count, 1)
            XCTAssertEqual(tileSet.properties["filteringMode"], .string("nearest"))
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testSingleImageTileSetWithOptionals(){
        do {
            guard let url = Bundle.module.url(forResource: "SingleImageMarginsAndSpacing", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            
            let tileSet = try TileSet(from: url)
            XCTAssertEqual(tileSet.tileWidth, 12)
            XCTAssertEqual(tileSet.tileHeight, 12)
            XCTAssertEqual(tileSet.tiles.count, 4)
            switch tileSet.type{
            case .sheet(let tileSheet):
                XCTAssertEqual(tileSheet.transparentColor, Color(r: 255, g: 0, b: 255))
            default:
                XCTFail("Should be a tilesheet")
            }
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }

    func testMultiImageTileSetWithSingleTile(){
        do {
            guard let url = Bundle.module.url(forResource: "SeparateSingleImage", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            
            let tileSet = try TileSet(from: url)
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tiles.count, 1)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testMultiImageTileSet(){
        do {
            guard let url = Bundle.module.url(forResource: "SeparateMultipleImages", withExtension: "tsx", subdirectory: "Tilesets") else {
                XCTFail("Could not find TileSet in bundle")
                return
            }
            
            let tileSet = try TileSet(from: url)
            XCTAssertEqual(tileSet.tileWidth, 16)
            XCTAssertEqual(tileSet.tileHeight, 16)
            XCTAssertEqual(tileSet.tiles.count, 2)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func loadTestLevel(url:URL? = nil) throws -> Level {
        guard let url = url ?? Bundle.module.url(forResource: "Test Map 1", withExtension: "tmx", subdirectory: "Maps") else {
            throw TestError.message("Failed to get URL for default Test Map 1")
        }
        
        return try Level(from: url)
    }
    
    lazy var moduleBundleProject : Project = {
        Project(using: Bundle.module)
    }()
    
    func loadTestMap(from project:Project, name:String? = nil, in subDirectory:String? = nil) throws -> Map {
        if let name = name {
            return try project.get(map: name, in: subDirectory)
        }
        return try project.get(map: "Test Map 1", in: "Maps")
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

        XCTAssertEqual(map.tileLayers.count, 2) //level.getTileLayers().count
        XCTAssertEqual(map.objectLayers.count, 1) //level.getObjectLayers().count
        XCTAssertEqual(map.groupLayers.count, 2) //level.getGroups().count

        let nestedImageLayer = map.groupLayers[0].group.imageLayers[0]
        XCTAssertEqual(nestedImageLayer.layer.name, "Grouped Image Layer")

        XCTFail("Impelement everything below")

//        XCTAssertEqual(level.getObjectLayers()[0].objects.count, 7)
//        XCTAssertEqual(level.getTileLayers()[0].tiles.count, 100)
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
        let level : Level
        do {
            level = try loadTestLevel()
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = level.getObjectLayers().first else {
            XCTFail("No object layer")
            return
        }
        
        XCTAssertEqual(objectLayer["Elipse"].count, 1)
        guard let imageObject = objectLayer[7] else {
            XCTFail("Could not find imageObject by id")
            return
        }

        XCTAssertEqual(imageObject.name, "Tile")
    }
    
    func testTextObject(){
        let level : Level
        do {
            level = try loadTestLevel()
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = level.getObjectLayers().first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer["Text"].first else {
            XCTFail("Could not get object")
            return
        }
        
        guard let textObject = object as? TextObject else {
            XCTFail("Object is not a TextObject")
            return
        }
        
        XCTAssertEqual(textObject.string, "Bottom")
        XCTAssertEqual(textObject.style.horizontalAlignment, .left)
        XCTAssertEqual(textObject.style.verticalAlignment, .top)
        XCTAssertEqual(textObject.style.fontFamily, "Courier New")
        XCTAssertEqual(textObject.style.pixelSize, 8)
        XCTAssertEqual(textObject.style.wrap, true)
        XCTAssertEqual(textObject.style.color, Color(r: 32, g: 255, b: 255, a: 255))
        XCTAssertEqual(textObject.style.bold, false)
        XCTAssertEqual(textObject.style.italic, false)
        XCTAssertEqual(textObject.style.underline, false)
        XCTAssertEqual(textObject.style.strikeout, false)
}

    func testElipseObject(){
        let level : Level
        do {
            level = try loadTestLevel()
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = level.getObjectLayers().first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer["Elipse"].first else {
            XCTFail("Could not get object")
            return
        }
        
        guard let elipseObject = object as? EllipseObject else {
            XCTFail("Object is not an ElipseObject")
            return
        }
        
        XCTAssertEqual(elipseObject.rotation, 45)
    }

    func testRectangleObject(){
        let level : Level
        do {
            level = try loadTestLevel()
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = level.getObjectLayers().first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer["Rectangle"].first else {
            XCTFail("Could not get object")
            return
        }
        
        guard let rectangleObject = object as? RectangleObject else {
            XCTFail("Object is not a RectangleObject")
            return
        }
        
        XCTAssertEqual(rectangleObject.id, 4)
        XCTAssertEqual(rectangleObject.x, 128.027)
        XCTAssertEqual(rectangleObject.y, 19.5807)
        XCTAssertEqual(rectangleObject.width, 15.8151)
        XCTAssertEqual(rectangleObject.height, 12.3007)
        XCTAssertEqual(rectangleObject.rotation, 0)
    }

    func testImageObject(){
        let level : Level
        do {
            level = try loadTestLevel()
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let objectLayer = level.getObjectLayers().first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer["Tile"].first else {
            XCTFail("Could not get object")
            return
        }
        
        guard let tileObject = object as? TileObject else {
            XCTFail("Object is not a TileObject")
            return
        }
        
        guard let tile = level.tiles[tileObject.gid] else {
            XCTFail("Tile is not in level tile dictionary")
            return
        }
        
        XCTAssertEqual(tile.tileSet?.name ?? "Tile set not found", "SingleImageAutoTransparency")
    }

    func testImageLayer(){
        let level : Level
        do {
            level = try loadTestLevel()
        } catch {
            XCTFail("\(error)")
            return
        }
        
        guard let imageLayer = (level.getLayers(ofType: .image, named: "Image Layer", matching: [String : PropertyValue](), recursively: false) as? [ImageLayer])?.first else {
            XCTFail("No image layer")
            return
        }
        
        XCTAssertEqual(imageLayer.x, 72)
        XCTAssertEqual(imageLayer.y, 48)
        XCTAssertTrue(imageLayer.url.standardized.path.hasSuffix("Resources/Images/Individual/F.png"), "URL is incorrect \(imageLayer.url)")
    }
    
    func testOneOfEverything(){
        let level : Level
        do {
            level = try loadTestLevel(url: Bundle.module.url(forResource: "One of Everything", withExtension: "tmx", subdirectory: "Maps"))
        } catch {
            XCTFail("\(error)")
            return
        }
        
        XCTAssertEqual(level.getObjectLayers()[0].x, 16)
        XCTAssertEqual(level.getObjectLayers()[0].y, 16)
        
        XCTAssertEqual(level.getGroups()[0].x, 144)
        XCTAssertEqual(level.getGroups()[0].y, 80)
    }

    func testMultipleProperties(){
        do {
            let tileSet = try TileSet(from: Bundle.module.url(forResource: "Animation", withExtension: "tsx", subdirectory: "Tilesets")!)


            //Confirm loading multiline properties works OK
            XCTAssertEqual(tileSet.filteringMode,"nearest")
            XCTAssertNotNil(tileSet.properties["User Property"])
        } catch {
            XCTFail("\(error)")
        }
    }

    
    func testTileSetCollisionObjects(){
        do {
            let tileSet = try TileSet(from: Bundle.module.url(forResource: "Animation", withExtension: "tsx", subdirectory: "Tilesets")!)
            
            XCTAssertEqual((tileSet.tiles[0]?.objects?.objects.count) ?? 0, 2)
            XCTAssertEqual((tileSet.tiles[0]?.objects?.objects[0].x) ?? 0, 7.92176)
            XCTAssertEqual((tileSet.tiles[0]?.objects?.objects[1].y) ?? 0, 3.00272)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testTileSetAnimationFrames(){
        do {
            let tileSet = try TileSet(from: Bundle.module.url(forResource: "Animation", withExtension: "tsx", subdirectory: "Tilesets")!)
            
            guard let tile = tileSet.tiles[1] else {
                XCTFail("No tile with id 1")
                return
            }
            
            XCTAssertEqual(tile.animation.count, 4)
            XCTAssert(tile.animation[0].tile.identifier.stringSource!.hasSuffix("0"))
            XCTAssertEqual(tile.animation[0].duration, 1)
            XCTAssert(tile.animation[1].tile.identifier.stringSource!.hasSuffix("1"))
            XCTAssertEqual(tile.animation[1].duration, 1)
            XCTAssert(tile.animation[2].tile.identifier.stringSource!.hasSuffix("2"))
            XCTAssertEqual(tile.animation[2].duration, 1)
            XCTAssert(tile.animation[3].tile.identifier.stringSource!.hasSuffix("3"))
            XCTAssertEqual(tile.animation[3].duration, 1)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    static var allTests = [
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
