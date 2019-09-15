@testable import FirebladeTime
import XCTest

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
        XCTAssertEqual(Double(T.elapsed(start: nS, end: nE)), 1e9, accuracy: 6e6)
    }

    func testMicroseconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(T.elapsed(start: nS, end: nE).microseconds, 1e6, accuracy: 6e3)
    }

    func testMilliseconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(T.elapsed(start: nS, end: nE).milliseconds, 1e3, accuracy: 6e1)
    }

    func testSeconds<T>(_ time: T.Type) where T: Time {
        ensureIdleMainThread()
        let nS = T.now
        sleep(1)
        let nE = T.now
        XCTAssertEqual(T.elapsed(start: nS, end: nE).seconds, 1, accuracy: 6e-2)
    }

    func testPOSIXClockResolution() {
        XCTAssertEqual(POSIXClock.resolution, 1000)
    }
}
