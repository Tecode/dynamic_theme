import 'dart:async';
import 'dart:developer';

import 'package:dynamic_theme/containers/NewView.dart';
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

//  路由跳转

  void _launchRouter(BuildContext context) {
//    if (demo.routeName != null) {
    Timeline.instantSync('Start Transition', arguments: <String, String>{
      'from': '/',
      'to': '/newView',
    });
    Navigator.pushNamed(context, '/newView');
//    }
  }

// 配置路由
  Map<String, WidgetBuilder> _buildRoutes() {
    // For a different example of how to set up an application routing table
    // using named routes, consider the example in the Navigator class documentation:
    // https://docs.flutter.io/flutter/widgets/Navigator-class.html
    return Map<String, WidgetBuilder>.fromIterable(
      routerList,
      key: (dynamic data) => '${data.routeName}',
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
      home: Scaffold(
        body: SizedBox(
          child: Center(
            child: Builder(
              builder: (BuildContext context) {
                final bool isDark =
                    Theme.of(context).brightness == Brightness.dark;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'TEXT',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Text(
                      'Flutter: Dynamic Theming | Change Theme At Runtime',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    FlatButton(
                      onPressed: () => _launchRouter(context),
                      child: Text(
                        '路由跳转',
                        style: Theme.of(context).textTheme.body1.merge(
                              TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () => _handleOptionsChanged(
                        _options.copyWith(
                          themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
                        ),
                      ),
                      child: Text(
                        isDark ? '珍珠白' : '暗夜黑',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
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
