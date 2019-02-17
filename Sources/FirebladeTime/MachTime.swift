//
//  MachTime.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 16.02.19.
//

import Darwin.Mach
// https://web.archive.org/web/20100517095152/http://www.wand.net.nz/~smr26/wordpress/2009/01/19/monotonic-time-in-mac-os-x/comment-page-1/
// https://developer.apple.com/library/archive/qa/qa1398/_index.html
// https://web.archive.org/web/20150921221407/http://lists.apple.com/archives/PerfOptimization-dev/2006/Jul/msg00024.html
// https://stackoverflow.com/a/15125418
public struct MachTime: Time {
    /// Portability     : Mac specific. Always available
    /// granularity     : 1 ns.
    /// call time       : 90 ns unoptimised.
    private static var sTimebaseInfo: mach_timebase_info_data_t = {
        var info: mach_timebase_info_data_t = mach_timebase_info()
        let kernReturn: kern_return_t = mach_timebase_info(&info)
        precondition(KERN_SUCCESS == kernReturn)
        return info
    }()

    private let timeInNanos: UInt64

    public init(_ nanoseconds: UInt64) {
        timeInNanos = nanoseconds
    }

    /// granularity: 1 ns
    public static var now: MachTime {
        return MachTime(mach_absolute_time())
    }

    public var nanoseconds: UInt64 {
        return timeInNanos
    }

    public var microseconds: Double {
        return Double(timeInNanos) * 1e-3
    }

    public var milliseconds: Double {
        return Double(timeInNanos) * 1e-6
    }

    public var seconds: Double {
        return Double(timeInNanos) * 1e-9
    }

    public func elapsed(since start: MachTime) -> MachTime {
        let elapsed: UInt64 = timeInNanos - start.timeInNanos
        let result: UInt64 = elapsed * numericCast(MachTime.sTimebaseInfo.numer) / numericCast(MachTime.sTimebaseInfo.denom)
        return MachTime(result)
    }
}
