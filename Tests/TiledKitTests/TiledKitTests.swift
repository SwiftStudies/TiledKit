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
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "SingleImageAutoTransparency", in: "Tilesets", of: .tsx)!)
            
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
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "SingleImageMarginsAndSpacing", in: "Tilesets", of: .tsx)!)
            
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
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "SeparateSingleImage", in: "Tilesets", of: .tsx)!)

            
            XCTAssertEqual(tileSet.tileSize.width, 16)
            XCTAssertEqual(tileSet.tileSize.height, 16)
            XCTAssertEqual(tileSet.count, 1)
        } catch {
            XCTFail("Error thrown \(error)")
        }
    }
    
    func testMultiImageTileSet(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "SeparateMultipleImages", in: "Tilesets", of: .tsx)!)

            
            
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
        XCTAssertEqual(map.tileLayers[0].grid[0,0], TileGID(tileId: 0, flip: []))
        XCTAssertEqual(map.tileLayers[1].grid[0,0], TileGID(tileId: 5, flip: []))
        XCTAssertEqual(map.tileLayers[0].grid.size,  map.mapSize)
        XCTAssertEqual(nestedImageLayer.image.size, PixelSize(width: 16, height: 16))
        XCTAssertTrue(nestedImageLayer.image.url.path.hasSuffix("F.png"))
        XCTAssertEqual(map.objectLayers[0].objects.count, 7)
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
        
        guard let objectLayer = map.objectLayers.first else {
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
        
        guard let objectLayer = map.objectLayers.first else {
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
        
        guard let objectLayer = map.objectLayers.first else {
            XCTFail("No object layer")
            return
        }
        
        guard let object = objectLayer.objects[name: "Elipse"].first else {
            XCTFail("Could not get object")
            return
        }
        
        switch object.kind {
        case .elipse(let size, let rotation):
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
        
        guard let objectLayer = map.objectLayers.first else {
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
        
        guard let objectLayer = map.objectLayers.first else {
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
            XCTFail("Test items below")
//            guard let tile = level.tiles[tileObject.gid] else {
//                XCTFail("Tile is not in level tile dictionary")
//                return
//            }
//
//            XCTAssertEqual(tile.tileSet?.name ?? "Tile set not found", "SingleImageAutoTransparency")
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
        
        guard let imageLayer = map.imageLayers.first else {
            XCTFail("No image layer")
            return
        }
        
        
        XCTAssertEqual(imageLayer.layer.position.x, 72)
        XCTAssertEqual(imageLayer.layer.position.y, 48)
        XCTAssertTrue(imageLayer.image.url.standardized.path.hasSuffix("Resources/Images/Individual/F.png"), "URL is incorrect \(imageLayer.image.url)")
    }
    
    func testOneOfEverything(){
        let map : Map
        do {
            map = try loadTestMap(from: moduleBundleProject, name: "One of Everything" )
        } catch {
            XCTFail("\(error)")
            return
        }

        XCTAssertEqual(map.objectLayers[0].layer.position.x, 16)
        XCTAssertEqual(map.objectLayers[0].layer.position.y, 16)
        
        XCTAssertEqual(map.groupLayers[0].layer.position.x, 144)
        XCTAssertEqual(map.groupLayers[0].layer.position.y, 80)
    }

    func testMultipleProperties(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "Animation", in: "Tilesets", of: .tsx)!)


            //Confirm loading multiline properties works OK
            XCTAssertEqual(tileSet.properties["fileteringMode"],"nearest")
            XCTAssertNotNil(tileSet.properties["User Property"])
        } catch {
            XCTFail("\(error)")
        }
    }

    
    func testTileSetCollisionObjects(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "Animation", in: "Tilesets", of: .tsx)!)

            
            XCTAssertEqual(tileSet[0]?.collisionBodies?.count, 2)
            XCTAssertEqual(tileSet[0]?.collisionBodies?[id: 0]?.position.x, 7.92176)
            XCTAssertEqual(tileSet[0]?.collisionBodies?[id: 1]?.position.y, 3.00272)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testTileSetAnimationFrames(){
        do {
            let tileSet = try moduleBundleProject.retrieve(asType: TKTileSet.self, from: moduleBundleProject.url(for: "Animation", in: "Tilesets", of: .tsx)!)

            
            guard let tile = tileSet[0] else {
                XCTFail("No tile with id 1")
                return
            }
            
            XCTAssertEqual(tile.frames?.count, 4)
            XCTAssert(tile.frames?[0].tile.uuid.hasSuffix("0") ?? false)
            XCTAssertEqual(tile.frames?[0].duration, 1)
            XCTAssert(tile.frames?[0].tile.uuid.hasSuffix("1") ?? false)
            XCTAssertEqual(tile.frames?[1].duration, 1)
            XCTAssert(tile.frames?[0].tile.uuid.hasSuffix("2") ?? false)
            XCTAssertEqual(tile.frames?[2].duration, 1)
            XCTAssert(tile.frames?[0].tile.uuid.hasSuffix("3") ?? false)
            XCTAssertEqual(tile.frames?[3].duration, 1)
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
