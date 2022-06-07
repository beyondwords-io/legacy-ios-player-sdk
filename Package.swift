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
            checksum: "912b2a3e6faf5baf7012d599c2ca84446ce748eafd742da1064ab92f220ffcc0"),
        .binaryTarget(
            name: "BeyondWords",
            path: "BeyondWords.xcframework"
        )
    ]
)
