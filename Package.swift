// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocationPackage",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LocationPackage",
            targets: ["LocationPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Yoji-kms/WeatherNetworkService", branch: "main"),
        .package(url: "https://github.com/Yoji-kms/LocationService", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LocationPackage",
            dependencies: [
                .product(name: "NetworkService", package: "weathernetworkservice"),
                .product(name: "LocationService", package: "locationservice")
            ]
        ),
        .testTarget(
            name: "LocationPackageTests",
            dependencies: ["LocationPackage"]
        ),
    ]
)
