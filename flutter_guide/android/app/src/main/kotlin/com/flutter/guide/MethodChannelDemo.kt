package com.flutter.guide

import android.app.Activity
import android.content.Context
import androidx.annotation.UiThread
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*
import kotlin.concurrent.timerTask

/**
 * des:
 */
class MethodChannelDemo(var activity: Activity, messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {

    private var channel: MethodChannel
    private var count = 0

    init {
        channel = MethodChannel(messenger, "com.flutter.guide.MethodChannel")
        channel.setMethodCallHandler(this)
        startTimer()
    }


    fun startTimer() {
        var timer = Timer().schedule(timerTask {
            activity.runOnUiThread {
                var map = mapOf("count" to count++)
                channel.invokeMethod("timer", map)
            }
        }, 0, 1000)

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "sendData") {
            val name = call.argument("name") as String?
            val age = call.argument("age") as Int?

            var map = mapOf("name" to "hello,$name",
                    "age" to "$age"
            )
            result.success(map)
        }
    }
}