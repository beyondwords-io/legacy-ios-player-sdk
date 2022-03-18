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
            url: "https://github.com/SpeechKit/speechkit-ios-sdk-public/blob/master/BeyondWords.xcframework.zip",
            checksum: "3920341bd509a8b5d7e1df6546edd2344c490026c165fc3af2a38273f74ab97c"),
        .binaryTarget(
            name: "BeyondWords",
            path: "BeyondWords.xcframework"
        )
    ]
)
