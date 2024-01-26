import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(Secret().googleMapApiKey)
    GeneratedPluginRegistrant.register(with: self)
      
    GMSServices.provideAPIKey("${GOOGLE_MAP_API_KEY}")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
