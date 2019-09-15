// swift-tools-version:5.0
import PackageDescription

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
            dependencies: []),
        .testTarget(
            name: "FirebladeTimeTests",
            dependencies: ["FirebladeTime"]),
    ]
)
