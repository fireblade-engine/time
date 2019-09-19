//
//  MachTime.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 16.02.19.
//

#if USE_MACH_TIME
import Darwin.Mach

/// Portability     : Mac specific. Always available
/// granularity     : 1 ns.
/// call time       : 90 ns unoptimised.
///
/// https://web.archive.org/web/20100517095152/http://www.wand.net.nz/~smr26/wordpress/2009/01/19/monotonic-time-in-mac-os-x/comment-page-1/
/// https://developer.apple.com/library/archive/qa/qa1398/_index.html
/// https://web.archive.org/web/20150921221407/http://lists.apple.com/archives/PerfOptimization-dev/2006/Jul/msg00024.html
/// https://stackoverflow.com/a/15125418
public struct MachTime: TimeProviding {
    @usableFromInline var sTimebaseInfo: mach_timebase_info_data_t

    @inlinable
    public init() {
        var info: mach_timebase_info_data_t = mach_timebase_info()
        let kernReturn: kern_return_t = mach_timebase_info(&info)
        precondition(KERN_SUCCESS == kernReturn, "Unable to get mach_timebase_info")
        sTimebaseInfo = info
    }

    /// granularity: 1 ns
    @inline(__always)
    public func now() -> Nanoseconds {
        return mach_absolute_time()
    }

    @inline(__always)
    public func elapsed(start: Nanoseconds, end: Nanoseconds) -> Nanoseconds {
        let elapsedRaw: UInt64 = end - start
        let elapsed: UInt64 = elapsedRaw * numericCast(sTimebaseInfo.numer) / numericCast(sTimebaseInfo.denom)
        return elapsed
    }
}
#endif
