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
            checksum: "69001f0fdb6236fe67cae70e0bde7eba223b908351c60f778d1768822f555f12"),
        .binaryTarget(
            name: "BeyondWords",
            path: "BeyondWords.xcframework"
        )
    ]
)
