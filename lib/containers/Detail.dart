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
        middle: Text(arguments.value),
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
