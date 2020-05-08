import 'dart:async';

import 'package:dynamic_theme/containers/Entrance.dart';
import 'package:dynamic_theme/helpers/options.dart';
import 'package:dynamic_theme/helpers/scales.dart';
import 'package:dynamic_theme/helpers/themes.dart';
import 'package:dynamic_theme/router/routerList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

class DynamicTheme extends StatefulWidget {
  const DynamicTheme();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Options _options;
  Timer _timeDilationTimer;

  @override
  void initState() {
    super.initState();
    _options = Options(
      themeMode: ThemeMode.system,
      textScaleFactor: textScaleValues[0],
      timeDilation: timeDilation,
      platform: defaultTargetPlatform,
    );
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

// 配置路由
  Map<String, WidgetBuilder> _buildRoutes() {
    // For a different example of how to set up an application routing table
    // using named routes, consider the example in the Navigator class documentation:
    // https://docs.flutter.io/flutter/widgets/Navigator-class.html
    return Map<String, WidgetBuilder>.fromIterable(
      routerList,
      key: (dynamic data) => data.routeName,
      value: (dynamic data) => data.buildRoute,
    );
  }

//  修改页面参数（例如字体大小、主题颜色）
  void _handleOptionsChanged(Options newOptions) {
    setState(() {
      if (_options.timeDilation != newOptions.timeDilation) {
        _timeDilationTimer?.cancel();
        _timeDilationTimer = null;
        if (newOptions.timeDilation > 1.0) {
          // We delay the time dilation change long enough that the user can see
          // that UI has started reacting and then we slam on the brakes so that
          // they see that the time is in fact now dilated.
          _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
            timeDilation = newOptions.timeDilation;
          });
        } else {
          timeDilation = newOptions.timeDilation;
        }
      }
      _options = newOptions;
    });
  }

// 文字缩放
  Widget _applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _options.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Theme',
      theme: lightTheme.copyWith(platform: _options.platform),
      darkTheme: darkTheme.copyWith(platform: _options.platform),
      themeMode: _options.themeMode,
      onGenerateRoute: (_) {
        //  当通过Navigation.of(context).pushNamed跳转路由时，
        //  在routes查找不到时，会调用该方法
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) {
            //这里为返回的Widget
            return Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('404', style: Theme.of(context).textTheme.headline4),
                  CupertinoButton(
                    child: Text('Back'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            );
          },
          opaque: false,
          transitionDuration: Duration(milliseconds: 200),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) =>
                  FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          ),
        );
      },
      navigatorObservers: [DynamicTheme.routeObserver],
      home: Entrance(
        options: _options,
        handleOptionsChanged: _handleOptionsChanged,
      ),
      builder: (BuildContext context, Widget child) {
        return _applyTextScaleFactor(
          // Specifically use a blank Cupertino theme here and do not transfer
          // over the Material primary color etc except the brightness to
          // showcase standard iOS looks.
          Builder(builder: (BuildContext context) {
            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Theme.of(context).brightness,
              ),
              child: child,
            );
          }),
        );
      },
      routes: _buildRoutes(),
    );
  }
}
