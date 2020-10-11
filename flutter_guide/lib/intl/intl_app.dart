import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

///
/// desc:
///

class IntlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}



class MyApp extends StatefulWidget {

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  static _AppSetting setting = _AppSetting();

  @override
  void initState() {
    super.initState();
    setting.changeLocale = (Locale locale) {
      setState(() {
        setting._locale = locale;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return AppLocalizations.of(context).title;
      },
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        var result = supportedLocales
            .where((element) => element.languageCode == locale.languageCode);
        if (result.isNotEmpty) {
          return locale;
        }
        return Locale('zh');
      },
      locale: setting._locale,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh'),
        const Locale('en'),
      ],
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  __HomePageState createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${AppLocalizations.of(context).title}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('中文'),
                onPressed: () {
                  MyAppState.setting.changeLocale(Locale('zh'));
                },
              ),
              RaisedButton(
                child: Text('英文'),
                onPressed: () {
                  MyAppState.setting.changeLocale(Locale('en'));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppSetting {
  _AppSetting();

  Null Function(Locale locale) changeLocale;
  Locale _locale;
}
