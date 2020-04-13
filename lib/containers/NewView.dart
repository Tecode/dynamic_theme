import 'package:flutter/cupertino.dart';

class NewView extends StatelessWidget {
  const NewView();
  static const String routeName = '/newView';
  @override
  Widget build(BuildContext context) {
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
      child: SafeArea(
        child: Center(child: Text('999')),
      ),
    );
  }
}
