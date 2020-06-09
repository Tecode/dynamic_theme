import 'dart:async';

import 'package:dynamic_theme/containers/Discovery.dart';
import 'package:dynamic_theme/containers/Home.dart';
import 'package:dynamic_theme/containers/Mine.dart';
import 'package:dynamic_theme/helpers/helpers.dart';
import 'package:dynamic_theme/helpers/options.dart';
import 'package:dynamic_theme/widgets/Entrance/NavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

enum UniLinksType { string, uri }

class Entrance extends StatefulWidget {
  final Options options;
  final Function handleOptionsChanged;
  Entrance({
    this.handleOptionsChanged,
    this.options,
  });
  static String routeName = '/';

//  路由页面
  static List<Map<String, dynamic>> get navList {
    return [
      {'value': '首页', 'key': 'HOME'},
      {'value': '发现', 'key': 'DISCOVERY'},
      {'value': '订单', 'key': 'ORDER'},
      {'value': '我的', 'key': 'MINE'},
    ];
  }

  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  int activeIndex = 0;
  UniLinksType _type = UniLinksType.string;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    //  scheme初始化，保证有上下文，需要跳转页面
    initPlatformState();
  }

  ///  初始化Scheme只使用了String类型的路由跳转
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
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) {
        print('initialLink--$initialLink');
        //  跳转到指定页面
        schemeJump(context, initialLink);
      }
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
    // Attach a listener to the links stream
    _sub = getLinksStream().listen((String link) {
      if (!mounted || link == null) return;
      print('link--$link');
      //  跳转到指定页面
      schemeJump(context, link);
    }, onError: (Object err) {
      if (!mounted) return;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: IndexedStack(
              index: activeIndex,
              children: <Widget>[
                Home(),
                Discovery(),
                Discovery(),
                Mine(
                  options: widget.options,
                  handleOptionsChanged: widget.handleOptionsChanged,
                ),
              ],
            ),
          ),
          NavigationBar(
            activeKey: Entrance.navList[activeIndex]['key'],
            onChange: (int index) => setState(() {
              activeIndex = index;
            }),
          ),
        ],
      ),
    );
  }
}
