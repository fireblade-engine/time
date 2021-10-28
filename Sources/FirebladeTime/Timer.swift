//
// Timer.swift
// Fireblade Time
//
// Copyright © 2018-2021 Fireblade Team. All rights reserved.
// Licensed under MIT License. See LICENSE file for details.

open class Timer {
    public var isStopped = false
    @usableFromInline let elapsed: (Nanoseconds) -> Void
    public let start: Nanoseconds

    public init(_ elapsed: @escaping (Nanoseconds) -> Void) {
        start = Time.now
        self.elapsed = elapsed
    }

    deinit {
        if !isStopped {
            stop()
        }
    }

    @inlinable
    public func stop() {
        elapsed(Time.elapsed(start: start, end: Time.now))
        isStopped = true
    }
}
