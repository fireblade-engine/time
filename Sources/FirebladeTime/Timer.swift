//
//  Timer.swift
//
//
//  Created by Christian Treffs on 16.11.19.
//

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
