import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(extract_amazon_ordersTests.allTests),
    ]
}
#endif