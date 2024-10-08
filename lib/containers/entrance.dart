import 'dart:async';

import 'package:dynamic_theme/containers/discovery.dart';
import 'package:dynamic_theme/containers/home.dart';
import 'package:dynamic_theme/containers/mine.dart';
import 'package:dynamic_theme/containers/order.dart';
import 'package:dynamic_theme/helpers/helpers.dart';
import 'package:dynamic_theme/helpers/options.dart';
import 'package:dynamic_theme/widgets/Entrance/navigation_bar.dart' as nav;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uni_links/uni_links.dart';

import 'app.dart';

enum UniLinksType { string, uri }

class Entrance extends StatefulWidget {
  final Options? options;
  final Function handleOptionsChanged;
  const Entrance({
    required this.handleOptionsChanged,
    super.key,
    this.options,
  });
  static String routeName = '/';

//  路由页面
  static List<Map<String, dynamic>> get navList => [
        {'value': AppLocalizations.of(App.materialKey.currentContext!)!.message, 'key': 'HOME'},
        {'value': AppLocalizations.of(App.materialKey.currentContext!)!.discover, 'key': 'DISCOVERY'},
        {'value': AppLocalizations.of(App.materialKey.currentContext!)!.order, 'key': 'ORDER'},
        {'value': AppLocalizations.of(App.materialKey.currentContext!)!.function, 'key': 'MINE'},
      ];

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  int activeIndex = 0;
  final UniLinksType _type = UniLinksType.string;
  late StreamSubscription _sub;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: activeIndex);
    //  scheme初始化，保证有上下文，需要跳转页面
    initPlatformState();
  }

  ///  初始化Scheme只使用了String类型的路由跳转
  // ignore: comment_references
  ///  所以只有一个有需求可以使用[initPlatformStateForUriUniLinks]
  Future<void> initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    }
  }

  /// 使用[String]链接实现
  Future<void> initPlatformStateForStringUniLinks() async {
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink() ?? '';
      debugPrint('initial link: $initialLink');
      debugPrint('initialLink--$initialLink');
      //  跳转到指定页面
      if (mounted) {
        schemeJump(context, initialLink);
      }
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
    // Attach a listener to the links stream
    // _sub = getLinksStream().listen((String link) {
    //   if (!mounted) return;
    //   print('link--$link');
    //   //  跳转到指定页面
    //   schemeJump(context, link);
    // }, onError: (Object err) {
    //   if (!mounted) return;
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  const Home(),
                  const Discovery(),
                  const Order(),
                  Mine(
                    options: widget.options ?? Options(),
                    handleOptionsChanged: widget.handleOptionsChanged,
                  ),
                ],
              ),
            ),
            nav.NavigationBar(
              activeKey: Entrance.navList[activeIndex]['key'] as String,
              onChange: (int index) => setState(() {
                activeIndex = index;
                controller.jumpToPage(index);
              }),
            ),
          ],
        ),
      );
}
