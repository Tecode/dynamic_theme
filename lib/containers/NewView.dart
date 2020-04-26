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
        child: ListView.builder(
          primary: true,
          itemCount: 60,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 44.0,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text('Data-$index')),
            );
          },
        ),
      ),
    );
  }
}
