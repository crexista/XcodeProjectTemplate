// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "View",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "View",
            targets: ["View"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGen.git", from: "6.5.1"),
        .package(path: "../UseCase")
    ],
    targets: [
        .target(
            name: "View",
            dependencies: ["UseCase"],
            path: "Sources"),
        .testTarget(
            name: "ViewTests",
            dependencies: ["View"]),
    ]
)
