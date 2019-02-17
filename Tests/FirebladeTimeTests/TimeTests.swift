import XCTest
@testable import FirebladeTime

final class TimeTests: XCTestCase {
    
    
    func testMachTime() {
        testNanoseconds(MachTime.self)
        testMicroseconds(MachTime.self)
        testMilliseconds(MachTime.self)
        testSeconds(MachTime.self)
    }
    
    func testPOSIXClock() {
        testNanoseconds(POSIXClock.self)
        testMicroseconds(POSIXClock.self)
        testMilliseconds(POSIXClock.self)
        testSeconds(POSIXClock.self)
    }
    
    func testPOSIXTimeOfDay() {
        testNanoseconds(POSIXTimeOfDay.self)
        testMicroseconds(POSIXTimeOfDay.self)
        testMilliseconds(POSIXTimeOfDay.self)
        testSeconds(POSIXTimeOfDay.self)
    }
    
    func testNanoseconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(Double(nE.elapsed(since: nS).nanoseconds), 1e9, accuracy: 5e6)
    }
    
    func testMicroseconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(nE.elapsed(since: nS).microseconds, 1e6, accuracy: 5e3)
    }
    
    func testMilliseconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(nE.elapsed(since: nS).milliseconds, 1e3, accuracy: 5e1)
    }
    
    func testSeconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(nE.elapsed(since: nS).seconds, 1, accuracy: 5e-2)
    }
    
    
}
