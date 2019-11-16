// swift-tools-version:5.0
import PackageDescription

private var swiftSettings: [SwiftSetting] = []

#if canImport(Darwin)
swiftSettings.append(.define("USE_MACH_TIME"))
swiftSettings.append(.define("USE_POSIX_CLOCK"))
swiftSettings.append(.define("USE_POSIX_TOD"))
#endif

#if canImport(Glibc)
swiftSettings.append(.define("USE_POSIX_CLOCK"))
swiftSettings.append(.define("USE_POSIX_TOD"))
#endif

let package = Package(
    name: "FirebladeTime",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "FirebladeTime",
            targets: ["FirebladeTime"]),
    ],
    targets: [
        .target(
            name: "FirebladeTime",
            dependencies: [],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "FirebladeTimeTests",
            dependencies: ["FirebladeTime"],
            swiftSettings: swiftSettings),
        .testTarget(name: "FirebladeTimePerformanceTests",
                    dependencies: ["FirebladeTime"],
                    swiftSettings: swiftSettings)
    ]
)
