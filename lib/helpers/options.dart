import 'package:flutter/material.dart';

import 'scales.dart';

class GalleryOptions {
  GalleryOptions({
    this.themeMode,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.timeDilation = 1.0,
    this.platform,
    this.showOffscreenLayersCheckerboard = false,
    this.showRasterCacheImagesCheckerboard = false,
    this.showPerformanceOverlay = false,
  });

  final ThemeMode themeMode;
  final GalleryTextScaleValue textScaleFactor;
  final TextDirection textDirection;
  final double timeDilation;
  final TargetPlatform platform;
  final bool showPerformanceOverlay;
  final bool showRasterCacheImagesCheckerboard;
  final bool showOffscreenLayersCheckerboard;

  GalleryOptions copyWith({
    ThemeMode themeMode,
    GalleryTextScaleValue textScaleFactor,
    TextDirection textDirection,
    double timeDilation,
    TargetPlatform platform,
    bool showPerformanceOverlay,
    bool showRasterCacheImagesCheckerboard,
    bool showOffscreenLayersCheckerboard,
  }) {
    return GalleryOptions(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      showPerformanceOverlay:
          showPerformanceOverlay ?? this.showPerformanceOverlay,
      showOffscreenLayersCheckerboard: showOffscreenLayersCheckerboard ??
          this.showOffscreenLayersCheckerboard,
      showRasterCacheImagesCheckerboard: showRasterCacheImagesCheckerboard ??
          this.showRasterCacheImagesCheckerboard,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final GalleryOptions typedOther = other;
    return themeMode == typedOther.themeMode &&
        textScaleFactor == typedOther.textScaleFactor &&
        textDirection == typedOther.textDirection &&
        platform == typedOther.platform &&
        showPerformanceOverlay == typedOther.showPerformanceOverlay &&
        showRasterCacheImagesCheckerboard ==
            typedOther.showRasterCacheImagesCheckerboard &&
        showOffscreenLayersCheckerboard ==
            typedOther.showRasterCacheImagesCheckerboard;
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

const double _kItemHeight = 48.0;
const EdgeInsetsDirectional _kItemPadding =
    EdgeInsetsDirectional.only(start: 56.0);

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(minHeight: _kItemHeight * textScaleFactor),
        padding: _kItemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _BooleanItem extends StatelessWidget {
  const _BooleanItem(this.title, this.value, this.onChanged, {this.switchKey});

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  // [switchKey] is used for accessing the switch from driver tests.
  final Key switchKey;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Switch(
            key: switchKey,
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF39CEFD),
            activeTrackColor: isDark ? Colors.white30 : Colors.black26,
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(this.text, this.onTap);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: _FlatButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

class _FlatButton extends StatelessWidget {
  const _FlatButton({Key key, this.onPressed, this.child}) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: Theme.of(context).primaryTextTheme.subhead,
        child: child,
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return _OptionsItem(
      child: DefaultTextStyle(
        style: theme.textTheme.body1.copyWith(
          fontFamily: 'GoogleSans',
          color: theme.accentColor,
        ),
        child: Semantics(
          child: Text(text),
          header: true,
        ),
      ),
    );
  }
}

class _ThemeModeItem extends StatelessWidget {
  const _ThemeModeItem(this.options, this.onOptionsChanged);

  final GalleryOptions options;
  final ValueChanged<GalleryOptions> onOptionsChanged;

  static final Map<ThemeMode, String> modeLabels = <ThemeMode, String>{
    ThemeMode.system: 'System Default',
    ThemeMode.light: 'Light',
    ThemeMode.dark: 'Dark',
  };

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Theme'),
                Text(
                  '${modeLabels[options.themeMode]}',
                  style: Theme.of(context).primaryTextTheme.body1,
                ),
              ],
            ),
          ),
          PopupMenuButton<ThemeMode>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down),
            initialValue: options.themeMode,
            itemBuilder: (BuildContext context) {
              return ThemeMode.values
                  .map<PopupMenuItem<ThemeMode>>((ThemeMode mode) {
                return PopupMenuItem<ThemeMode>(
                  value: mode,
                  child: Text(modeLabels[mode]),
                );
              }).toList();
            },
            onSelected: (ThemeMode mode) {
              onOptionsChanged(
                options.copyWith(themeMode: mode),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TextScaleFactorItem extends StatelessWidget {
  const _TextScaleFactorItem(this.options, this.onOptionsChanged);

  final GalleryOptions options;
  final ValueChanged<GalleryOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Text size'),
                Text(
                  '${options.textScaleFactor.label}',
                  style: Theme.of(context).primaryTextTheme.body1,
                ),
              ],
            ),
          ),
          PopupMenuButton<GalleryTextScaleValue>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (BuildContext context) {
              return kAllGalleryTextScaleValues
                  .map<PopupMenuItem<GalleryTextScaleValue>>(
                      (GalleryTextScaleValue scaleValue) {
                return PopupMenuItem<GalleryTextScaleValue>(
                  value: scaleValue,
                  child: Text(scaleValue.label),
                );
              }).toList();
            },
            onSelected: (GalleryTextScaleValue scaleValue) {
              onOptionsChanged(
                options.copyWith(textScaleFactor: scaleValue),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TextDirectionItem extends StatelessWidget {
  const _TextDirectionItem(this.options, this.onOptionsChanged);

  final GalleryOptions options;
  final ValueChanged<GalleryOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Force RTL',
      options.textDirection == TextDirection.rtl,
      (bool value) {
        onOptionsChanged(
          options.copyWith(
            textDirection: value ? TextDirection.rtl : TextDirection.ltr,
          ),
        );
      },
      switchKey: const Key('text_direction'),
    );
  }
}

class _TimeDilationItem extends StatelessWidget {
  const _TimeDilationItem(this.options, this.onOptionsChanged);

  final GalleryOptions options;
  final ValueChanged<GalleryOptions> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      'Slow motion',
      options.timeDilation != 1.0,
      (bool value) {
        onOptionsChanged(
          options.copyWith(
            timeDilation: value ? 20.0 : 1.0,
          ),
        );
      },
      switchKey: const Key('slow_motion'),
    );
  }
}

class _PlatformItem extends StatelessWidget {
  const _PlatformItem(this.options, this.onOptionsChanged);

  final GalleryOptions options;
  final ValueChanged<GalleryOptions> onOptionsChanged;

  String _platformLabel(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return 'Mountain View';
      case TargetPlatform.fuchsia:
        return 'Fuchsia';
      case TargetPlatform.iOS:
        return 'Cupertino';
    }
    assert(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Platform mechanics'),
                Text(
                  '${_platformLabel(options.platform)}',
                  style: Theme.of(context).primaryTextTheme.body1,
                ),
              ],
            ),
          ),
          PopupMenuButton<TargetPlatform>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (BuildContext context) {
              return TargetPlatform.values.map((TargetPlatform platform) {
                return PopupMenuItem<TargetPlatform>(
                  value: platform,
                  child: Text(_platformLabel(platform)),
                );
              }).toList();
            },
            onSelected: (TargetPlatform platform) {
              onOptionsChanged(
                options.copyWith(platform: platform),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GalleryOptionsPage extends StatelessWidget {
  const GalleryOptionsPage({
    Key key,
    this.options,
    this.onOptionsChanged,
    this.onSendFeedback,
  }) : super(key: key);

  final GalleryOptions options;
  final ValueChanged<GalleryOptions> onOptionsChanged;
  final VoidCallback onSendFeedback;

  List<Widget> _enabledDiagnosticItems() {
    // Boolean showFoo options with a value of null: don't display
    // the showFoo option at all.
    if (options.showOffscreenLayersCheckerboard == null &&
        options.showRasterCacheImagesCheckerboard == null &&
        options.showPerformanceOverlay == null) return const <Widget>[];

    return <Widget>[
      const Divider(),
      const _Heading('Diagnostics'),
      if (options.showOffscreenLayersCheckerboard != null)
        _BooleanItem(
          'Highlight offscreen layers',
          options.showOffscreenLayersCheckerboard,
          (bool value) {
            onOptionsChanged(
                options.copyWith(showOffscreenLayersCheckerboard: value));
          },
        ),
      if (options.showRasterCacheImagesCheckerboard != null)
        _BooleanItem(
          'Highlight raster cache images',
          options.showRasterCacheImagesCheckerboard,
          (bool value) {
            onOptionsChanged(
                options.copyWith(showRasterCacheImagesCheckerboard: value));
          },
        ),
      if (options.showPerformanceOverlay != null)
        _BooleanItem(
          'Show performance overlay',
          options.showPerformanceOverlay,
          (bool value) {
            onOptionsChanged(options.copyWith(showPerformanceOverlay: value));
          },
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.primaryTextTheme.subhead,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 124.0),
        children: <Widget>[
          const _Heading('Display'),
          _ThemeModeItem(options, onOptionsChanged),
          _TextScaleFactorItem(options, onOptionsChanged),
          _TextDirectionItem(options, onOptionsChanged),
          _TimeDilationItem(options, onOptionsChanged),
          const Divider(),
          const _Heading('Platform mechanics'),
          _PlatformItem(options, onOptionsChanged),
          ..._enabledDiagnosticItems(),
          const Divider(),
          const _Heading('Flutter gallery'),
          _ActionItem('About Flutter Gallery', () {
//            showGalleryAboutDialog(context);
          }),
          _ActionItem('Send feedback', onSendFeedback),
        ],
      ),
    );
  }
}
