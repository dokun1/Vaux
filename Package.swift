// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Vaux",
    products: [
        .library(name: "Vaux", targets: ["Vaux"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Vaux", dependencies: []),
        .testTarget(name: "VauxTests", dependencies: ["Vaux"]),
    ]
)
