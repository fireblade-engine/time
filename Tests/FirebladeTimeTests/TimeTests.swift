import FirebladeTime

import class XCTest.XCTestCase
import func XCTest.XCTAssertEqual
import class Foundation.Timer

final class TimeTests: XCTestCase {
    typealias FTimer = Foundation.Timer

    func testNanoseconds() {
        let exp = expectation(description: "\(#function)")
        let nS = Time.now
        _ = FTimer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            let nE = Time.now
            XCTAssertEqual(Double(Time.elapsed(start: nS, end: nE)), 1e9, accuracy: 6e6)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }

    func testMicroseconds() {
        let exp = expectation(description: "\(#function)")
        let nS = Time.now
        _ = FTimer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            let nE = Time.now
            XCTAssertEqual(Time.elapsed(start: nS, end: nE).microseconds, 1e6, accuracy: 6e3)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }

    func testMilliseconds() {
        let exp = expectation(description: "\(#function)")
        let nS = Time.now
        _ = FTimer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            let nE = Time.now
            XCTAssertEqual(Time.elapsed(start: nS, end: nE).milliseconds, 1e3, accuracy: 6e1)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }

    func testSeconds() {
        let exp = expectation(description: "\(#function)")
        let nS = Time.now
        _ = FTimer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            let nE = Time.now
            XCTAssertEqual(Time.elapsed(start: nS, end: nE).seconds, 1, accuracy: 6e-2)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
}
