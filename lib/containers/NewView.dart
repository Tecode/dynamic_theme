import 'package:dynamic_theme/containers/Detail.dart';
import 'package:dynamic_theme/containers/app.dart';
import 'package:dynamic_theme/helpers/customBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewView extends StatefulWidget {
  final String content;
  const NewView({
    this.content,
  });
  static const String routeName = '/newView';

  @override
  _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DynamicTheme.routeObserver.subscribe(this, ModalRoute.of(context));
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
    DynamicTheme.routeObserver.unsubscribe(this);
    super.dispose();
  }

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
//            Navigator.of(context, rootNavigator: true).maybePop();
            Navigator.pop(context, '数据传参');
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
                    child: Center(
                      child: Text(
                        'Data-$index',
                        style: Theme.of(context).textTheme.body2,
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
