import 'package:dynamic_theme/containers/new_view.dart';
import 'package:dynamic_theme/containers/position_exchange.dart';
import 'package:dynamic_theme/helpers/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'navigation_positioning.dart';

class Mine extends StatefulWidget {
  final Options? options;
  final Function? handleOptionsChanged;
  const Mine({
    super.key,
    this.handleOptionsChanged,
    this.options,
  });

  static Map<String, String> languageMap = {'zh': '汉语', 'en': 'English'};

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  //  路由跳转
  void _launchRouter(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/newView5',
      arguments: const NewView(
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
              final isDark = Theme.of(context).brightness == Brightness.dark;
              var language = Localizations.localeOf(context).toString();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'TEXT',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Flutter: Dynamic Theming | Change Theme At Runtime',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const ButtonColor(),
                  TextButton(
                    onPressed: () => _launchRouter(context),
                    child: Text(
                      '404',
                      style: Theme.of(context).textTheme.bodyLarge!.merge(
                            TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => widget.handleOptionsChanged!(
                      widget.options!.copyWith(
                        themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
                      ),
                    ),
                    child: Text(
                      isDark ? AppLocalizations.of(context)!.pearlWhite : AppLocalizations.of(context)!.darkNight,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (language == 'zh') {
                        widget.handleOptionsChanged!(
                          widget.options!.copyWith(locale: const Locale('en')),
                        );
                        return;
                      }
                      widget.handleOptionsChanged!(
                        widget.options!.copyWith(locale: const Locale('zh')),
                      );
                    },
                    child: Text(
                      '${AppLocalizations.of(context)!.language}${Mine.languageMap[language]}',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(NavigationPositioning.routeName),
                    child: Text(
                      '滑动定位',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(PositionExchange.routeName),
                    child: Text(
                      '拖动排图',
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

class ButtonColor extends StatefulWidget {
  const ButtonColor({super.key});
  @override
  State<ButtonColor> createState() => _ButtonColorState();
}

class _ButtonColorState extends State<ButtonColor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      color: Colors.amber,
    );
  }
}
