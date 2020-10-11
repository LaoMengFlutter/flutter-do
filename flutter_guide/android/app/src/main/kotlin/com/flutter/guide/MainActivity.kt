package com.flutter.guide

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannelDemo(this,flutterEngine.dartExecutor.binaryMessenger)
        BasicMessageChannelDemo(this,flutterEngine.dartExecutor.binaryMessenger)
        EventChannelDemo(this,flutterEngine.dartExecutor.binaryMessenger)
        flutterEngine.plugins.add(MyPlugin())
    }
}