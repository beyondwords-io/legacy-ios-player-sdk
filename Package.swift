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
            checksum: "f2c94da2290c7f1257d2ae5bf5af400cb845072d7c09f10e440266b5b372c5e6"),
        .binaryTarget(
            name: "BeyondWords",
            path: "BeyondWords.xcframework"
        )
    ]
)
