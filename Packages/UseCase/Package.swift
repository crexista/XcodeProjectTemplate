// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UseCase",
    products: [
        .library(
            name: "UseCase",
            targets: ["UseCase"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "UseCase",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "UseCaseTests",
            dependencies: ["UseCase"]),
    ]
)
