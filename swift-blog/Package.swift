import PackageDescription

let package = Package(
    name: "swift-blog",
    targets: [
      Target(name: "Application", dependencies: [ .Target(name: "Generated") ]),
      Target(name: "swift-blog", dependencies: [ .Target(name: "Application") ])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1, minor: 6),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1, minor: 6),
        .Package(url: "https://github.com/IBM-Swift/CloudConfiguration.git", majorVersion: 1),
        .Package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", majorVersion: 1),

    ],
    exclude: ["src"]
)
