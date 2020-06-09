import 'package:dynamic_theme/containers/Detail.dart';
import 'package:flutter/widgets.dart';

/// 路由跳转 context schemeUrl
void schemeJump(BuildContext context, String schemeUrl) {
  final Uri _jumpUri = Uri.parse(schemeUrl.replaceFirst(
    'dynamictheme://',
    'http://path/',
  ));
  switch (_jumpUri.path) {
    case '/detail':
      Navigator.of(context).pushNamed(
        Detail.routeName,
        arguments: Detail(value: _jumpUri.queryParameters['name'] ?? '详情'),
      );
      break;
    default:
      break;
  }
}
