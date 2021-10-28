# FirebladeTime

[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)
[![macOS](https://github.com/fireblade-engine/time/actions/workflows/ci-macos.yml/badge.svg)](https://github.com/fireblade-engine/time/actions/workflows/ci-macos.yml)
[![Linux](https://github.com/fireblade-engine/time/actions/workflows/ci-linux.yml/badge.svg)](https://github.com/fireblade-engine/time/actions/workflows/ci-linux.yml)

A dependency free, lightweight, time library in Swift.  It is developed and maintained as part of the [Fireblade Game Engine project](https://github.com/fireblade-engine).

## 🚀 Getting Started

These instructions will get you a copy of the project up and running on your local machine and provide a code example.

### 📋 Prerequisites

* [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager)
* [Swiftlint](https://github.com/realm/SwiftLint) for linting - (optional)

### 💻 Installing

Fireblade Time is available for all platforms that support [Swift 5.1](https://swift.org/) and higher and the [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager).

Extend the following lines in your `Package.swift` file or use it to create a new project.

```swift
// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
        .package(url: "https://github.com/fireblade-engine/time.git", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["FirebladeTime"])
    ]
)

```

## 💁 How to contribute

If you want to contribute please see the [CONTRIBUTION GUIDE](CONTRIBUTING.md) first. 

To start your project contribution run these in your command line:

1. `git clone git@github.com:fireblade-engine/time.git fireblade-time`
2. `cd fireblade-time`

Before commiting code please ensure to run:

- `make pre-push`

This project is currently maintained by [@ctreffs](https://github.com/ctreffs).   
See also the list of [contributors](https://github.com/fireblade-engine/time/contributors) who participated in this project.

## 🔏 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details