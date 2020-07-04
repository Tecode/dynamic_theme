import 'package:dynamic_theme/helpers/customBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Discovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text('发现'),
      ),
      child: ScrollConfiguration(
        behavior: CustomBehavior(),
        child: ListView.builder(
          controller: PrimaryScrollController.of(context),
          itemCount: 600,
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
