import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(VauxTests.allTests),
    testCase(VauxTableTests.allTests)
  ]
}
#endif

