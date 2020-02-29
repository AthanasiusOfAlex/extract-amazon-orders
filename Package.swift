// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "extract-amazon-orders",
    dependencies: [
        .package(url: "https://github.com/AthanasiusOfAlex/AmazonOrderExtractor.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "extract-amazon-orders",
            dependencies: ["AmazonOrderExtractor"]),
        .testTarget(
            name: "extract-amazon-ordersTests",
            dependencies: ["extract-amazon-orders"]),
    ]
)
