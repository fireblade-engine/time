// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "FirebladeTime",
    products: [
        .library(
            name: "FirebladeTime",
            targets: ["FirebladeTime"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
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
