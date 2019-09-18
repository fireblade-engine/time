#if !canImport(ObjectiveC)
import XCTest

extension MachTimePerformanceTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MachTimePerformanceTests = [
        ("testPerformanceMachTime", testPerformanceMachTime)
    ]
}

extension POSIXTimeOfDayPerformanceTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__POSIXTimeOfDayPerformanceTests = [
        ("testPerformancePOSIXTimeOfDay", testPerformancePOSIXTimeOfDay)
    ]
}

extension PosixClockPerformanceTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PosixClockPerformanceTests = [
        ("testPerformancePOSIXClock", testPerformancePOSIXClock)
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MachTimePerformanceTests.__allTests__MachTimePerformanceTests),
        testCase(POSIXTimeOfDayPerformanceTests.__allTests__POSIXTimeOfDayPerformanceTests),
        testCase(PosixClockPerformanceTests.__allTests__PosixClockPerformanceTests)
    ]
}
#endif
