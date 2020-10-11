package com.flutter.guide

import android.app.Activity
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.timerTask

class EventChannelDemo(var activity: Activity, messenger: BinaryMessenger):EventChannel.StreamHandler {
    private var channel: EventChannel
    private var index = 0
    private var events: EventChannel.EventSink? = null
    init {
        channel = EventChannel(messenger, "com.flutter.guide.EventChannel")
        channel.setStreamHandler(this)
        startTimer()
    }


    fun startTimer() {
        var timer = Timer().schedule(timerTask {
            index++
            var map = mapOf("name" to "laomeng${index}",
                    "age" to "${index}"
            )
            activity.runOnUiThread {
                events?.success(map)
            }

        }, 0, 1000)

    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        this.events = null
    }
}