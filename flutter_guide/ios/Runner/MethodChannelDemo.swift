
import Flutter
import UIKit

public class MethodChannelDemo {
    var count =  0
    var channel:FlutterMethodChannel
    init(messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: "com.flutter.guide.MethodChannel", binaryMessenger: messenger)
        channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
            if (call.method == "sendData") {
                if let dict = call.arguments as? Dictionary<String, Any> {
                    let name:String = dict["name"] as? String ?? ""
                    let age:Int = dict["age"] as? Int ?? -1
                    result(["name":"hello,\(name)","age":age])
                }
            }
        }
        startTimer()
    }
    
    func startTimer() {
        var timer = Timer.scheduledTimer(timeInterval:1, target: self, selector:#selector(self.tickDown),userInfo:nil,repeats: true)
    }
    @objc func tickDown(){
        count += 1
        var args = ["count":count]
        channel.invokeMethod("timer", arguments:args)
    }
}
