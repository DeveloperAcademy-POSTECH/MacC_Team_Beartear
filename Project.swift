import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains MacC App target and MacC unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let projectName: String = "Gom4ziz"
let bundleID: String = "com.gom4ziz.tiramisul"
let iOSTargetVersion: String = "15.0"

let infoPlist: InfoPlist = .extendingDefault(with: [
    "CFBundleURLTypes": .array([.dictionary([
        "CFBundleTypeRole": .string("Editor"),
        "CFBundleURLSchemes": .array([.string("kakaoeb92b48052cc747b19537d2ed3f9f8a2")])
    ])]),
    "LSApplicationQueriesSchemes": .array([.string("kakaokompassauth"), .string("kakaolink")]),
    "UIApplicationSceneManifest": .dictionary([
        "UIApplicationSupportsMultipleScenes": .boolean(false),
        "UISceneConfigurations": .dictionary([
            "UIWindowSceneSessionRoleApplication": .array([
                .dictionary([
                    "UISceneConfigurationName": .string("Default Configuration"),
                    "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate"),
                    "UISceneStoryboardFile": .string("Main")
                ])
            ])
        ])
    ]),
    "UIUserInterfaceStyle": .string("Light")
])

let appTarget: Target = Project.target(name: "Gom4ziz",
                                       bundleId: bundleID,
                                       deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                                       infoPlist: infoPlist,
                                       platform: .iOS,
                                       product: .app,
                                       sources: ["Gom4ziz/Source/**"],
                                       resources: ["Gom4ziz/Resource/**"],
                                       entitlements: "Gom4ziz/File/Gom4ziz.entitlements",
                                       scripts: [
                                        .pre(script: swiftlint, name: "SwiftLint"),
                                        .pre(script: firebaseInfoScript, name: "FirebaseInfo Generate")
                                       ],
                                       dependencies: [.package(product: "FirebaseAuth"),
                                                      .package(product: "FirebaseFirestore"),
                                                      .package(product: "FirebaseFirestoreSwift"),
                                                      .package(product: "RxSwift"),
                                                      .package(product: "RxRelay"),
                                                      .package(product: "RxCocoa"),
                                                      .package(product: "Lottie"),
                                                      .package(product: "RxDataSources")
                                                      ],
                                       additionalFiles: [
                                        ".swiftlint.yml"
                                       ])

let testTarget: Target = Project.target(name: "Gom4zizTests",
                                        deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                                        platform: .iOS,
                                        product: .unitTests,
                                        sources: ["Gom4zizTests/Source/**"],
                                        resources: [],
                                        dependencies: [.target(name: "Gom4ziz"),
                                                       .package(product: "RxTest"),
                                                       .package(product: "RxBlocking")])

let settings: Settings = Settings.settings(configurations: [
    .debug(name: .init(stringLiteral: "Test"), settings: [
        "ENABLE_LINT": "NO"
    ]),
    .debug(name: .init(stringLiteral: "Dev"), settings: [
        "ENABLE_LINT": "YES",
    ]),
    .release(name: .init(stringLiteral: "Release"), settings: [
        "ENABLE_LINT": "NO"
    ])
])

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
    name: projectName,
    organizationName: nil,
    options: .options(automaticSchemesOptions: .disabled),
    packages: [
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "9.0.0")),
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.0.0")),
        .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "3.0.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMajor(from: "5.0.2"))
    ],
    settings: settings,
    targets: [
        appTarget,
        testTarget
    ],
    schemes: [
        Scheme(name: "\(projectName)-Dev",
               shared: true,
               buildAction: .buildAction(targets: ["Gom4ziz"]),
               testAction: .targets(["Gom4zizTests"], configuration: .configuration("Dev"), options: .options(coverage: true)),
               runAction: .runAction(configuration: .configuration("Dev")),
               archiveAction: .archiveAction(configuration: .configuration("Dev")),
               profileAction: .profileAction(configuration: .configuration("Dev")),
               analyzeAction: .analyzeAction(configuration: .configuration("Dev"))),
        Scheme(name: "\(projectName)-Release",
               shared: true,
               buildAction: .buildAction(targets: ["Gom4ziz"]),
               testAction: .targets(["Gom4zizTests"], configuration: .configuration("Release"), options: .options(coverage: true)),
               runAction: .runAction(configuration: .configuration("Release")),
               archiveAction: .archiveAction(configuration: .configuration("Release")),
               profileAction: .profileAction(configuration: .configuration("Release")),
               analyzeAction: .analyzeAction(configuration: .configuration("Release"))),
        Scheme(name: "\(projectName)-Test",
               shared: true,
               buildAction: .buildAction(targets: ["Gom4ziz"]),
               testAction: .targets(["Gom4zizTests"], configuration: .configuration("Test"), options: .options(coverage: true)),
               runAction: .runAction(configuration: .configuration("Test")),
               archiveAction: .archiveAction(configuration: .configuration("Test")),
               profileAction: .profileAction(configuration: .configuration("Test")),
               analyzeAction: .analyzeAction(configuration: .configuration("Test"))),
    ],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: []
    )
