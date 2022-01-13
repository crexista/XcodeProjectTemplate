// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "App",
            targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.45.1"),
        .package(path: "../Infrastructure"),
        .package(path: "../View")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: ["View","Infrastructure"],
            path: "Sources"),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]),
    ]
)
