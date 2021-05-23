// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkingModule",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "NetworkingModule",
            targets: ["NetworkingModule"]),
    ],
    dependencies: [
        .package(path: "../ModelsModule"),
    ],
    targets: [
        .target(
            name: "NetworkingModule",
            dependencies: ["ModelsModule"]),
        .testTarget(
            name: "NetworkingModuleTests",
            dependencies: ["NetworkingModule"]),
    ]
)
