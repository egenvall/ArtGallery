// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModelsModule",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "ModelsModule",
            targets: ["ModelsModule"]),
    ],
    targets: [
        .target(
            name: "ModelsModule",
            dependencies: []),
        ]
)
