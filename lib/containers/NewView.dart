import 'dart:io';

import 'package:dynamic_theme/containers/Detail.dart';
import 'package:dynamic_theme/containers/app.dart';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/helpers/customBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewView extends StatefulWidget {
  final String? content;
  const NewView({this.content});
  static const String routeName = '/newView';

  @override
  _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    App.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
    print(this);
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print('返回NewView');
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print('进入NewView');
  }

  @override
  void dispose() {
    App.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context)!.settings.arguments as NewView;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(),
        transitionBetweenRoutes: Platform.isIOS,
        middle: Text(
          'NewList-${param.content}',
          key: ValueKey('title'),
        ),
        leading: GestureDetector(
          key: Key('back'),
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context, '数据传参'),
          child: Container(
            width: 42.0,
            padding: EdgeInsets.only(left: 10.0, right: 20.0),
            child: Image.asset(
              'assets/icons/ic_arrow_left_gray.png',
              color: ColorTheme.of(context).color202326,
            ),
          ),
        ),
      ),
      child: Material(
        child: ScrollConfiguration(
          behavior: CustomBehavior(),
          child: ListView.builder(
            reverse: true,
            primary: true,
            itemCount: 60,
            itemBuilder: (BuildContext context, int index) {
              return Ink(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.of(context).pushNamed(
                    Detail.routeName,
                    arguments: Detail(value: 'NewView参数'),
                  ),
                  child: Container(
                    height: 44.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        '${param.content}-${index.toRadixString(2)}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
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
