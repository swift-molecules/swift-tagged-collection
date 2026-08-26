// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-tagged-collection",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Tagged Collection",
            targets: ["Tagged Collection"]
        ),
        .library(
            name: "Tagged Collection Test Support",
            targets: ["Tagged Collection Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-collection.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Tagged Collection",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Collection Protocol",
                    package: "swift-collection"
                ),
                .product(name: "Index", package: "swift-index"),
            ]
        ),

        .target(
            name: "Tagged Collection Test Support",
            dependencies: [
                "Tagged Collection",

                .product(
                    name: "Collection Test Support",
                    package: "swift-collection"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Tagged Collection Tests",
            dependencies: [
                "Tagged Collection",
                "Tagged Collection Test Support",
                .product(
                    name: "Collection Test Support",
                    package: "swift-collection"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
