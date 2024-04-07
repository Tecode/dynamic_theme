import 'package:dynamic_theme/containers/detail.dart';
import 'package:flutter/widgets.dart';

/// 路由跳转 context schemeUrl
void schemeJump(BuildContext context, String schemeUrl) {
  final jumpUri = Uri.parse(schemeUrl.replaceFirst(
    'dynamictheme://',
    'http://path/',
  ));
  switch (jumpUri.path) {
    case '/detail':
      Navigator.of(context).pushNamed(
        Detail.routeName,
        arguments: Detail(value: jumpUri.queryParameters['name'] ?? '详情'),
      );
      break;
    default:
      break;
  }
}
