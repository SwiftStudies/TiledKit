import XCTest

@testable import TKXMLCoding
import XMLCoder

final class TMXCodingTests: XCTestCase {
    
    fileprivate enum TestError : Error {
        case message(String)
    }
    
    func testTMXLevel(){
        let level : TMXLevel
        do {
            guard let url = Bundle.module.url(forResource: "One of Everything", withExtension: "tmx", subdirectory: "Maps") else {
                XCTFail("Could not find map")
                return
            }
            let data = try Data(contentsOf: url)
            level = try TMXLevel.decoder.decode(TMXLevel.self, from: data)
        } catch {
            XCTFail("Error loading \(error)")
            return
        }
        
        XCTAssertEqual(level.version, "1.4")
        XCTAssertEqual(level.tiledVersion, "1.4.2")
        XCTAssertEqual(level.orientation, "orthogonal")
        XCTAssertEqual(level.renderOrder, "right-down")
        XCTAssertEqual(level.width, 10)
        XCTAssertEqual(level.height, 10)
        XCTAssertEqual(level.tileWidth, 16)
        XCTAssertEqual(level.tileHeight, 16)
        XCTAssertEqual(level.infinite, false)
        XCTAssertEqual(level.layers.count, 4)
        XCTAssertEqual(level.tileSetReferences.count, 2)
        XCTAssertEqual(level.tileSetReferences[0].firstGid, 1)
        XCTAssertEqual(level.tileSetReferences[0].path, "../Tilesets/SeparateSingleImage.tsx")
        XCTAssertEqual(level.tileSetReferences[1].firstGid, 2)
        XCTAssertEqual(level.tileSetReferences[1].path, "../Tilesets/Animation.tsx")
        XCTAssertEqual(level.layers.count, 4)
        XCTAssertTrue(level.layers[0] is TMXTileLayer)
        XCTAssertTrue(level.layers[1] is XMLObjectLayer)
        XCTAssertTrue(level.layers[2] is TMXImageLayer)
        XCTAssertTrue(level.layers[3] is TMXGroupLayer)
        XCTAssertEqual(level.properties.properties.count, 7)
    }
    
    static var allTests = [
        ("testTMXLevel",testTMXLevel),
        ]
 
}
