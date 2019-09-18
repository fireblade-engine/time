import FirebladeTime

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import func Darwin.POSIX.sleep
import class Foundation.Thread

final class TimeTests: XCTestCase {
    final func ensureIdleMainThread() {
        // https://stackoverflow.com/a/15125418
        precondition(Thread.current.isMainThread)
        sleep(2)
    }

    func testNanoseconds() {
        ensureIdleMainThread()
        let nS = Time.now
        sleep(1)
        let nE = Time.now
        XCTAssertEqual(Double(Time.elapsed(start: nS, end: nE)), 1e9, accuracy: 6e6)
    }

    func testMicroseconds() {
        ensureIdleMainThread()
        let nS = Time.now
        sleep(1)
        let nE = Time.now
        XCTAssertEqual(Time.elapsed(start: nS, end: nE).microseconds, 1e6, accuracy: 6e3)
    }

    func testMilliseconds() {
        ensureIdleMainThread()
        let nS = Time.now
        sleep(1)
        let nE = Time.now
        XCTAssertEqual(Time.elapsed(start: nS, end: nE).milliseconds, 1e3, accuracy: 6e1)
    }

    func testSeconds() {
        ensureIdleMainThread()
        let nS = Time.now
        sleep(1)
        let nE = Time.now
        XCTAssertEqual(Time.elapsed(start: nS, end: nE).seconds, 1, accuracy: 6e-2)
    }
}
