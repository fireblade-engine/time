//
//  PosixClockPerformanceTests.swift
//
//
//  Created by Christian Treffs on 18.09.19.
//

import FirebladeTime

import class XCTest.XCTestCase

private let kMaxCalls = 1_000_000

final class PosixClockPerformanceTests: XCTestCase {
    func testPerformancePOSIXClock() {
        #if USE_POSIX_CLOCK
        var time = POSIXClock()
        measure {
            for _ in 0..<kMaxCalls {
                _ = time.now()
            }
        }
        #endif
    }
}
