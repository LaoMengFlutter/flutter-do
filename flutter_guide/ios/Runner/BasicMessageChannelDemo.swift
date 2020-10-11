

import Flutter
import UIKit

public class BasicMessageChannelDemo {
    
    var channel:FlutterBasicMessageChannel
    var count =  0
    
    init(messenger: FlutterBinaryMessenger) {
        channel = FlutterBasicMessageChannel(name: "com.flutter.guide.BasicMessageChannel", binaryMessenger: messenger)
        channel.setMessageHandler { (message, reply) in
            if let dict = message as? Dictionary<String, Any> {
                let name:String = dict["name"] as? String ?? ""
                let age:Int = dict["age"] as? Int ?? -1
                reply(["name":"hello,\(name)","age":age])
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
        channel.sendMessage(args) { (reply) in
            
        }
    }
}
