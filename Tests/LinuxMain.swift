import XCTest

import VauxTests

var tests = [XCTestCaseEntry]()
tests += VauxTests.allTests()
#tests += VauxTableTests.allTests()
XCTMain(tests)

