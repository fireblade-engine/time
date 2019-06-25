//
//  Time.swift
//  FirebladeEngine
//
//  Created by Christian Treffs on 14.01.18.
//
/*
 
#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin.POSIX.sys.time
#elseif os(Linux)
import Glibc
#else
// "unsupported platform"
#endif

public enum Time {
    /// current time in milliseconds
    static var now: Int {
        var tval = timeval()
        gettimeofday(&tval, nil)
        return (tval.tv_sec * 1000) + (Int(tval.tv_usec) / 1000)
    }
}

public final class Timer {
    private(set) var frameCount: Int = 0
    private var lastFrameTime: Double = -1.0
    private var frameCountRecord: Int = 0
    private(set) var fps: Double = 0.0
    var fpsMaxSamples: Int = 4
    private var fpsDeltas: [Double] = []

    /// delta time in seconds
    private(set) var deltaTime: Double = 0.0
    private var startupTime: Int = Time.now
    private var lastTime: Double = 0.0

    /// time since startup in seconds
    public final var timeSinceStartup: Double {
        let deltaStartup: Int = Time.now - startupTime
        return Double(deltaStartup) / 1000.0
    }

    private final func accumulatedFPS(deltaT: Double) -> Double {
        if fpsDeltas.count == fpsMaxSamples {
            fpsDeltas.removeFirst()
        }
        fpsDeltas.append(deltaT)

        let sum: Double = fpsDeltas.reduce(0.0, +)
        let averageInverse: Double = sum / Double(fpsDeltas.count)
        let averageFPS: Double = 1.0 / averageInverse
        return averageFPS
    }

    /// update every frame
    public final func update() {
        // update delta t
        let time0 = timeSinceStartup // seconds
        deltaTime = time0 - lastTime
        lastTime = time0

        fps = accumulatedFPS(deltaT: deltaTime)

        // update frame count
        frameCount += 1
    }
}
*/
