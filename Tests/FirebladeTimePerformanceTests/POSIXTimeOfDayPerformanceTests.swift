//
//  POSIXTimeOfDayPerformanceTests.swift
//
//
//  Created by Christian Treffs on 18.09.19.
//

#if USE_POSIX_TOD

import FirebladeTime

import class XCTest.XCTestCase

private let kMaxCalls = 1_000_000

final class POSIXTimeOfDayPerformanceTests: XCTestCase {
    func testPerformancePOSIXTimeOfDay() {
        var time = POSIXTimeOfDay()
        measure {
            for _ in 0..<kMaxCalls {
                _ = time.now()
            }
        }
    }
}
#endif
