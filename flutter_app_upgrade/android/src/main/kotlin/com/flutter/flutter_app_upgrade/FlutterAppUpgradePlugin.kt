package com.flutter.flutter_app_upgrade

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File
import java.util.*

/** FlutterUpgradePlugin */
public class FlutterAppUpgradePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {


  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mContext = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_app_upgrade")
    channel.setMethodCallHandler(FlutterAppUpgradePlugin())
  }

  companion object {
    lateinit var mContext: Context

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      this.mContext = registrar.activity()
      val channel = MethodChannel(registrar.messenger(), "flutter_app_upgrade")
      channel.setMethodCallHandler(FlutterAppUpgradePlugin())
    }

  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getAppInfo") {
      getAppInfo(mContext, result)
    } else if (call.method == "getApkDownloadPath") {
      result.success(mContext.getExternalFilesDir("")?.absolutePath)
    } else if (call.method == "install") {
      if (BuildConfig.googlePlay) {
        result.error("error", "googlePlay=true, The app installation function is disabled.", null)
      } else {
        // 安装app
        val path = call.argument<String>("path")
        path?.also {
          startInstall(mContext, it)
        }
      }
    } else if (call.method == "getInstallMarket") {
      var packageList = getInstallMarket(call.argument<List<String>>("packages"))
      result.success(packageList)
    } else if (call.method == "toMarket") {
      val marketPackageName = call.argument<String>("marketPackageName")
      val marketClassName = call.argument<String>("marketClassName")
      toMarket(mContext, marketPackageName, marketClassName)
    } else {
      result.notImplemented()
    }
  }

  /**
   * 获取app信息
   */
  fun getAppInfo(context: Context?, result: Result) {
    context?.also {
      var packageInfo = it.packageManager.getPackageInfo(it.packageName, 0)
      val map = HashMap<String, String>()
      map["packageName"] = packageInfo.packageName
      map["versionName"] = packageInfo.versionName
      map["versionCode"] = "${packageInfo.versionCode}"
      result.success(map)
    }
  }

  /**
   * 如果手机上安装多个应用市场则弹出对话框，由用户选择进入哪个市场
   */
  fun toMarket(context: Context) {
    try {
      var packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
      val uri = Uri.parse("market://details?id=${packageInfo.packageName}")
      val goToMarket = Intent(Intent.ACTION_VIEW, uri)
      goToMarket.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      context.startActivity(goToMarket)
    } catch (e: ActivityNotFoundException) {
      e.printStackTrace()
      Toast.makeText(context, "您的手机没有安装应用商店", Toast.LENGTH_SHORT).show()
    }
  }

  /**
   * 直接跳转到指定应用市场
   *
   * @param context
   * @param packageName
   */
  fun toMarket(context: Context, marketPackageName: String?, marketClassName: String?) {
    try {
      var packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
      val uri = Uri.parse("market://details?id=${packageInfo.packageName}")
      var nameEmpty = marketPackageName == null || marketPackageName.isEmpty()
      var classEmpty = marketClassName == null || marketClassName.isEmpty()
      val goToMarket = Intent(Intent.ACTION_VIEW, uri)
      if (nameEmpty || classEmpty) {
        goToMarket.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      } else {
        goToMarket.setClassName(marketPackageName!!, marketClassName!!)
      }
      context.startActivity(goToMarket)
    } catch (e: ActivityNotFoundException) {
      e.printStackTrace()
      Toast.makeText(context, "您的手机没有安装应用商店($marketPackageName)", Toast.LENGTH_SHORT).show()
    }
  }

  /**
   * 获取已安装应用商店的包名列表
   */
  fun getInstallMarket(packages: List<String>?): List<String> {
    val pkgs = ArrayList<String>()
    packages?.also {
      for (i in packages.indices) {
        if (isPackageExist(mContext, packages.get(i))) {
          pkgs.add(packages.get(i))
        }
      }
    }
    return pkgs
  }

  /**
   * 是否存在当前应用市场
   *
   */
  fun isPackageExist(context: Context, packageName: String?): Boolean {
    val manager = context.packageManager
    val intent = Intent().setPackage(packageName)
    val infos = manager.queryIntentActivities(intent,
            PackageManager.GET_INTENT_FILTERS)
    return infos.size >= 1
  }

  /**
   * 安装app，android 7.0及以上和以下方式不同
   */
  private fun startInstall(context: Context, path: String) {
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

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}

