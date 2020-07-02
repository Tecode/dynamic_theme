import 'package:flutter/material.dart';

@immutable
class CustomColors {
  /// 边框颜色
  final Color borderColor;
  final Color cubeColor;
  final Color activeNavColor;
  final Color navBarColor;
  final Color colorF3F3F6;
  final Color color202326;

  CustomColors({
    this.borderColor,
    this.cubeColor,
    this.activeNavColor,
    this.navBarColor,
    this.colorF3F3F6,
    this.color202326,
  });

  static CustomColors of(BuildContext context) {
//  暗黑色
    if (Theme.of(context).brightness == Brightness.dark) {
      return CustomColors(
        borderColor: Color(0xfff161617),
        cubeColor: Colors.white70,
        activeNavColor: Colors.brown,
        navBarColor: Color(0xff161616),
        colorF3F3F6: Color(0xff18191b),
        color202326: Color(0xff4e5156),
      );
    }
//    明亮色
    return CustomColors(
      borderColor: Color(0xffdedede),
      cubeColor: Colors.black38,
      activeNavColor: Colors.amberAccent,
      navBarColor: Colors.white,
      colorF3F3F6: Color(0xffF3F3F6),
      color202326: Color(0xff202326),
    );
  }
}
