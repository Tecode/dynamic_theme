import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewView extends StatelessWidget {
  final String content;
  const NewView({
    this.content,
  });

  static const String routeName = '/newView';
  @override
  Widget build(BuildContext context) {
    final NewView param = ModalRoute.of(context).settings.arguments;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('返回'),
          onPressed: () {
            // The demo is on the root navigator.
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
      child: Material(
        child: SafeArea(
          child: Center(child: Text('${param.content}')),
        ),
      ),
    );
  }
}
