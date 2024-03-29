//
// POSIXTimeOfDay.swift
// Fireblade Time
//
// Copyright © 2018-2021 Fireblade Team. All rights reserved.
// Licensed under MIT License. See LICENSE file for details.

#if FRB_USE_POSIX_TOD
    #if canImport(Darwin)
        import Darwin.POSIX
    #elseif canImport(Glibc)
        import Glibc
    #else
        #error("unavailable on this platform")
    #endif

    /// Portability     : POSIX 1
    /// granularity     : 1000 ns
    /// call            : 120 ns
    /// gettimeofday (µs) => 42 cycles
    /// https://pubs.opengroup.org/onlinepubs/9699919799/functions/gettimeofday.html
    public struct POSIXTimeOfDay: TimeProviding {
        @usableFromInline var timeVal: timeval

        @inlinable
        public init() {
            timeVal = timeval(tv_sec: 0, tv_usec: 0)
        }

        /// granularity: 1000 ns ~ 1µs
        @inlinable
        public mutating func now() -> Nanoseconds {
            let result = gettimeofday(&timeVal, nil)
            precondition(result == 0, "failed to call 'gettimeofday' error: \(errno)")
            return Nanoseconds(timeVal.tv_sec) * Nanoseconds(1e9) + Nanoseconds(timeVal.tv_usec) * Nanoseconds(1e3)
        }

        @inlinable
        public func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
            end - start
        }
    }
#endif
