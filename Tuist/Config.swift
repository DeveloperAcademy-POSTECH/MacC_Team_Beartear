import ProjectDescription

let config = Config(
    compatibleXcodeVersions: "14.0.1",
    swiftVersion: "5.7.0",
    plugins: [
        .local(path: .relativeToManifest("../../Plugins/MacC")),
    ]
)
