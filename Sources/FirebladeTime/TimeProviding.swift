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

public extension Nanoseconds {
    @inlinable var microseconds: Double {
        Double(self) * 1e-3
    }

    @inlinable var milliseconds: Double {
        Double(self) * 1e-6
    }

    @inlinable var seconds: Double {
        Double(self) * 1e-9
    }
}
