import Flutter
import UIKit
#if canImport(GoogleMaps)
import GoogleMaps
#endif

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
#if canImport(GoogleMaps)
    if let apiKey = GoogleMapsApiKeyProvider.apiKey() {
      GMSServices.provideAPIKey(apiKey)
    }
#endif
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}

private enum GoogleMapsApiKeyProvider {
  static func apiKey() -> String? {
    if let plistValue = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String,
       isUsable(plistValue) {
      return plistValue
    }

    let flavor = Bundle.main.object(forInfoDictionaryKey: "MarnAppFlavor") as? String
    let envFileName = ".env.\(flavor == "production" ? "production" : "development")"
    return envValue(named: "GOOGLE_MAPS_API_KEY", in: envFileName)
  }

  private static func envValue(named key: String, in envFileName: String) -> String? {
    let directories = [
      "Frameworks/App.framework/flutter_assets",
      "flutter_assets",
    ]

    for directory in directories {
      guard let path = Bundle.main.path(
        forResource: envFileName,
        ofType: nil,
        inDirectory: directory
      ) else {
        continue
      }

      guard let contents = try? String(contentsOfFile: path, encoding: .utf8) else {
        continue
      }

      for line in contents.components(separatedBy: .newlines) {
        let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.hasPrefix("\(key)=") else { continue }

        let value = String(trimmed.dropFirst(key.count + 1))
          .trimmingCharacters(in: CharacterSet(charactersIn: " \"'"))

        if isUsable(value) {
          return value
        }
      }
    }

    return nil
  }

  private static func isUsable(_ value: String) -> Bool {
    let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
    return !trimmed.isEmpty && !trimmed.contains("$(")
  }
}
