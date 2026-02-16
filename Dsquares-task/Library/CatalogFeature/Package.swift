// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CatalogFeature",
    platforms: [
         .iOS(.v15)
     ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CatalogFeature",
            targets: ["CatalogFeature"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.11.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI", from: "3.1.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CatalogFeature",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ]
        ),
        .testTarget(
            name: "CatalogFeatureTests",
            dependencies: ["CatalogFeature"]
        ),
    ]
)
