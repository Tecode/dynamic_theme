import 'package:dynamic_theme/containers/Discovery.dart';
import 'package:dynamic_theme/containers/NewView.dart';
import 'package:dynamic_theme/router/routerAnimation.dart';
import 'package:dynamic_theme/widgets/common/AlertDialog.dart';
import 'package:flutter/cupertino.dart'
    hide CupertinoAlertDialog, CupertinoDialogAction;
import 'package:flutter/material.dart';

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
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: const Text(
            'Allow "Maps" to access your location while you are using the app?'),
        content: const Text(
            'Your current location will be displayed on the map and used '
            'for directions, nearby search results, and estimated travel times.'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Don\'t Allow'),
            onPressed: () => Navigator.pop(context, 'Disallow'),
          ),
          CupertinoDialogAction(
            child: const Text('Allow'),
            onPressed: () => Navigator.pop(context, 'Allow'),
          ),
        ],
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
                    bottomPopRouter(
                      Discovery(),
                    ),
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
