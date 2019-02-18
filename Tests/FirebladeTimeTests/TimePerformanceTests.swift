//
//  TimePerformanceTests.swift
//  FirebladeTimeTests
//
//  Created by Christian Treffs on 18.02.19.
//

import XCTest
import FirebladeTime

class TimePerformanceTests: XCTestCase {
    let kMaxCalls = 1_000_000   
    
    func testPerformanceMachTime() {
        measure {
            for _ in 0..<kMaxCalls {
                _ = MachTime.now
            }
        }
        
    }
    func testPerformanceRawMachTime() {
        measure {
            for _ in 0..<kMaxCalls {
                _ = mach_absolute_time()
            }
        }
    }
    
    func testPerformancePOSIXClock() {
        measure {
            for _ in 0..<kMaxCalls {
                _ = POSIXClock.now
            }
        }
        
    }
    
    func testPerformancePOSIXClockRaw() {
        measure {
            var tSpec = timespec.init(tv_sec: 0, tv_nsec: 0)
            for _ in 0..<kMaxCalls {
                clock_gettime(CLOCK_MONOTONIC, &tSpec)
                _ = tSpec.tv_sec + (tSpec.tv_nsec * Int(1e9))
            }
        }
    }
    
    func testPerformancePOSIXTimeOfDay() {
        measure {
            for _ in 0..<kMaxCalls {
                _ = POSIXTimeOfDay.now
            }
        }
        
    }
    
    func testPerformancePOSICGetTimeOfDayRaw() {
        measure {
            var tVal = timeval.init(tv_sec: 0, tv_usec: 0)
            for _ in 0..<kMaxCalls {
                gettimeofday(&tVal, nil)
                _ = tVal.tv_sec + (Int(tVal.tv_usec) * Int(1e6))
            }
        }
    }
}
