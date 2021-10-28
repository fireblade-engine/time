//
//  TimerTests.swift
//
//
//  Created by Christian Treffs on 16.11.19.
//

import FirebladeTime
import class Foundation.Timer
import func XCTest.XCTAssertEqual
import func XCTest.XCTAssertFalse
import func XCTest.XCTAssertTrue
import class XCTest.XCTestCase

final class TimerTests: XCTestCase {
    typealias FTimer = Foundation.Timer
    typealias ITimer = FirebladeTime.Timer

    func testTimerStop() {
        let exp = expectation(description: "\(#function)")
        let timer = ITimer { nanos in
            XCTAssertEqual(Double(nanos), 1e9, accuracy: 6e6)
            exp.fulfill()
        }
        XCTAssertFalse(timer.isStopped)
        _ = FTimer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            timer.stop()
            XCTAssertTrue(timer.isStopped)
        }

        waitForExpectations(timeout: 2.0)
    }

    func testTimerStopByDeinit() {
        let exp = expectation(description: "\(#function)")
        var timer: ITimer? = ITimer { nanos in
            XCTAssertEqual(Double(nanos), 1e9, accuracy: 3e8)
            exp.fulfill()
        }
        XCTAssertFalse(timer!.isStopped)
        _ = FTimer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            timer = nil
        }

        waitForExpectations(timeout: 2.0)
    }
}
