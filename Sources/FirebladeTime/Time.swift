//
//  Time.swift
//
//
//  Created by Christian Treffs on 15.09.19.
//

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Darwin
#elseif os(Windows)
import CRT
#elseif canImport(Glibc)
import Glibc
#elseif canImport(WASILibc)
import WASILibc
#else
#error("Unsupported runtime")
#endif

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

    @inlinable
    public static func timestamp() -> String {
        var tv = timeval()
        gettimeofday(&tv, nil)
        let tm = localtime(&tv.tv_sec)
        let millis = tv.tv_usec
        
        if #available(macOS 11.0, iOS 14.0, tvOS 14.0, *) {
            return String(unsafeUninitializedCapacity: 32) { cPtr in
                cPtr.withMemoryRebound(to: CChar.self) { ptr in
                    let pBase = ptr.baseAddress!
                    strftime(pBase, 20, "%Y-%m-%d %H:%M:%S.", tm)
                    let pMilli = pBase.advanced(by: 20)
                    _ = withVaList([millis]) { vsnprintf(pMilli, 7, "%06d", $0) }
                    let pZone = pMilli.advanced(by: 6)
                    _ = strftime(pZone, 5, "%z", tm)
                }
                return 31
            }
        } else {
            var buffer = [CChar](repeating: 0, count: 32)
            return buffer.withUnsafeMutableBufferPointer { ptr -> String in
                let pBase = ptr.baseAddress!
                strftime(pBase, 20, "%Y-%m-%d %H:%M:%S.", tm)
                let pMilli = pBase.advanced(by: 20)
                _ = withVaList([millis]) { vsnprintf(pMilli, 7, "%06d", $0) }
                let pZone = pMilli.advanced(by: 6)
                strftime(pZone, 5, "%z", tm)
                return String(cString: pBase)
            }
        }
    }
}
