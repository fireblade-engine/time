//
//  Time.swift
//  FirebladeTime
//
//  Created by Christian Treffs on 17.02.19.
//

public protocol Time {
    init(_ nanoseconds: UInt64)

    static var now: Self { get }

    var nanoseconds: UInt64 { get }
    var microseconds: Double { get }
    var milliseconds: Double { get }
    var seconds: Double { get }

    func elapsed(since start: Self) -> Self
}
