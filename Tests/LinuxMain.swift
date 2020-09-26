import XCTest

import TiledKitTests

var tests = [XCTestCaseEntry]()
tests += TiledKitTests.allTests()
tests += TMXCodingTests.allTests()
XCTMain(tests)
