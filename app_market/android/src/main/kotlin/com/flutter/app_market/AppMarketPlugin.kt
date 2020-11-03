package com.flutter.app_market

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File


/** AppMarketPlugin */
class AppMarketPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.flutter.app_market")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getInstallMarkets") {
            result.success(getInstallMarkets(context))
        } else if (call.method == "toMarket") {
            val packageName = call.argument<String>("packageName")
            toMarket(context, packageName)
        } else if (call.method == "exist") {
            val packageName = call.argument<String>("packageName")
            packageName?.also {
                result.success(exist(context, it))
            }
        } else if (call.method == "installApk") {
            val path = call.argument<String>("path")
            path?.also {
                installApk(context, it)
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * 获取手机上安装的所有应用商店
     */
    private fun getInstallMarkets(context: Context): List<String> {
        val intent = Intent()
        intent.action = "android.intent.action.VIEW"
        intent.addCategory(Intent.CATEGORY_DEFAULT)
        intent.data = Uri.parse("market://details?id=")
        val infos = context.packageManager.queryIntentActivities(intent, 0)
        val list = arrayListOf<String>()
        infos.forEach {
            list.add(it.activityInfo.packageName)
        }
        return list
    }

    /**
     * 跳转到应用市场
     */
    private fun toMarket(context: Context, packageName: String?) {
        try {
            var packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
            val uri = Uri.parse("market://details?id=${packageInfo.packageName}")
            val goToMarket = Intent(Intent.ACTION_VIEW, uri)
            goToMarket.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            packageName?.also {
                if (it.isNotEmpty()) {
                    goToMarket.setPackage(it)
                }
            }
            context.startActivity(goToMarket)
        } catch (e: ActivityNotFoundException) {
            e.printStackTrace()
        }
    }

    /**
     * 是否存在当前应用市场
     *
     */
    private fun exist(context: Context, packageName: String): Boolean {
        val manager = context.packageManager
        val intent = Intent().setPackage(packageName)
        val infos = manager.queryIntentActivities(intent,
                PackageManager.GET_INTENT_FILTERS)
        return infos.size > 0
    }

    /**
     * 安装app，android 7.0及以上和以下方式不同
     */
    private fun installApk(context: Context, path: String) {
        val file = File(path)
        if (!file.exists()) {
            return
        }

        val intent = Intent(Intent.ACTION_VIEW)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //7.0及以上

            val contentUri = FileProvider.getUriForFile(context, "${context.packageName}.fileprovider", file)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.setDataAndType(contentUri, "application/vnd.android.package-archive")
            context.startActivity(intent)
        } else {
            //7.0以下
            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive")
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
        }
    }
}
