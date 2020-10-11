package com.flutter.guide

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry

/**
 * des:
 */
class MyPlugin : FlutterPlugin {


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val messenger: BinaryMessenger = binding.binaryMessenger
        binding
                .platformViewRegistry
                .registerViewFactory(
                        "plugins.flutter.io/custom_platform_view", MyFlutterViewFactory(messenger))
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            registrar
                    .platformViewRegistry()
                    .registerViewFactory(
                            "plugins.flutter.io/custom_platform_view",
                            MyFlutterViewFactory(registrar.messenger()))
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }
}