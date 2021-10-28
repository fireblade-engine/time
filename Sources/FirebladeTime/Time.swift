//
//  Time.swift
//
//
//  Created by Christian Treffs on 15.09.19.
//

public enum Time {
    @usableFromInline static var time: TimeProviding = makeTime()

    @inlinable
    static func makeTime() -> TimeProviding {
        let time: TimeProviding
        #if FRB_USE_MACH_TIME
            time = MachTime()
        #elseif FRB_USE_POSIX_CLOCK
            time = POSIXClock()
        #elseif USE_POXIS_TOD
            time = POSIXTimeOfDay()
        #else
            fatalError("No time implementation available")
        #endif
        return time
    }

    @inlinable public static var now: Nanoseconds {
        time.now()
    }

    @inlinable
    public static func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
        time.elapsed(start: start, end: end)
    }
}
