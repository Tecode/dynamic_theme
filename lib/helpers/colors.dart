import 'package:flutter/material.dart';

class ColorTheme {
  Color borderColor;
  Color cubeColor;
  Color activeNavColor;
  Color navBarColor;
  Color colorF3F3F6;
  Color color202326;

  ColorTheme.of(BuildContext context) {
//  暗黑色
    if (Theme.of(context).brightness == Brightness.dark) {
      borderColor = Color(0xfff161617);
      cubeColor = Colors.white70;
      activeNavColor = Colors.brown;
      navBarColor = Color(0xff161616);
      colorF3F3F6 = Color(0xff18191b);
      color202326 = Color(0xff4e5156);
      return;
    }
//    明亮色
    borderColor = Color(0xffdedede);
    cubeColor = Colors.black38;
    activeNavColor = Colors.amberAccent;
    navBarColor = Colors.white;
    colorF3F3F6 = Color(0xffF3F3F6);
    color202326 = Color(0xff202326);
  }
}
