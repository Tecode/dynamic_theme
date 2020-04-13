import 'package:dynamic_theme/helpers/options.dart';
import 'package:dynamic_theme/helpers/scales.dart';
import 'package:dynamic_theme/helpers/themes.dart';
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
            child: Column(
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
                  onPressed: () => {print('12112')},
                  child: Text('暗黑'),
                ),
              ],
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
    );
  }
}
