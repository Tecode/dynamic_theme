import 'package:dynamic_theme/containers/NewView.dart';
import 'package:dynamic_theme/containers/app.dart';
import 'package:dynamic_theme/router/routerUnit.dart';
import 'package:flutter/material.dart';

List<RouterUnit> _buildRouter() {
  final List<RouterUnit> routerList = <RouterUnit>[
    RouterUnit(
      title: '首页',
      subtitle: '首页',
      category: kDemos,
      routeName: NewView.routeName,
      buildRoute: (BuildContext context) => const DynamicTheme(),
    ),
    RouterUnit(
      title: 'iOS跳转页面',
      subtitle: 'iOS跳转页面',
      category: kDemos,
      routeName: NewView.routeName,
      buildRoute: (BuildContext context) => const NewView(),
    ),
  ];
  return routerList;
}

final List<RouterUnit> routerList = _buildRouter();
