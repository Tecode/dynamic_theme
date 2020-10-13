import 'dart:async';
import 'dart:math';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/helpers/text_theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// The duration of the ScaleTransition that starts when the refresh action
// has completed.
class RefreshHeader extends Header {
  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  /// Key
  final Key key;

  /// 方位
  final AlignmentGeometry alignment;

  /// 提示刷新文字
  final String refreshText;

  /// 准备刷新文字
  final String refreshReadyText;

  /// 正在刷新文字
  final String refreshingText;

  /// 刷新完成文字
  final String refreshedText;

  /// 刷新失败文字
  final String refreshFailedText;

  /// 没有更多文字
  final String noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;

  RefreshHeader({
    extent = 60.0,
    triggerDistance = 90.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteRefresh = false,
    enableHapticFeedback = false,
    this.key,
    this.alignment,
    this.refreshText = '拉动刷新',
    this.refreshReadyText = '松手刷新',
    this.refreshingText = '正在更新数据',
    this.refreshedText = '更新数据成功',
    this.refreshFailedText = '更新数据失败',
    this.noMoreText = 'No more',
    this.showInfo = true,
    this.infoText = 'Updated at %T',
    this.bgColor = Colors.transparent,
    this.textColor = Colors.black,
    this.infoColor = Colors.teal,
  }) : super(
          extent: extent as double,
          triggerDistance: triggerDistance as double,
          float: float as bool,
          completeDuration: (float as bool
              ? completeDuration == null
                  ? Duration(
                      milliseconds: 400,
                    )
                  : completeDuration +
                      Duration(
                        milliseconds: 400,
                      )
              : completeDuration) as Duration,
          enableInfiniteRefresh: enableInfiniteRefresh as bool,
          enableHapticFeedback: enableHapticFeedback as bool,
        );

  @override
  Widget contentBuilder(
    BuildContext context,
    RefreshMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
    AxisDirection axisDirection,
    bool float,
    Duration completeDuration,
    bool enableInfiniteRefresh,
    bool success,
    bool noMore,
  ) {
    linkNotifier.contentBuilder(
      context,
      refreshState,
      pulledExtent,
      refreshTriggerPullDistance,
      refreshIndicatorExtent,
      axisDirection,
      float,
      completeDuration,
      enableInfiniteRefresh,
      success,
      noMore,
    );
    return ClassicalHeaderWidget(
      key: key,
      classicalHeader: this,
      refreshState: refreshState,
      pulledExtent: pulledExtent,
      refreshTriggerPullDistance: refreshTriggerPullDistance,
      refreshIndicatorExtent: refreshIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteRefresh: enableInfiniteRefresh,
      success: success,
      noMore: noMore,
      extent: extent,
      linkNotifier: linkNotifier,
    );
  }
}

class ClassicalHeaderWidget extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;
  final RefreshHeader classicalHeader;
  final RefreshMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration completeDuration;
  final bool enableInfiniteRefresh;
  final bool success;
  final bool noMore;
  final double extent;

  const ClassicalHeaderWidget({
    Key key,
    this.refreshState,
    this.classicalHeader,
    this.pulledExtent,
    this.refreshTriggerPullDistance,
    this.refreshIndicatorExtent,
    this.axisDirection,
    this.float,
    this.completeDuration,
    this.enableInfiniteRefresh,
    this.success,
    this.noMore,
    this.linkNotifier,
    this.extent,
  }) : super(key: key);

  @override
  ClassicalHeaderWidgetState createState() => ClassicalHeaderWidgetState();
}

class ClassicalHeaderWidgetState extends State<ClassicalHeaderWidget>
    with TickerProviderStateMixin<ClassicalHeaderWidget> {
//  获取下拉距离
  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
//  double get _indicatorExtent => widget.linkNotifier.refreshIndicatorExtent;
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
      _overTriggerDistance = over;
    }
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  // ignore: avoid_setters_without_getters
  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish && widget.float) {
        Future.delayed(widget.completeDuration - Duration(milliseconds: 400),
            () {
          if (mounted) {
            _floatBackController.forward();
          }
        });
        Future.delayed(widget.completeDuration, () {
          _floatBackDistance = null;
          _refreshFinish = false;
        });
      }
      _refreshFinish = finish;
    }
  }

  // 动画
  AnimationController _readyController;
  Animation<double> _readyAnimation;
  AnimationController _restoreController;
  Animation<double> _restoreAnimation;
  AnimationController _floatBackController;
  Animation<double> _floatBackAnimation;

  // 浮动时,收起距离
  double _floatBackDistance;

  // 显示文字
  String get _showText {
    if (widget.noMore) return widget.classicalHeader.noMoreText;
    if (widget.enableInfiniteRefresh) {
      if (_refreshState == RefreshMode.refreshed ||
          _refreshState == RefreshMode.inactive ||
          _refreshState == RefreshMode.drag) {
        return widget.classicalHeader.refreshedText;
      } else {
        return widget.classicalHeader.refreshingText;
      }
    }
    switch (_refreshState) {
      case RefreshMode.refresh:
        return widget.classicalHeader.refreshingText;
      case RefreshMode.armed:
        return widget.classicalHeader.refreshingText;
      case RefreshMode.refreshed:
        return _finishedText;
      case RefreshMode.done:
        return _finishedText;
      default:
        if (overTriggerDistance) {
          return widget.classicalHeader.refreshReadyText;
        } else {
          return widget.classicalHeader.refreshText;
        }
    }
  }

  // 刷新结束文字
  String get _finishedText {
    if (!widget.success) return widget.classicalHeader.refreshFailedText;
    if (widget.noMore) return widget.classicalHeader.noMoreText;
    return widget.classicalHeader.refreshedText;
  }

  @override
  void initState() {
    super.initState();
    // 准备动画
    _readyController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _readyAnimation = Tween(begin: 0.5, end: 1.0).animate(_readyController)
      ..addListener(() {
//        setState(() {
//          if (_readyAnimation.status != AnimationStatus.dismissed) {
//            _iconRotationValue = _readyAnimation.value;
//          }
//        });
      });
    _readyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _readyController.reset();
      }
    });
    // 恢复动画
    _restoreController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _restoreAnimation = Tween(begin: 0.0, end: 0.9).animate(_restoreController)
      ..addListener(() {
//        setState(() {
//          if (_restoreAnimation.status != AnimationStatus.dismissed) {
//            _iconRotationValue = _restoreAnimation.value;
//          }
//        });
      });
    _restoreAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _restoreController.reset();
      }
    });
    // float收起动画
    _floatBackController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _floatBackAnimation = Tween(begin: widget.refreshIndicatorExtent, end: 0.0)
        .animate(_floatBackController)
          ..addListener(() {
            setState(() {
              if (_floatBackAnimation.status != AnimationStatus.dismissed) {
                _floatBackDistance = _floatBackAnimation.value;
              }
            });
          });
    _floatBackAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _floatBackController.reset();
      }
    });
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    _floatBackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否为垂直方向
    var isVertical = widget.axisDirection == AxisDirection.down ||
        widget.axisDirection == AxisDirection.up;
    // 是否反向
    var isReverse = widget.axisDirection == AxisDirection.up ||
        widget.axisDirection == AxisDirection.left;
    // 是否到达触发刷新距离
    overTriggerDistance = _refreshState != RefreshMode.inactive &&
        widget.pulledExtent >= widget.refreshTriggerPullDistance;
    if (_refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: !isVertical
              ? 0.0
              : isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          bottom: !isVertical
              ? 0.0
              : !isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          left: isVertical
              ? 0.0
              : isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          right: isVertical
              ? 0.0
              : !isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          child: Container(
            alignment: (widget.classicalHeader.alignment ?? isVertical) as bool
                ? isReverse ? Alignment.topCenter : Alignment.bottomCenter
                : !isReverse ? Alignment.centerRight : Alignment.centerLeft,
            width: isVertical
                ? double.infinity
                : _floatBackDistance == null
                    ? (widget.refreshIndicatorExtent > widget.pulledExtent
                        ? widget.refreshIndicatorExtent
                        : widget.pulledExtent)
                    : widget.refreshIndicatorExtent,
            height: isVertical
                ? _floatBackDistance == null
                    ? (widget.refreshIndicatorExtent > widget.pulledExtent
                        ? widget.refreshIndicatorExtent
                        : widget.pulledExtent)
                    : widget.refreshIndicatorExtent
                : double.infinity,
            color: widget.classicalHeader.bgColor,
            child: SizedBox(
              height:
                  isVertical ? widget.refreshIndicatorExtent : double.infinity,
              width:
                  !isVertical ? widget.refreshIndicatorExtent : double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildContent(isVertical, isReverse),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建显示内容
  List<Widget> _buildContent(bool isVertical, bool isReverse) {
    return <Widget>[
      Expanded(
        flex: 5,
        child: Center(
          child: SizedBox(
            height: 22.0,
            width: 22.0,
            child: _refreshState == RefreshMode.refresh ||
                    _refreshState == RefreshMode.armed
                ? CircularProgressIndicator(
                    backgroundColor: Color(0xffff4b6e),
                    valueColor: AlwaysStoppedAnimation(Color(0xff0096fa)),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Color(0xffff4b6e),
                    value: min(_pulledExtent, widget.extent) / 60.0,
                  ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: _showText == null
            ? SizedBox()
            : Text(
                _showText,
                style: TextThemeStyle.of(context)
                    .font12
                    .copyWith(color: ColorTheme.of(context).cubeColor),
              ),
      ),
    ];
  }
}
