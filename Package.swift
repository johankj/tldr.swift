import PackageDescription

let package = Package(
    name: "tldr",
    dependencies: [
        // Custom version of PrettyColors to support Swift Package Manager
        .Package(url: "../PrettyColors", majorVersion: 3),
        // Custom version of CommandLine to support positional arguments
        .Package(url: "../CommandLine", majorVersion: 2)
    ]
)
