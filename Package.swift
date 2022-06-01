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
            checksum: "0b2be661780998511871f6abfcf695e2a87290f75c906515df2694fe0304db00"),
        .binaryTarget(
            name: "BeyondWords",
            path: "BeyondWords.xcframework"
        )
    ]
)
