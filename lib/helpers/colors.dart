import 'package:flutter/material.dart';

@immutable
class CustomColors {
  /// 边框颜色
  final Color borderColor;
  final Color cubeColor;
  final Color activeNavColor;
  final Color navBarColor;
  CustomColors({
    this.borderColor,
    this.cubeColor,
    this.activeNavColor,
    this.navBarColor,
  });

  static CustomColors of(BuildContext context) {
//  暗黑色
    if (Theme.of(context).brightness == Brightness.dark) {
      return CustomColors(
        borderColor: Color(0xfff161617),
        cubeColor: Colors.white70,
        activeNavColor: Colors.brown,
        navBarColor: Color(0xff161616),
      );
    }
//    明亮色
    return CustomColors(
        borderColor: Color(0xffdedede),
        cubeColor: Colors.black38,
        activeNavColor: Colors.amberAccent,
        navBarColor: Colors.white);
  }
}
