//
//  MachTimePerformanceTests.swift
//
//
//  Created by Christian Treffs on 18.09.19.
//

import FirebladeTime
import class XCTest.XCTestCase

private let kMaxCalls = 1_000_000

final class MachTimePerformanceTests: XCTestCase {
    func testPerformanceMachTime() {
        #if USE_MACH_TIME
            let time = MachTime()
            measure {
                for _ in 0 ..< kMaxCalls {
                    _ = time.now()
                }
            }
        #endif
    }
}
