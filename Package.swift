// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "BeyondWords",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5),
    ],
    products: [
        .library(name: "BeyondWords", targets: ["BeyondWords"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .binaryTarget(
            name: "BeyondWords",
            path: "BeyondWords.xcframework"
        )
    ]
)
