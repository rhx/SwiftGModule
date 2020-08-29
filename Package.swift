// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "GModule",
    products: [
        .library(name: "GModule", targets: ["GModule"]),
    ],
    dependencies: [
        .package(url: "ssh://promac.local/Users/rh/src/swift/rh/gtk/SwiftGLib", .branch("master"))
        //.package(url: "https://github.com/rhx/SwiftGLib.git", .branch("master"))
    ],
    targets: [
        .target(name: "GModule", dependencies: ["GLib"]),
        .testTarget(name: "GModuleTests", dependencies: ["GModule"]),
    ]
)
