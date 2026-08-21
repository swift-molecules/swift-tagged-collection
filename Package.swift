// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-tagged-collection-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Tagged Collection Primitives",
            targets: ["Tagged Collection Primitives"]
        ),
        .library(
            name: "Tagged Collection Primitives Test Support",
            targets: ["Tagged Collection Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-tagged-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-collection-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-index-primitives.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Tagged Collection Primitives",
            dependencies: [
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(
                    name: "Collection Protocol Primitives",
                    package: "swift-collection-primitives"
                ),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
            ]
        ),

        .target(
            name: "Tagged Collection Primitives Test Support",
            dependencies: [
                "Tagged Collection Primitives",

                .product(
                    name: "Collection Primitives Test Support",
                    package: "swift-collection-primitives"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Tagged Collection Primitives Tests",
            dependencies: [
                "Tagged Collection Primitives",
                "Tagged Collection Primitives Test Support",
                .product(
                    name: "Collection Primitives Test Support",
                    package: "swift-collection-primitives"
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
