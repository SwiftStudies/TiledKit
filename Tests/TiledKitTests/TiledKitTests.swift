import XCTest
@testable import TiledKit

final class TiledKitTests: XCTestCase {
    func testResources() {
        XCTAssertNotNil(Bundle.module.path(forResource: "Test Map 1", ofType: "tmx", inDirectory: "Maps"))
    }
    
    func testSingleImageTileSet(){
        guard let url = Bundle.module.url(forResource: "SingleImageAutoTransparency", withExtension: "tsx", subdirectory: "Tilesets") else {
            XCTFail("Could not find TileSet in bundle")
            return
        }
        
        let tileSet = TileSet(from: url)
        XCTAssertEqual(tileSet.tileWidth, 16)
        XCTAssertEqual(tileSet.tileHeight, 16)
        XCTAssertEqual(tileSet.tiles.count, 4)
    }
    
    func testSingleImageTileSetWithOptionals(){
        XCTFail("Not implemented")
    }

    func testMultiImageTileSetWithSingleTile(){
        guard let url = Bundle.module.url(forResource: "SeparateSingleImage", withExtension: "tsx", subdirectory: "Tilesets") else {
            XCTFail("Could not find TileSet in bundle")
            return
        }
        
        let tileSet = TileSet(from: url)
        XCTAssertEqual(tileSet.tileWidth, 16)
        XCTAssertEqual(tileSet.tileHeight, 16)
        XCTAssertEqual(tileSet.tiles.count, 1)
    }
    
    func testMultiImageTileSet(){
        guard let url = Bundle.module.url(forResource: "SeparateMultipleImages", withExtension: "tsx", subdirectory: "Tilesets") else {
            XCTFail("Could not find TileSet in bundle")
            return
        }
        
        let tileSet = TileSet(from: url)
        XCTAssertEqual(tileSet.tileWidth, 16)
        XCTAssertEqual(tileSet.tileHeight, 16)
        XCTAssertEqual(tileSet.tiles.count, 2)
    }
    
    func testLevel(){
        guard let url = Bundle.module.url(forResource: "Test Map 1", withExtension: "tmx", subdirectory: "Maps") else {
            XCTFail("Could not find Map in bundle")
            return
        }

        let level = try! Level(from:url)
        
        print(level.height)
        
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
