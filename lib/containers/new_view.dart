import 'dart:io';

import 'package:dynamic_theme/containers/app.dart';
import 'package:dynamic_theme/containers/detail.dart';
import 'package:dynamic_theme/helpers/custom_behavior.dart';
import 'package:dynamic_theme/widgets/common/nav_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewView extends StatefulWidget {
  final String? content;
  const NewView({super.key, this.content});
  static const String routeName = '/newView';

  @override
  State<NewView> createState() => _NewViewState();
}

class _NewViewState extends State<NewView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    App.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
    debugPrint("$this");
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    debugPrint('返回NewView');
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    debugPrint('进入NewView');
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
        padding: const EdgeInsetsDirectional.only(),
        transitionBetweenRoutes: Platform.isIOS,
        middle: Text(
          'NewList-${param.content}',
          key: const ValueKey('title'),
        ),
        leading: NavBackButton(onTap: () => Navigator.pop(context, '数据传参')),
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
                    arguments: const Detail(value: 'NewView参数'),
                  ),
                  child: SizedBox(
                    height: 44.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        '${param.content}-${index.toRadixString(2)}',
                        style: Theme.of(context).textTheme.bodyLarge,
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
