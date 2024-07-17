import 'dart:io';

import 'package:dynamic_theme/containers/new_view.dart';
import 'package:dynamic_theme/router/router_animation.dart';
import 'package:dynamic_theme/widgets/common/dialog_box.dart';
import 'package:dynamic_theme/widgets/common/nav_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String? value;
  static String routeName = '/detail';

  const Detail({super.key, this.value});

  void showDialog({required BuildContext context, required Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((value) {
//      if (value != null) {
//        setState(() { lastSelectedValue = value; });
//      }
    });
  }

  void _onAlertWithTitlePress(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Builder(
          builder: (BuildContext context) => ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: const DialogBox(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Detail;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        transitionBetweenRoutes: Platform.isIOS,
        middle: Text(arguments.value ?? ''),
        leading: NavBackButton(onTap: () => Navigator.pop(context, '数据传参')),
      ),
      child: SafeArea(
        child: Material(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('TITLE', style: Theme.of(context).textTheme.headlineLarge),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _onAlertWithTitlePress(context),
                  child: const Text('弹窗'),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pushNamed(
                    Detail.routeName,
                    arguments: const Detail(value: 'Detail参数'),
                  ),
                  child: const Text('Detail'),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).popUntil(
                    ModalRoute.withName(NewView.routeName),
                  ),
                  child: const Text('返回NewList'),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push(
                    bottomPopRouter(Scaffold(
                      body: Center(
                        child: CupertinoButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('返回'),
                        ),
                      ),
                    )),
                  ),
                  child: const Text('底部弹窗'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
