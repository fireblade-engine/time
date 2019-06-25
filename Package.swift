// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "FirebladeTime",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "FirebladeTime",
            targets: ["FirebladeTime"]),
    ],
    targets: [
        .target(
            name: "FirebladeTime",
            dependencies: []),
        .testTarget(
            name: "FirebladeTimeTests",
            dependencies: ["FirebladeTime"]),
    ]
)
