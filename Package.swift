// swift-tools-version:5.0
import PackageDescription

let swiftSettings: [SwiftSetting] = [
.define("USE_MACH_TIME"),
//.define("USE_POSIX_CLOCK"),
//.define("USE_POSIX_TOD")
]

let package = Package(
    name: "FirebladeTime",
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
    ]
)
