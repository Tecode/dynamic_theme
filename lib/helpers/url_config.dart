import 'package:flutter/foundation.dart' as foundation;

class UrlConfig {
  late String url = '';

  @override
  UrlConfig.of() {
    if (foundation.kReleaseMode) {
      url = '发布版本';
      return;
    }
    if (foundation.kDebugMode) {
      url = 'debug版本';
      return;
    }
    if (foundation.kProfileMode) {
      url = 'Profile版本';
      return;
    }
  }
}
