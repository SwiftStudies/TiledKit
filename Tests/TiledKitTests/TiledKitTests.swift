import XCTest
@testable import TiledKit

final class TiledKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Level().tileWidth, Level().tileHeight)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
