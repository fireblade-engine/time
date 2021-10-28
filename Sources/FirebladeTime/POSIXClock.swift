//
// POSIXClock.swift
// Fireblade Time
//
// Copyright © 2018-2021 Fireblade Team. All rights reserved.
// Licensed under MIT License. See LICENSE file for details.

#if FRB_USE_POSIX_CLOCK

    #if canImport(Darwin)
        import Darwin.POSIX
    #elseif canImport(Glibc)
        import Glibc
    #else
        #error("unavailable on this platform")
    #endif

    public struct POSIXClock: TimeProviding {
        #if canImport(Darwin)
            public typealias CTimeSpec = mach_timespec_t

            public let machTaskSelf: () -> mach_port_t = { mach_task_self_ }
        #elseif canImport(Glibc)
            public typealias CTimeSpec = timespec
        #endif

        // https://www.systutorials.com/5086/measuring-time-accurately-in-programs/
        // https://stackoverflow.com/questions/5167269/clock-gettime-alternative-in-mac-os-x
        // https://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html
        // https://stackoverflow.com/a/13096917
        // https://www.systutorials.com/5086/measuring-time-accurately-in-programs/
        // http://answers.gazebosim.org/answers/1651/revisions/
        // clock_gettime (ns) => 9 cycles (CLOCK_MONOTONIC_COARSE)
        // clock_gettime (ns) => 9 cycles (CLOCK_REALTIME_COARSE)
        // clock_gettime (ns) => 42 cycles (CLOCK_MONOTONIC)
        // clock_gettime (ns) => 42 cycles (CLOCK_REALTIME)
        // clock_gettime (ns) => 173 cycles (CLOCK_MONOTONIC_RAW)
        // clock_gettime (ns) => 179 cycles (CLOCK_BOOTTIME)
        // clock_gettime (ns) => 349 cycles (CLOCK_THREAD_CPUTIME_ID)
        // clock_gettime (ns) => 370 cycles (CLOCK_PROCESS_CPUTIME_ID)

        @usableFromInline var timeSpec: CTimeSpec

        @inlinable
        public init() {
            timeSpec = CTimeSpec(tv_sec: 0, tv_nsec: 0)
            // get resolution
            #if canImport(Darwin)
                timeSpec.tv_sec = UInt32(1 / sysconf(_SC_CLK_TCK))
            #else
                _ = clock_getres(CLOCK_MONOTONIC, &timeSpec)
            #endif
        }

        /// granularity: 1000 ns ~ 1µs
        @inlinable
        public mutating func now() -> Nanoseconds {
            /// The Monotonic Clock option is supported represents the monotonic clock for the system.
            /// For this clock, the value returned by clock_gettime() represents the amount of time (in seconds and nanoseconds)
            /// since an unspecified point in the past (for example, system start-up time, or the Epoch).
            /// This point does not change after system start-up time.
            /// The value of the CLOCK_MONOTONIC clock cannot be set via clock_settime().
            #if canImport(Darwin)
                var clockName: clock_serv_t = 0
                _ = host_get_clock_service(mach_host_self(), SYSTEM_CLOCK, &clockName)
                _ = clock_get_time(clockName, &timeSpec)
                _ = mach_port_deallocate(machTaskSelf(), clockName)
            #else
                _ = clock_gettime(CLOCK_MONOTONIC, &timeSpec)
            #endif
            return Nanoseconds(timeSpec.tv_sec) * Nanoseconds(1e9) + Nanoseconds(timeSpec.tv_nsec)
        }

        @inlinable
        public func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
            end - start
        }
    }
#endif
