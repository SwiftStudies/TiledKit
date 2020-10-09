import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EngineTests.allTests),
        testCase(TiledKitTests.allTests),
        testCase(TMXCodingTests.allTests),
    ]
}
#endif
