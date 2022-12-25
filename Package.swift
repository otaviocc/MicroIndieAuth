// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MicroIndieAuth",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(
            name: "MicroIndieAuth",
            targets: ["MicroIndieAuth"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/otaviocc/MicroClient.git",
            from: "0.0.15"
        )
    ],
    targets: [
        .target(
            name: "MicroIndieAuth",
            dependencies: ["MicroClient"]
        ),
        .testTarget(
            name: "MicroIndieAuthTests",
            dependencies: ["MicroIndieAuth"]
        )
    ]
)
