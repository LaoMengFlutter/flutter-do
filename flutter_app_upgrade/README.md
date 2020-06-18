
> 官网地址：[http://laomengit.com/plugin/upgrade.html](http://laomengit.com/plugin/upgrade.html)

# 添加依赖

1、在`pubspec.yaml`中加入：

```
dependencies:
  flutter_app_upgrade: ^1.1.0
```

2、执行flutter命令获取包：
```
flutter pub get`
```

3、引入

```
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

```

4、如果你需要支持Android平台，在`./android/app/src/main/AndroidManifest.xml`文件中配置`provider`，代码如下：

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.flutter.laomeng.flutter_upgrade_example">
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:icon="@mipmap/ic_launcher"
        android:label="flutter_upgrade_example">
				...
        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="com.flutter.laomeng.flutter_upgrade_example.fileprovider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                tools:replace="android:resource"
                android:resource="@xml/file_paths" />
        </provider>
    </application>
</manifest>
```

>  注意：provider中authorities的值为当前App的包名，和顶部的package值保持一致。



## App升级功能使用介绍



只需在主页的`initState`方法中调用升级检测方法：

```dart
@override
  void initState() {
    AppUpgrade.appUpgrade(
      context,
      _checkAppInfo(),
      iosAppId: 'id88888888',
    );
    super.initState();
  }
```

`_checkAppInfo`方法访问后台接口获取是否有新的版本的信息，返回`Future<AppUpgradeInfo>` 类型，`AppUpgradeInfo`包含title、升级内容、apk下载url、是否强制升级等版本信息。如果没有新的版本不返回即可。

`iosAppId`参数用于跳转到app store。

`_checkAppInfo()`方法通常是访问后台接口，这里直接返回新版本信息，代码如下：

```dart
 Future<AppUpgradeInfo> _checkAppInfo() async {
    //这里一般访问网络接口，将返回的数据解析成如下格式
    return Future.delayed(Duration(seconds: 1), () {
      return AppUpgradeInfo(
        title: '新版本V1.1.1',
        contents: [
          '1、支持立体声蓝牙耳机，同时改善配对性能',
          '2、提供屏幕虚拟键盘',
          '3、更简洁更流畅，使用起来更快',
          '4、修复一些软件在使用时自动退出bug',
          '5、新增加了分类查看功能'
        ],
        force: false,
      );
    });
  }
```

好了，基本的升级功能就完成了，弹出提示框的效果如下：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_3.png)

点击“以后再说”，提示框消失，点击“立即体验”，自动区分不同平台。

访问后台接口获取新版本的信息一般需要当前App的包名和版本，查询方法如下：

```dart
await FlutterUpgrade.appInfo
```

返回的类型是`AppInfo`：

- versionName：版本号，比如1.0.0。
- versionCode：Android独有版本号，对应Android build.gradle中的versionCode，ios返回“0”。
- packageName：包名，对应Android build.gradle中的applicationId，ios的BundleIdentifier。

### iOS平台升级

iOS平台直接跳转到app store相关页面，`iosAppId`一定要设置对，否则app store会找不到应用程序。

### Android平台下载apk

Android平台则会判断是否设置了apk下载url，如果设置了则下载apk则直接下载，效果如下：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_4.gif)

当下载完成时直接跳转到apk安装引导界面，效果如下：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_5.png)

用户点击允许，出现如下界面：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_6.png)

点击继续安装即可，上面的安装引导界面是系统界面，不同的手机或者不同的Android版本会略有不同。



### Android平台跳转应用市场

如果不提供apk下载地址，点击“立即体验”，则会跳转到应用市场，不指定应用市场则会弹出提示框，让用户选择应用市场，效果如下：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_7.png)

提示框内将会包含手机内安装的所有的应用市场，用户选择一个然后跳转到对应应用市场的详情界面，如果当前应用未在此市场上架则会出现“找不到的界面”。

通常情况下会指定应用市场，这就需要知道用户手机内安装的应用市场，查询方法如下：

```dart
_getInstallMarket() async {
  List<String> marketList = await FlutterUpgrade.getInstallMarket();
}
```

插件内置了国内常用的应用市场，包括小米、魅族、vivo、oppo、华为、zte、360助手、应用宝、pp助手、豌豆荚，如果你需要检测其他的应用市场，比如google play，只需添加googl play的包名即可：

```dart
_getInstallMarket() async {
  List<String> marketList = await FlutterUpgrade.getInstallMarket(marketPackageNames: ['google play 包名']);
}
```

方法返回手机安装的应用市场，根据安装的应用市场指定跳转应用市场，如果你要指定内置的应用市场，可以根据包名获取内置的应用市场的相关信息：

```dart
AppMarketInfo _marketInfo = AppMarket.getBuildInMarket(packageName);
```

指定华为应用市场：

```dart
AppUpgrade.appUpgrade(
  context,
  _checkAppInfo(),
  iosAppId: 'id88888888',
  appMarketInfo: AppMarket.huaWei
);
```

指定没有内置的应用市场方法如下：

```dart
AppUpgrade.appUpgrade(
  context,
  _checkAppInfo(),
  iosAppId: 'id88888888',
  appMarketInfo: AppMarketInfo(
    '应用市场名称（选填）','应用市场包名','应用市场类名'
  ),
);
```



### 用户行为和下载回调

新的版本（1.1.0）新增了**取消** 和**立即更新**回调，用法如下：

```dart
AppUpgrade.appUpgrade(
  context,
  _checkAppInfo(),
  cancelText: '以后再说',
  okText: '马上升级',
  iosAppId: 'id88888888',
  appMarketInfo: AppMarket.huaWei,
  onCancel: () {
    print('onCancel');
  },
  onOk: () {
    print('onOk');
  },
  
);
```

新增的**下载进度**和**下载状态变化**回调，用法如下：

```dart
AppUpgrade.appUpgrade(
  context,
  _checkAppInfo(),
  cancelText: '以后再说',
  okText: '马上升级',
  iosAppId: 'id88888888',
  appMarketInfo: AppMarket.huaWei,
  downloadProgress: (count, total) {
    print('count:$count,total:$total');
  },
  downloadStatusChange: (DownloadStatus status, {dynamic error}) {
    print('status:$status,error:$error');
  },
);
```



## 提示框样式定制

如果默认的升级提示框不满足你的需求，那么你可以定制你的升级提示框。

title及升级内容文字样式设置：

```dart
AppUpgrade.appUpgrade(context, _checkAppInfo(),
    titleStyle: TextStyle(fontSize: 30),
    contentStyle: TextStyle(fontSize: 18),
    ...
)
```

通过`titleStyle`和`contentStyle`设置其样式，可以设置字体大小、颜色、粗体等。

设置“取消”和“升级按钮”文本和样式：

```dart
AppUpgrade.appUpgrade(context, _checkAppInfo(),
    cancelText: '以后再说',
    cancelTextStyle: TextStyle(color: Colors.grey),
    okText: '马上升级',
    okTextStyle: TextStyle(color: Colors.red),
	...
)
```

默认“取消”按钮文本是"以后再说"，默认“升级”按钮的文本是“立即体验”。

设置“升级”按钮的背景颜色，需要2种颜色，2种颜色左到右线性渐变，如果想设置纯色，只需将2种颜色设置为同一个颜色即可，默认颜色是系统的`primaryColor`:

```dart
AppUpgrade.appUpgrade(context, _checkAppInfo(),
    okBackgroundColors: [Colors.blue, Colors.lightBlue],
    ...
)
```

设置进度条的颜色：

```dart
AppUpgrade.appUpgrade(context, _checkAppInfo(),
    progressBarColor: Colors.lightBlue.withOpacity(.4),
    ...
)
```

设置升级提示框的圆角半径，默认是20：

```dart
AppUpgrade.appUpgrade(context, _checkAppInfo(),
    borderRadius: 15,
    ...
)
```





## Flutter App 升级功能流程

应用程序升级功能是App的基础功能之一，如果没有此功能会造成用户无法升级，应用程序的bug或者新功能老用户无法触达，甚至损失这部分用户。


对于应用程序升级功能的重要性就无需赘言了，下面介绍下应用程序升级功能的几种方式，从平台方面来说：

- IOS平台，应用程序升级功能只能通过跳转到app store进行升级。
- Android平台，既可以通过跳转到应用市场进行升级，也可以下载apk包升级。

从强制性来说可以分别强制升级和非强制升级：

- 强制升级：就是用户必须升级才能继续使用App，如果不是非常必要不建议使用如此强硬的方式，会造成用户的反感。
- 非强制升级就是允许用户点击“取消”，继续使用App。



下面分别介绍IOS和Android升级流程。

## IOS升级流程

IOS升级流程如下：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_1.png)

流程说明：

1. 通常我们会访问后台接口获取是否有新的版本，如果有新的版本则弹出提示框，判断当前版本是否为“强制升级”，如果是则只提供用户一个“升级”的按钮，否则提供用户“升级”和“取消”按钮。
2. 弹出提示框后用户选择是否升级，如果选择“取消”，提示框消失，如果选择“升级”，跳转到app store进行升级。



## Android 升级流程

相比ios的升级过程，Android就稍显复杂了，流程图如下：

![](https://github.com/781238222/imgs/raw/master/flutter_upgrade/app_upgrade_2.png)

流程说明：

1. 访问后台接口获取是否有新的版本，这里和IOS是一样的，有则弹出升级提示框，判断当前版本是否为“强制升级”，如果是则只提供用户一个“升级”的按钮，否则提供用户“升级”和“取消”按钮。
2. 弹出提示框后有用户选择是否升级，如果选择“取消”，提示框消失，如果选择“升级”，判断是跳转到应用市场进行升级还是通过下载apk升级。
3. 如果下载apk升级，则开始下载apk，下载完成后跳转到apk安装引导界面。
4. 如果跳转到应用市场升级，判断是否指定了应用市场，比如只在华为应用市场上架了，那么此时需要指定跳转到华为应用市场，即使你在很多应用市场都上架了，也应该根据用户手机安装的应用市场指定一个应用市场，让用户选择应用市场不是一个好的体验，而且用户也不知道应该去哪个市场更新，如果用户选择了一个你没有上架的应用市场，那就更尴尬了。
5. 指定应用市场后直接跳转到指定的应用市场的更新界面。

