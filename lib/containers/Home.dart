import 'dart:developer';

import 'package:dynamic_theme/containers/NewView.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //  路由跳转
  void _launchRouter(BuildContext context) {
    Timeline.instantSync('Start Transition', arguments: <String, String>{
      'from': '/',
      'to': '/newView',
    });
    Navigator.of(context).pushNamed(
      '/newView',
      arguments: NewView(
        content: '网络搜索结果汉语- 维基百科，自由的百科全书',
      ),
    ).then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
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
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Flutter: Dynamic Theming | Change Theme At Runtime',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  FlatButton(
                    onPressed: () => _launchRouter(context),
                    child: Text(
                      '路由跳转',
                      style: Theme.of(context).textTheme.bodyText1.merge(
                            TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
