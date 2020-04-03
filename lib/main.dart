import 'package:flutter/material.dart';

void main() => runApp(DynamicTheme());

class DynamicTheme extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'TEXT',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  'Flutter: Dynamic Theming | Change Theme At Runtime',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                FlatButton(
                  onPressed: () => {},
                  child: Text('暗黑'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
