import XCTest

@testable import TiledKit

final class TMXCodingTests: XCTestCase {
    
    fileprivate enum TestError : Error {
        case message(String)
    }
    
    func testResources(){

    }
    
    static var allTests = [
        ("testResources",testResources),
        ]
 
}
