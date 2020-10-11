import Flutter
import UIKit

public class MethodChannelPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.flutter.guide.MethodChannel", binaryMessenger: registrar.messenger())
        let instance = MethodChannelPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "sendData") {
            if let dict = call.arguments as? Dictionary<String, Any> {
                let name:String = dict["name"] as? String ?? ""
                let age:Int = dict["age"] as? Int ?? -1
                result(["name":"hello,\(name)","age":age])
            }
        }
    }
}
