import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guide/navigator/a_page.dart';
import 'package:guide/navigator/route_observer_demo.dart';
import 'package:guide/widgets/button/button_case.dart';
import 'package:guide/widgets/button/button_demo.dart';
import 'package:guide/widgets/button/draw_board.dart';
import 'package:guide/widgets/button/dropdown_demo.dart';
import 'package:guide/widgets/button/gesturedetector_demo.dart';
import 'package:guide/widgets/calculator/calculator.dart';
import 'package:guide/widgets/image/case_demo.dart';
import 'package:guide/widgets/image/icon_demo.dart';
import 'package:guide/widgets/image/image_demo.dart';
import 'package:guide/widgets/layout/flow_circle.dart';
import 'package:guide/widgets/layout/flow_demo.dart';
import 'package:guide/widgets/layout/flow_menu.dart';
import 'package:guide/widgets/layout/indexedstack_demo.dart';
import 'package:guide/widgets/layout/personal_demo.dart';
import 'package:guide/widgets/layout/row_column_demo.dart';
import 'package:guide/widgets/layout/stack_demo.dart';
import 'package:guide/widgets/layout/wrap_demo.dart';
import 'package:guide/widgets/scrollable/custom_scroll_physics.dart';
import 'package:guide/widgets/scrollable/listview_demo.dart';
import 'package:guide/widgets/scrollable/scrollbar_case.dart';
import 'package:guide/widgets/single/aspect_ratio_demo.dart';
import 'package:guide/widgets/single/container_demo.dart';
import 'package:guide/widgets/single/fractionally_demo.dart';
import 'package:guide/widgets/single/setting_demo.dart';
import 'package:guide/widgets/single/size_box_demo.dart';
import 'package:guide/widgets/text/case_demo.dart';
import 'package:guide/widgets/text/rich_text_demo.dart';
import 'package:guide/widgets/text/text_demo.dart';

import 'animation/CircleProgress.dart';
import 'animation/animated_builder_demo.dart';
import 'animation/animated_widget_demo.dart';
import 'animation/animation_1.dart';
import 'animation/animations_demo.dart';
import 'animation/circle_animation.dart';
import 'animation/container_animations.dart';
import 'animation/curve_demo.dart';
import 'animation/custom_curve.dart';
import 'animation/fade_scale_transition.dart';
import 'animation/fade_through_transition.dart';
import 'animation/flip_animation_demo.dart';
import 'animation/flip_up.dart';
import 'animation/ios_health.dart';
import 'animation/multi_controller.dart';
import 'animation/navigation_animation.dart';
import 'animation/radar.dart';
import 'animation/shadermask.dart';
import 'animation/share_axis_demo.dart';
import 'animation/demo.dart';
import 'animation/transform_demo.dart';
import 'animation/tween_demo.dart';
import 'animation/water_ripple_page.dart';
import 'home_page.dart';
import 'http/dio_demo.dart';
import 'http/http_client_demo.dart';
import 'http/http_plugin_demo.dart';
import 'http/json_model.dart';
import 'intl/intl_app.dart';
import 'mixing/basic_message_channel_demo.dart';
import 'mixing/event_channel_demo.dart';
import 'mixing/methodchannel_demo.dart';
import 'mixing/platform_view_demo.dart';
import 'navigator/b_page.dart';
import 'navigator/c_page.dart';
import 'navigator/d_page.dart';
import 'navigator/my_route_observer.dart';
import 'navigator/route_observer_demo_1.dart';
import 'storage/path_provider_demo.dart';
import 'storage/sqlite/data_base_demo.dart';
import 'widgets/functional/cupertino_date_picker_demo.dart';
import 'widgets/functional/date_picker_demo.dart';
import 'widgets/functional/draggable_demo.dart';
import 'widgets/functional/interactive_view_demo1.dart';
import 'widgets/functional/interactive_view_demo2.dart';
import 'widgets/functional/interactive_viewer_demo.dart';
import 'widgets/functional/slider_demo.dart';
import 'widgets/functional/time_picker_demo.dart';

void main() {
  runApp(IntlApp());
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

MyRouteObserver<PageRoute> myRouteObserver = MyRouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh'),
        const Locale('en'),
      ],
//      theme: ThemeData.from(
//        colorScheme: const ColorScheme.light(),
//      ).copyWith(
//        pageTransitionsTheme: const PageTransitionsTheme(
//          builders: <TargetPlatform, PageTransitionsBuilder>{
//            TargetPlatform.android: ZoomPageTransitionsBuilder(),
//            TargetPlatform.iOS:ZoomPageTransitionsBuilder()
//          },
//        ),
//      ),
      routes: <String, WidgetBuilder>{
        '/A': (context) => APage(),
        '/B': (context) => BPage(),
        '/C': (context) => CPage(),
        '/D': (context) => DPage(),
        '/ARouteObserver': (context) => ARouteObserverDemo(),
        '/BRouteObserver': (context) => BRouteObserverDemo(),
      },
      navigatorObservers: [myRouteObserver],
//      initialRoute: '/A',
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());

//            SystemChannels.textInput.invokeMethod(
//                'TextInput.hide');

//            FocusScopeNode currentFocus = FocusScope.of(context);
//            if (!currentFocus.hasPrimaryFocus &&
//                currentFocus.focusedChild != null) {
//              FocusManager.instance.primaryFocus.unfocus();
//            }
          },
          child: child,
        ),
      ),
      home: IntlApp(),
    );
  }
}

class DismissKeyboardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      onDoubleTap:(){
//        print('onDoubleTap');
//      } ,
      onTap: () {
        print('onTap');
      },
      onTapDown: (v) {
        print('onTapDown');
      },
      onTapUp: (v) {
        print('onTapUp');
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print('onPressed');
              },
            )
          ],
        ),
        body: Center(
          child: TextField(),
        ),
      ),
    );
  }
}
