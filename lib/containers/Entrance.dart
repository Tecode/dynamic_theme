import 'package:dynamic_theme/containers/Discovery.dart';
import 'package:dynamic_theme/containers/Home.dart';
import 'package:dynamic_theme/containers/Mine.dart';
import 'package:dynamic_theme/helpers/options.dart';
import 'package:dynamic_theme/widgets/Entrance/NavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
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
