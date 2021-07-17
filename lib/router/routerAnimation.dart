import 'package:flutter/material.dart';

// 底部弹出窗

Route bottomPopRouter(
  Widget widget, {
  opaque = false,
}) =>
    PageRouteBuilder(
      opaque: opaque as bool,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

// AlertBox
Route showDialogRouter(Widget widget, {Color? barrierColor}) => PageRouteBuilder(
      opaque: false,
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 120),
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) =>
          FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
          child: child,
        ),
      ),
    );
