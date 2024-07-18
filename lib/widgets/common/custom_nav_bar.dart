import 'package:dynamic_theme/containers/app.dart';
import 'package:flutter/cupertino.dart';

import 'nav_back_button.dart';

class CustomNavigationBar extends CupertinoNavigationBar {
  final String title;
  final VoidCallback? onTap;
  CustomNavigationBar(this.title, {super.key, super.transitionBetweenRoutes, super.border, this.onTap})
      : super(
          middle: Text(title),
          padding: const EdgeInsetsDirectional.only(end: 20.0),
          leading: NavBackButton(onTap: onTap ?? () => Navigator.maybePop(App.materialKey.currentContext!)),
        );
}
