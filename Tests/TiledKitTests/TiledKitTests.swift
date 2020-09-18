import XCTest
@testable import TiledKit

final class TiledKitTests: XCTestCase {
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
    
    func testLevel(){
        guard let url = Bundle.module.url(forResource: "Test Map 1", withExtension: "tmx", subdirectory: "Maps") else {
            XCTFail("Could not find Map in bundle")
            return
        }

        let level = try! Level(from:url)
        
        XCTAssertEqual(level.width, 10)
        XCTAssertEqual(level.height, 10)
        XCTAssertEqual(level.tileWidth, 16)
        XCTAssertEqual(level.tileHeight, 16)
        XCTAssertEqual(level.layers.count, 5)
        XCTAssertEqual(level.properties.count, 7)

        XCTAssertEqual(level.getTileLayers().count, 2)
        XCTAssertEqual(level.getObjectLayers().count, 1)
        XCTAssertEqual(level.getGroups().count, 1)

        guard let nestedImageLayer = level.getLayers(ofType: .image, named: "Grouped Image Layer", matching: [:], recursively: true)[0] as? ImageLayer else {
            XCTFail("Could not get nested image layer")
            return
        }
        
        XCTAssertEqual((nestedImageLayer.parent as? GroupLayer)?.name ?? "FAILED", "Group")
        
        XCTAssertEqual(level.getObjectLayers()[0].objects.count, 7)
        XCTAssertEqual(level.getTileLayers()[0].tiles.count, 100)
    }
    
    static var allTests = [
        ("testLevel",testLevel),
        ("testMultiImageTileSetWithSingleTile",testMultiImageTileSetWithSingleTile),
        ("testMultiImageTileSet",testMultiImageTileSet),
        ("testSingleImageTileSetWithOptionals", testSingleImageTileSetWithOptionals),
        ("testResources", testResources),
        ("testSingleImageTileSet", testSingleImageTileSet)
    ]
}
