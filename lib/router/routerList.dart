import 'package:dynamic_theme/containers/NewView.dart';
import 'package:dynamic_theme/router/routerUnit.dart';
import 'package:flutter/material.dart';

List<RouterUnit> _buildRouter() {
  final List<RouterUnit> routerList = <RouterUnit>[
    // Demos
    RouterUnit(
      title: 'Shrine',
      subtitle: 'Basic shopping app',
      category: kDemos,
      routeName: NewView.routeName,
      buildRoute: (BuildContext context) => const NewView(),
    ),
  ];
  return routerList;
}


final List<RouterUnit> routerList = _buildRouter();