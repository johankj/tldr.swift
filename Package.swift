import PackageDescription

let package = Package(
	name: "tldr",
	dependencies: [
		.Package(url: "../PrettyColors", majorVersion: 3),
	]
)
