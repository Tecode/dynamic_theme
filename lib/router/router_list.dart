import 'package:dynamic_theme/containers/chat_list.dart';
import 'package:dynamic_theme/containers/detail.dart';
import 'package:dynamic_theme/containers/new_view.dart';
import 'package:dynamic_theme/containers/app.dart';
import 'package:dynamic_theme/router/router_unit.dart';
import 'package:flutter/widgets.dart';

List<RouterUnit> _buildRouter() {
  final routerList = <RouterUnit>[
    RouterUnit(
      title: '首页',
      routeName: NewView.routeName,
      buildRoute: (BuildContext context) => const App(),
    ),
    RouterUnit(
      title: 'iOS跳转页面',
      routeName: NewView.routeName,
      buildRoute: (BuildContext context) => const NewView(),
    ),
    RouterUnit(
      title: '详情',
      routeName: Detail.routeName,
      buildRoute: (BuildContext context) => const Detail(),
    ),
    RouterUnit(
      title: '聊天信息',
      routeName: ChatList.routeName,
      buildRoute: (BuildContext context) => const ChatList(),
    ),
  ];
  return routerList;
}

final List<RouterUnit> routerList = _buildRouter();
