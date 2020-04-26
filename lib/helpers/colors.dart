import 'package:flutter/material.dart';

@immutable
class CustomColors {
  /// 边框颜色
  final Color borderColor;
  final Color cubeColor;
  CustomColors({
    this.borderColor,
    this.cubeColor,
  });

  static CustomColors of(BuildContext context) {
//  暗黑色
    if (Theme.of(context).brightness == Brightness.dark) {
      return CustomColors(
        borderColor: Color(0xfff2c2e33),
        cubeColor: Colors.white70,
      );
    }
//    明亮色
    return CustomColors(
      borderColor: Color(0xffdedede),
      cubeColor: Colors.black38,
    );
  }
}
