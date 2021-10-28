//
// TimeProviding.swift
// Fireblade Time
//
// Copyright © 2018-2021 Fireblade Team. All rights reserved.
// Licensed under MIT License. See LICENSE file for details.

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
