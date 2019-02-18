//
//  PosixTime.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 16.02.19.
//

import Darwin.POSIX.time
// https://www.systutorials.com/5086/measuring-time-accurately-in-programs/
// https://stackoverflow.com/questions/5167269/clock-gettime-alternative-in-mac-os-x
// https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html
public enum POSIXClock: Time {
    /*
     https://stackoverflow.com/a/13096917
     https://www.systutorials.com/5086/measuring-time-accurately-in-programs/
     clock_gettime (ns) => 9 cycles (CLOCK_MONOTONIC_COARSE)
     clock_gettime (ns) => 9 cycles (CLOCK_REALTIME_COARSE)
     clock_gettime (ns) => 42 cycles (CLOCK_MONOTONIC)
     clock_gettime (ns) => 42 cycles (CLOCK_REALTIME)
     clock_gettime (ns) => 173 cycles (CLOCK_MONOTONIC_RAW)
     clock_gettime (ns) => 179 cycles (CLOCK_BOOTTIME)
     clock_gettime (ns) => 349 cycles (CLOCK_THREAD_CPUTIME_ID)
     clock_gettime (ns) => 370 cycles (CLOCK_PROCESS_CPUTIME_ID)
     */
    public private(set) static var timeSpec = timespec(tv_sec: 0, tv_nsec: 0)

    /// granularity: 1000 ns ~ 1µs
    public var resolution: UInt64 {
        var timeSpec = timespec(tv_sec: 0, tv_nsec: 0)
        let result = clock_getres(CLOCK_MONOTONIC, &timeSpec)
        assert(result == 0, "failed to call 'clock_getres' error: \(errno)")
        return UInt64(timeSpec.tv_sec) * UInt64(1e9) + UInt64(timeSpec.tv_nsec)
    }

    /// granularity: 1000 ns ~ 1µs
    @inlinable public static var now: UInt64 {
        /// The Monotonic Clock option is supported represents the monotonic clock for the system.
        /// For this clock, the value returned by clock_gettime() represents the amount of time (in seconds and nanoseconds)
        /// since an unspecified point in the past (for example, system start-up time, or the Epoch).
        /// This point does not change after system start-up time.
        /// The value of the CLOCK_MONOTONIC clock cannot be set via clock_settime().
        let result = clock_gettime(CLOCK_MONOTONIC, &timeSpec)
        assert(result == 0, "failed to call 'clock_gettime' error: \(errno)")
        return UInt64(timeSpec.tv_sec) * UInt64(1e9) + UInt64(timeSpec.tv_nsec)
    }

    @inlinable
    public static func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
        return end - start
    }
}

import Darwin.POSIX.sys.time

// https://pubs.opengroup.org/onlinepubs/9699919799/functions/gettimeofday.html

public struct POSIXTimeOfDay: Time {
    /// Portability     : POSIX 1
    /// granularity     : 1000 ns
    /// call            : 120 ns
    /// gettimeofday (µs) => 42 cycles

    public private(set) static var timeVal = timeval(tv_sec: 0, tv_usec: 0)

    /// granularity: 1000 ns ~ 1µs
    @inlinable public static var now: Nanoseconds {
        let result = gettimeofday(&POSIXTimeOfDay.timeVal, nil)
        assert(result == 0, "failed to call 'gettimeofday' error: \(errno)")
        return UInt64(timeVal.tv_sec) * UInt64(1e9) + UInt64(timeVal.tv_usec) * UInt64(1e3)
    }

    @inlinable
    public static func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
        return end - start
    }
}
