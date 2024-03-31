import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      guard let controller = window?.rootViewController as? FlutterViewController else {
               return super.application(application, didFinishLaunchingWithOptions: launchOptions)
           }
      // 1
           let flavorChannel = FlutterMethodChannel(name: "platform_native_demo", binaryMessenger: controller.binaryMessenger)
           // 2
           flavorChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
               switch call.method {
               // 3
               case "checkInfoDevice":
                   let data = call.arguments as? Dictionary<String, Any>;
                   
                   let value = data?["code"] as? String;
                   if(value == "0"){
                       result("Welcome from IOS");
                   }
         
               default:
                   // 4
                   result(FlutterMethodNotImplemented)
               }
           })
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
