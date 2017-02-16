import PackageDescription

let package = Package(
    name: "ChapterExtractor",
    dependencies: [
        .Package(url: "../CAVFormat", majorVersion: 0),
    ]
)
