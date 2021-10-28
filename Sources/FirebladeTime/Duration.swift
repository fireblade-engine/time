//
//  Duration.swift
//  FirebladeEngine
//
//  Created by Christian Treffs on 01.08.17.
//
// swiftlint:disable identifier_name

// see: https://github.com/scala/scala/tree/2.12.x/src/library/scala/concurrent/duration
public typealias DurationUnit = UInt64

// private let nanoNanos: DurationUnit = 1
private let kµsPerNs = DurationUnit(1e3)
private let kMsPerNs: DurationUnit = kµsPerNs * DurationUnit(1e3)
private let kSecPerNs: DurationUnit = kMsPerNs * DurationUnit(1e3)
private let kMinPerNs: DurationUnit = kSecPerNs * DurationUnit(60)
private let kHPerNs: DurationUnit = kMinPerNs * DurationUnit(60)
private let kDPerNs: DurationUnit = kHPerNs * DurationUnit(24)

public enum TimeUnit: String {
    case Nanoseconds = "ns"
    case Microseconds = "µs"
    case Milliseconds = "ms"
    case Seconds = "s"
    case Minutes = "min"
    case Hours = "h"
    case Days = "d"
}

public struct Duration: Equatable, Comparable, Hashable, CustomDebugStringConvertible, CustomStringConvertible {
    public static let zero = Duration(DurationUnit(0))
    public static let nanosecond = Duration(nanoseconds: DurationUnit(1))
    public static let microsecond = Duration(microseconds: DurationUnit(1))
    public static let millisecond = Duration(milliseconds: DurationUnit(1))
    public static let second = Duration(seconds: DurationUnit(1))
    public static let minute = Duration(minutes: DurationUnit(1))
    public static let hour = Duration(hours: DurationUnit(1))
    public static let day = Duration(days: DurationUnit(1))

    public static let maxDuration = Duration(DurationUnit.max)

    // can hold up to 584,942417355072 years
    internal let nanoTime: DurationUnit

    public init?(fromString timeString: String, unit: TimeUnit) {
        guard let duration = DurationUnit(timeString) else {
            return nil
        }

        switch unit {
        case .Nanoseconds:
            self.init(nanoseconds: duration)

        case .Microseconds:
            self.init(microseconds: duration)

        case .Milliseconds:
            self.init(milliseconds: duration)

        case .Seconds:
            self.init(seconds: duration)

        case .Minutes:
            self.init(minutes: duration)

        case .Hours:
            self.init(hours: duration)

        case .Days:
            self.init(days: duration)
        }
    }

    public init(_ nanoseconds: DurationUnit) { nanoTime = nanoseconds }
    public init(nanoseconds: DurationUnit) { nanoTime = nanoseconds }
    public init(_ nanoseconds: Double) { nanoTime = DurationUnit(nanoseconds) }
    public init(nanoseconds: Double) { nanoTime = DurationUnit(nanoseconds) }

    public var nanoseconds: (floatPt: Double, fixPt: DurationUnit) { (Double(self.nanoTime), self.nanoTime) }

    public init(microseconds: DurationUnit) { nanoTime = microseconds * kµsPerNs }
    public init(microseconds: Double) { nanoTime = DurationUnit(Double(kµsPerNs) * microseconds) }

    public var microseconds: (floatPt: Double, fixPt: DurationUnit) { fromNanos(kµsPerNs) }

    public init(milliseconds: DurationUnit) { nanoTime = milliseconds * kMsPerNs }
    public init(milliseconds: Double) { nanoTime = DurationUnit(Double(kMsPerNs) * milliseconds) }

    public var milliseconds: (floatPt: Double, fixPt: DurationUnit) { fromNanos(kMsPerNs) }

    public init(seconds: DurationUnit) { nanoTime = seconds * kSecPerNs }
    public init(seconds: Double) { nanoTime = DurationUnit(Double(kSecPerNs) * seconds) }

    public var seconds: (floatPt: Double, fixPt: DurationUnit) { fromNanos(kSecPerNs) }

    public init(minutes: DurationUnit) { nanoTime = minutes * kMinPerNs }
    public init(minutes: Double) { nanoTime = DurationUnit(Double(kMinPerNs) * minutes) }

    public var minutes: (floatPt: Double, fixPt: DurationUnit) { fromNanos(kMinPerNs) }

    public init(hours: DurationUnit) { nanoTime = hours * kHPerNs }
    public init(hours: Double) { nanoTime = DurationUnit(Double(kHPerNs) * hours) }

    public var hours: (floatPt: Double, fixPt: DurationUnit) { fromNanos(kHPerNs) }

    public init(days: DurationUnit) { nanoTime = days * kDPerNs }
    public init(days: Double) { nanoTime = DurationUnit(Double(kDPerNs) * days) }

    public var days: (floatPt: Double, fixPt: DurationUnit) { fromNanos(kDPerNs) }

    public var asNanoString: String {
        String(nanoTime)
    }

    public var description: String {
        asNanoString
    }

    public func add(_ o: Duration) -> Duration { Duration(nanoseconds: nanoTime + o.nanoTime) }
    public func subtract(_ o: Duration) -> Duration? {
        if nanoTime < o.nanoTime {
            return nil
        }
        return Duration(nanoseconds: nanoTime - o.nanoTime)
    }

    /* public init(timeInterval: TimeInterval) {
     // NSTimeInterval is always specified in seconds; it yields sub-millisecond precision over a range of 10,000 years.
     self.nanoTime = DurationUnit(timeInterval) * secPerNs
     }
     public var timeInterval: TimeInterval { return TimeInterval(self.seconds.floatPt) } */

    private func fromNanos(_ factor: DurationUnit) -> (floatPt: Double, fixPt: DurationUnit) {
        let dval = Double(nanoTime) / Double(factor)
        return (dval, DurationUnit(dval))
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(nanoTime)
    }

    public var debugDescription: String {
        if self < Duration.microsecond {
            return "\(nanoseconds.floatPt)ns"
        } else if self < Duration.millisecond {
            return "\(microseconds.floatPt)µs"
        } else if self < Duration.second {
            return "\(milliseconds.floatPt)ms"
        } else if self < Duration.minute {
            return "\(seconds.floatPt)s"
        } else if self < Duration.hour {
            return "\(minutes.floatPt)min"
        } else if self < Duration.day {
            return "\(hours.floatPt)h"
        } else {
            return "\(days.floatPt)d"
        }
    }

    public static func == (lhs: Duration, rhs: Duration) -> Bool { lhs.nanoTime == rhs.nanoTime }
    public static func < (lhs: Duration, rhs: Duration) -> Bool { lhs.nanoTime < rhs.nanoTime }
    public static func + (lhs: Duration, rhs: Duration) -> Duration { lhs.add(rhs) }
    public static func += (lhs: inout Duration, rhs: Duration) { lhs = lhs + rhs }
    public static func - (lhs: Duration, rhs: Duration) -> Duration? { lhs.subtract(rhs) }
}

// MARK: - extensions

public protocol DurationConvertible {
    var nanoseconds: Duration { get }
    var microseconds: Duration { get }
    var milliseconds: Duration { get }
    var seconds: Duration { get }
    var minutes: Duration { get }
    var hours: Duration { get }
    var days: Duration { get }
}

extension Int: DurationConvertible {
    public var nanoseconds: Duration { Duration(DurationUnit(self)) }
    public var microseconds: Duration { Duration(microseconds: DurationUnit(self)) }
    public var milliseconds: Duration { Duration(milliseconds: DurationUnit(self)) }
    public var seconds: Duration { Duration(seconds: DurationUnit(self)) }
    public var minutes: Duration { Duration(minutes: DurationUnit(self)) }
    public var hours: Duration { Duration(hours: DurationUnit(self)) }
    public var days: Duration { Duration(days: DurationUnit(self)) }
}

extension Float: DurationConvertible {
    public var nanoseconds: Duration { Duration(Double(self)) }
    public var microseconds: Duration { Duration(microseconds: Double(self)) }
    public var milliseconds: Duration { Duration(milliseconds: Double(self)) }
    public var seconds: Duration { Duration(seconds: Double(self)) }
    public var minutes: Duration { Duration(minutes: Double(self)) }
    public var hours: Duration { Duration(hours: Double(self)) }
    public var days: Duration { Duration(days: Double(self)) }
}

extension Double: DurationConvertible {
    public var nanoseconds: Duration { Duration(self) }
    public var microseconds: Duration { Duration(microseconds: self) }
    public var milliseconds: Duration { Duration(milliseconds: self) }
    public var seconds: Duration { Duration(seconds: self) }
    public var minutes: Duration { Duration(minutes: self) }
    public var hours: Duration { Duration(hours: self) }
    public var days: Duration { Duration(days: self) }
}
