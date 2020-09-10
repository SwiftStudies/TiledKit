import XCTest

import TiledKit
import SpriteKit
@testable import SKTiledKit

final class SKTiledKitTests : XCTestCase {
    func testResources() {
        XCTAssertNotNil(Bundle.module.path(forResource: "Test Map 1", ofType: "tmx", inDirectory: "Maps"))
    }
    
    func testSceneCreation(){
        SKTiledKit.enable()

        guard let url = Bundle.module.url(forResource: "Test Map 1", withExtension: "tmx", subdirectory: "Maps") else {
            XCTFail("Failed to load the map")
            return
        }
        
        do {
            let scene : SKScene = try Tiled.default.load(levelFrom: url)
        } catch {
            XCTFail("Could not create scene \(error)")
        }
    }
    
    static var allTests = [
        ("testResources", testResources),
    ]
}
