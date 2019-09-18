import XCTest

import FirebladeTimePerformanceTests
import FirebladeTimeTests

var tests = [XCTestCaseEntry]()
tests += FirebladeTimePerformanceTests.__allTests()
tests += FirebladeTimeTests.__allTests()

XCTMain(tests)
