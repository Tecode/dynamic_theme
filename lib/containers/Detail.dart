import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String value;
  static String routeName = '/detail';

  const Detail({this.value});
  @override
  Widget build(BuildContext context) {
    final Detail arguments = ModalRoute.of(context).settings.arguments;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(arguments.value),
      ),
      child: Material(
        child: Center(
          child: Text(
            arguments.value,
            style: Theme.of(context).textTheme.display3,
          ),
        ),
      ),
    );
  }
}
