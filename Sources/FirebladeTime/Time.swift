//
//  Time.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 17.02.19.
//
public typealias Nanoseconds = UInt64
public protocol Time {
    static var now: Nanoseconds { get }

    static func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds
}

public extension Nanoseconds {
    @inlinable var microseconds: Double {
        return Double(self) * 1e-3
    }

    @inlinable var milliseconds: Double {
        return Double(self) * 1e-6
    }

    @inlinable var seconds: Double {
        return Double(self) * 1e-9
    }
}
