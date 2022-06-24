import 'package:flutter/material.dart';
import 'scales.dart';

class Options {
  Options({
    this.textScaleFactor,
    this.themeMode,
    this.platform,
    this.textDirection = TextDirection.ltr,
    this.timeDilation = 1.0,
    this.showOffscreenLayersCheckerboard = false,
    this.showRasterCacheImagesCheckerboard = false,
    this.showPerformanceOverlay = false,
    this.locale = const Locale('zh'),
  });

  final ThemeMode? themeMode;
  final TextScaleValue? textScaleFactor;
  final TextDirection textDirection;
  final double timeDilation;
  final TargetPlatform? platform;
  final bool showPerformanceOverlay;
  final bool showRasterCacheImagesCheckerboard;
  final bool showOffscreenLayersCheckerboard;
  final Locale locale;

  Options copyWith({
    ThemeMode? themeMode,
    TextScaleValue? textScaleFactor,
    TextDirection? textDirection,
    double? timeDilation,
    TargetPlatform? platform,
    bool? showPerformanceOverlay,
    bool? showRasterCacheImagesCheckerboard,
    bool? showOffscreenLayersCheckerboard,
    Locale? locale,
  }) {
    return Options(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
      showOffscreenLayersCheckerboard:
          showOffscreenLayersCheckerboard ?? this.showOffscreenLayersCheckerboard,
      showRasterCacheImagesCheckerboard:
          showRasterCacheImagesCheckerboard ?? this.showRasterCacheImagesCheckerboard,
      locale: locale ?? Locale('zh'),
    );
  }

  @override
  bool operator ==(other) {
    if (runtimeType != other.runtimeType) return false;
    final dynamic typedOther = other;
    return themeMode == typedOther.themeMode &&
        textScaleFactor == typedOther.textScaleFactor &&
        textDirection == typedOther.textDirection &&
        platform == typedOther.platform &&
        showPerformanceOverlay == typedOther.showPerformanceOverlay &&
        showRasterCacheImagesCheckerboard == typedOther.showRasterCacheImagesCheckerboard &&
        showOffscreenLayersCheckerboard == typedOther.showRasterCacheImagesCheckerboard;
  }

  @override
  int get hashCode => hashValues(
        themeMode,
        textScaleFactor,
        textDirection,
        timeDilation,
        platform,
        showPerformanceOverlay,
        showRasterCacheImagesCheckerboard,
        showOffscreenLayersCheckerboard,
      );

  @override
  String toString() {
    return '$runtimeType($themeMode)';
  }
}

//const double _kItemHeight = 48.0;
//const EdgeInsetsDirectional _kItemPadding =
//    EdgeInsetsDirectional.only(start: 56.0);
