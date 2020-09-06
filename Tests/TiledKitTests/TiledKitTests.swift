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

    }

    static var allTests = [
        ("testResources", testResources),
        ("testSingleImageTileSet", testSingleImageTileSet)
    ]
}
