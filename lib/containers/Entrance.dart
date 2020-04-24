import 'dart:developer';

import 'package:dynamic_theme/helpers/options.dart';
import 'package:dynamic_theme/widgets/Entrance/NavigationBar.dart';
import 'package:flutter/material.dart';

import 'NewView.dart';

class Entrance extends StatefulWidget {
  final Options options;
  final Function handleOptionsChanged;
  Entrance({
    this.handleOptionsChanged,
    this.options,
  });
  static String routeName = '/';

  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  //  路由跳转
  void _launchRouter(BuildContext context) {
    Timeline.instantSync('Start Transition', arguments: <String, String>{
      'from': '/',
      'to': '/newView',
    });
    Navigator.pushNamed(
      context,
      '/newView',
      arguments: NewView(
        content: '网络搜索结果汉语- 维基百科，自由的百科全书',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: () => widget.handleOptionsChanged(
                      widget.options.copyWith(
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
      bottomNavigationBar: NavigationBar(),
    );
  }
}
