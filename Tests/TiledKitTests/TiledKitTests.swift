import XCTest
@testable import TiledKit

final class TiledKitTests: XCTestCase {
    func testResources() {
        XCTAssertNotNil(Bundle.module.path(forResource: "Test Map 1", ofType: "tmx", inDirectory: "Maps"))
    }

    static var allTests = [
        ("testResources", testResources)
    ]
}
