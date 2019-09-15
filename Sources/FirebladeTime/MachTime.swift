//
//  MachTime.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 16.02.19.
//

import Darwin.Mach

public enum MachTime: Time {
    // https://web.archive.org/web/20100517095152/http://www.wand.net.nz/~smr26/wordpress/2009/01/19/monotonic-time-in-mac-os-x/comment-page-1/
    // https://developer.apple.com/library/archive/qa/qa1398/_index.html
    // https://web.archive.org/web/20150921221407/http://lists.apple.com/archives/PerfOptimization-dev/2006/Jul/msg00024.html
    // https://stackoverflow.com/a/15125418

    /// Portability     : Mac specific. Always available
    /// granularity     : 1 ns.
    /// call time       : 90 ns unoptimised.
    public private(set) static var sTimebaseInfo: mach_timebase_info_data_t = {
        var info: mach_timebase_info_data_t = mach_timebase_info()
        let kernReturn: kern_return_t = mach_timebase_info(&info)
        assert(KERN_SUCCESS == kernReturn)
        return info
    }()

    /// granularity: 1 ns
    @inlinable public static var now: Nanoseconds {
        return mach_absolute_time()
    }

    @inlinable
    public static func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
        let elapsedRaw: UInt64 = end - start
        let elapsed: UInt64 = elapsedRaw * numericCast(sTimebaseInfo.numer) / numericCast(sTimebaseInfo.denom)
        return elapsed
    }
}
