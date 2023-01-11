import UIKit
import CoreLocation
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  let manager = CLLocationManager()
    
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      if (CLLocationManager.locationServicesEnabled()) {
          switch CLLocationManager.authorizationStatus() {
          case .denied, .notDetermined, .restricted:
              self.manager.requestAlwaysAuthorization()
              break
          default: break
          }
      }
    GMSServices.provideAPIKey("AIzaSyBjY68K2AlX_rY-Ut4BcAcP4DbM-uz83mk")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
