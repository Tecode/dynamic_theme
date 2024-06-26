import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

@immutable
class TextThemeStyle with Diagnosticable {
  final TextStyle? font17;
  final TextStyle? fontBold17;
  final TextStyle? font16;
  final TextStyle? fontBold16;
  final TextStyle? font14;
  final TextStyle? font12;

  const TextThemeStyle({
    this.font17,
    this.fontBold17,
    this.font16,
    this.fontBold16,
    this.font14,
    this.font12,
  });

  // ignore: prefer_constructors_over_static_methods
  static TextThemeStyle of(BuildContext context) {
//    final String _fontFamilyDisplay =
//        Platform.isIOS ? '.SF UI Display' : 'Roboto';
    final fontFamily = Platform.isIOS ? '.SF UI Text' : 'Roboto';
    final fontWeight = Platform.isIOS ? FontWeight.w500 : FontWeight.w600;
    const lineHeight = 1.2;

    return TextThemeStyle(
      font17: TextStyle(
        fontSize: 17.0,
        color: ColorTheme.of(context).color202326,
        fontFamily: fontFamily,
        height: lineHeight,
      ),
      fontBold17: TextStyle(
        fontSize: 17.0,
        color: ColorTheme.of(context).color202326,
        fontFamily: fontFamily,
        height: lineHeight,
        fontWeight: fontWeight,
      ),
      font16: TextStyle(
        fontSize: 16.0,
        color: ColorTheme.of(context).color202326,
        fontFamily: fontFamily,
        height: lineHeight,
      ),
      fontBold16: TextStyle(
        fontSize: 16.0,
        color: ColorTheme.of(context).color202326,
        fontFamily: fontFamily,
        height: lineHeight,
        fontWeight: fontWeight,
      ),
      font14: TextStyle(
        fontSize: 14.0,
        color: ColorTheme.of(context).color202326,
        fontFamily: fontFamily,
        height: lineHeight,
      ),
      font12: TextStyle(
        fontSize: 12.0,
        color: ColorTheme.of(context).color202326,
        fontFamily: fontFamily,
        height: lineHeight,
      ),
    );
  }
}
