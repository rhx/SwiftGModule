// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "GModule",
    products: [ .library(name: "GModule", targets: ["GModule"]) ],
    dependencies: [
        .package(name: "GLib", url: "https://github.com/rhx/SwiftGLib.git", .branch("master"))
    ],
    targets: [
        .target(name: "GModule", dependencies: ["GLib"]),
        .testTarget(name: "GModuleTests", dependencies: ["GModule"]),
    ]
)
