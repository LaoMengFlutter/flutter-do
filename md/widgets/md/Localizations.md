---
title: 'Localizations'
description: ''
type: widget
---



# Localizations

Localizations 控件用于**国际化**，也就是多语言支持。

在项目中基本不会用到这个控件，不会用到并不代表这个控件不重要，**这个控件非常重要**，只不过系统提供的**MaterialApp**已经集成了此控件，所以我们基本不会直接使用。



定义我们自己的多语言支持：

```dart
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'zh': {
      'name': '你好',
    },
    'en': {
      'name': 'Hello World',
    },
  };

  String get name {
    return _localizedValues[locale.languageCode]['name'];
  }
}
```

**_localizedValues**在实际项目中通常一种语言写在一个文件中，这里为了方便放在了一起。

定义Delegate：

```
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['zh', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
```

在**MaterialApp**下定义支持的**Delegate**，

```dart
MaterialApp(
  localizationsDelegates: [
    AppLocalizationsDelegate()
  ],
  supportedLocales: [
    const Locale('zh', 'CH'),
    const Locale('en', 'US'),
  ],
  ...
)
```

使用如下：

```dart
Text('${AppLocalizations.of(context).name}')
```

![image-20200601151303789](../img/Localizations/image-20200601151303789.png)

还可以通过Localizations获取当前系统的语言环境：

```dart
Locale myLocale = Localizations.localeOf(context);
```

