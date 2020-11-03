import Flutter
import UIKit

public class SwiftAppMarketPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.flutter.app_market", binaryMessenger: registrar.messenger())
    let instance = SwiftAppMarketPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "toMarket"){
        let args = call.arguments as! Dictionary<String, String>
        let urlString = "itms-apps://itunes.apple.com/app/id"+(args["appleId"] ?? "")
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
