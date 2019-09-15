//
//  Time.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 17.02.19.
//
public typealias Nanoseconds = UInt64
public protocol TimeProviding {
    mutating func now() -> Nanoseconds

    func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds
}

extension Nanoseconds {
    @inlinable public var microseconds: Double {
        return Double(self) * 1e-3
    }

    @inlinable public var milliseconds: Double {
        return Double(self) * 1e-6
    }

    @inlinable public var seconds: Double {
        return Double(self) * 1e-9
    }
}
