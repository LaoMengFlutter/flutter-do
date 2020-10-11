package com.flutter.guide

import android.content.Context
import android.util.Log
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * des:
 */
class MyFlutterView(context: Context, messenger: BinaryMessenger, viewId: Int, args: Map<String, Any>?) : PlatformView, MethodChannel.MethodCallHandler {

    val textView: TextView = TextView(context)
    private var methodChannel: MethodChannel

    init {
        args?.also {
            textView.text = it["text"] as String
        }
        Log.e("mqd","viewId:$viewId")
        methodChannel = MethodChannel(messenger, "com.flutter.guide.MyFlutterView_$viewId")
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View {

        return textView
    }

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.e("mqd","onMethodCall")
        if (call.method == "setText") {
            val name = call.argument("name") as String?
            val age = call.argument("age") as Int?
            textView.text = "hello,$name,年龄：$age"
        } else if (call.method == "getData") {
            val name = call.argument("name") as String?
            val age = call.argument("age") as Int?

            var map = mapOf("name" to "hello,$name",
                    "age" to "$age"
            )
            result.success(map)
        } else {
            result.notImplemented()
        }
    }
}