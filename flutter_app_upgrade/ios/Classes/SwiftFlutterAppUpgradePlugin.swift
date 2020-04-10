import Flutter
import UIKit

public class SwiftFlutterAppUpgradePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_upgrade", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAppUpgradePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "getAppInfo") {
          let infoDictionary = Bundle.main.infoDictionary!
          let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
          let bundleIdentifier = infoDictionary["CFBundleIdentifier"]
          var map = [String:String]()
          map["packageName"] = bundleIdentifier as! String
          map["versionName"] = majorVersion as! String
          map["versionCode"] = "0"
          result(map)
      }else if(call.method == "toAppStore"){
          let args = call.arguments as! Dictionary<String, String>
          let urlString = "itms-apps://itunes.apple.com/app/"+(args["id"] ?? "")
          if let url = URL(string: urlString) {
              //根据iOS系统版本，分别处理
              if #available(iOS 10, *) {
                  UIApplication.shared.open(url, options: [:],
                                            completionHandler: {
                                              (success) in
                  })
              } else {
                  UIApplication.shared.openURL(url)
              }
          }
      }

    }
}
