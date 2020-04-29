import 'package:dynamic_theme/containers/Detail.dart';
import 'package:dynamic_theme/containers/Entrance.dart';
import 'package:dynamic_theme/helpers/customBehavior.dart';
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
//    final NewView param = ModalRoute.of(context).settings.arguments;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('返回'),
          onPressed: () {
            // The demo is on the root navigator.
            Navigator.of(context, rootNavigator: true).maybePop();
          },
        ),
      ),
      child: Material(
        child: ScrollConfiguration(
          behavior: CustomBehavior(),
          child: ListView.builder(
            primary: true,
            itemCount: 60,
            itemBuilder: (BuildContext context, int index) {
              return Ink(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.of(context).pushNamed(
                    Detail.routeName,
                    arguments: Detail(value: '参数'),
                  ),
                  child: Container(
                    height: 44.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text('Data-$index')),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
