// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Pigwidgeon",
    platforms: [
        .iOS(.v11),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Pigwidgeon",
            targets: ["Pigwidgeon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
        .package(url: "https://github.com/realm/SwiftLint", branch: "main")
    ],
    targets: [
        .target(
            name: "Pigwidgeon",
            dependencies: ["Alamofire"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]),
        .testTarget(
            name: "PigwidgeonTests",
            dependencies: ["Pigwidgeon"]),
    ]
)
