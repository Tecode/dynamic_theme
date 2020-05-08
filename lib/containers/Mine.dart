import 'package:dynamic_theme/containers/NewView.dart';
import 'package:dynamic_theme/helpers/options.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  final Options options;
  final Function handleOptionsChanged;
  Mine({
    this.handleOptionsChanged,
    this.options,
  });

  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  //  路由跳转
  void _launchRouter(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/newView5',
      arguments: NewView(
        content: '网络搜索结果汉语- 维基百科，自由的百科全书',
      ),
    );
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
                      style: Theme.of(context).textTheme.bodyText2.merge(
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
                        fontSize: 16.0,
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
