import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(structYokaiTests.allTests),
    ]
}
#endif