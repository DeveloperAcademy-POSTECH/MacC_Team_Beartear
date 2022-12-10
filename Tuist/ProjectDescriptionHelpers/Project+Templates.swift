import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

public let swiftlint = """
    if [ "${ENABLE_LINT}" = "NO" ] ; then
        echo "LINT DISABLED!"
        exit
    fi
    echo "${ENABLE_LINT}"
    echo "EXECUTE LINT"
    if test -d "/opt/homebrew/bin/"; then
            PATH="/opt/homebrew/bin/:${PATH}"
        fi

        export PATH

        if which swiftlint > /dev/null; then
            swiftlint
        else
            echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
        fi

"""

public let firebaseInfoScript = """
case "${CONFIGURATION}" in
  "Dev" )
cp -r "$SRCROOT/Gom4ziz/Resource/Firebase/GoogleService-Info-Debug.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
  "Release" )
cp -r "$SRCROOT/Gom4ziz/Resource/Firebase/GoogleService-Info-Prod.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
*)
;;
esac
"""

public extension Project {
    static func target(
        name: String,
        bundleId: String? = nil,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist = .default,
        platform: Platform,
        product: Product,
        sources: SourceFilesList,
        resources: ResourceFileElements,
        entitlements: Path? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = [],
        additionalFiles: [FileElement] = []
    ) -> Target {
        return Target(name: name,
                      platform: platform,
                      product: product,
                      bundleId: bundleId ?? "com.gom4ziz.\(name.lowercased())",
                      deploymentTarget: deploymentTarget,
                      infoPlist: infoPlist,
                      sources: sources,
                      resources: resources,
                      entitlements: entitlements,
                      scripts: scripts,
                      dependencies: dependencies,
                      settings: settings,
                      coreDataModels: coreDataModels,
                      additionalFiles: additionalFiles)
    }
}
