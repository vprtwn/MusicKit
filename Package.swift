// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MusicKit",
    products: [
        .library(
            name: "MusicKit",
            targets: ["MusicKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MKMIDIProc",
            path: "MusicKit",
            sources: [
                "MKMIDIProc.h",
                "MKMIDIProc.m"
            ]
        ),
        .target(
            name: "MusicKit",
            dependencies: [
                .target(name: "MKMIDIProc")
            ],
            path: "MusicKit",
            exclude: [
                "MKMIDIProc.h",
                "MKMIDIProc.m"
            ]
        ),
        .testTarget(
            name: "MusicKitTests",
            dependencies: ["MusicKit"],
            path: "MusicKitTests"
        ),
    ]
)

