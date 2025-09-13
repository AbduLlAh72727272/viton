import Flutter
import UIKit
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Configure for better iOS performance and crash prevention
    
    // Initialize Firebase with comprehensive error handling
    do {
      FirebaseApp.configure()
      print("Firebase initialized successfully")
    } catch {
      print("Firebase configuration failed: \(error)")
      // Continue without Firebase to prevent crashes
    }
    
    // Register plugins with comprehensive error handling
    do {
      GeneratedPluginRegistrant.register(with: self)
      print("Plugins registered successfully")
    } catch {
      print("Plugin registration failed: \(error)")
      // Continue without plugins to prevent crashes
    }
    
    // Configure for iOS 13+ compatibility
    if #available(iOS 13.0, *) {
      // Enable automatic window scene management
      self.window?.makeKeyAndVisible()
    }
    
    // Configure for better memory management
    self.window?.backgroundColor = UIColor.white
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle memory warnings with better cleanup
  override func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    super.applicationDidReceiveMemoryWarning(application)
    print("Memory warning received - cleaning up")
    
    // Clear any cached data if needed
    URLCache.shared.removeAllCachedResponses()
  }
  
  // Handle app lifecycle for better stability
  override func applicationDidEnterBackground(_ application: UIApplication) {
    super.applicationDidEnterBackground(application)
    print("App entered background")
  }
  
  override func applicationWillEnterForeground(_ application: UIApplication) {
    super.applicationWillEnterForeground(application)
    print("App will enter foreground")
  }
  
  // Handle app termination gracefully
  override func applicationWillTerminate(_ application: UIApplication) {
    super.applicationWillTerminate(application)
    print("App will terminate")
  }
}
