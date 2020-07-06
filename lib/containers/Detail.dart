import 'dart:io';

import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/containers/NewView.dart';
import 'package:dynamic_theme/router/routerAnimation.dart';
import 'package:dynamic_theme/widgets/common/DialogBox.dart';

class Detail extends StatelessWidget {
  final String value;
  static String routeName = '/detail';

  const Detail({this.value});

  void showDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
//      if (value != null) {
//        setState(() { lastSelectedValue = value; });
//      }
    });
  }

  void _onAlertWithTitlePress(BuildContext context) {
    Navigator.of(context).push(
      showDialogRouter(
        DialogBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Detail arguments = ModalRoute.of(context).settings.arguments;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(start: 0.0, bottom: 8.0),
        transitionBetweenRoutes: Platform.isIOS,
        middle: Text(arguments.value),
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context, '数据传参'),
          child: Container(
            width: 44.0,
            padding: EdgeInsets.only(left: 10.0, right: 20.0),
            child: Image.asset(
              'assets/icons/ic_arrow_left_gray.png',
              color: ColorTheme.of(context).color202326,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Material(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('TITLE', style: Theme.of(context).textTheme.headline4),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text('弹窗'),
                  onPressed: () => _onAlertWithTitlePress(context),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text('Detail'),
                  onPressed: () => Navigator.of(context).pushNamed(
                    Detail.routeName,
                    arguments: Detail(value: 'Detail参数'),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text('返回NewList'),
                  onPressed: () => Navigator.of(context).popUntil(
                    ModalRoute.withName(NewView.routeName),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text('底部弹窗'),
                  onPressed: () => Navigator.of(context).push(
                    bottomPopRouter(Scaffold(
                      body: Center(
                        child: CupertinoButton(
                          child: Text('返回'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
