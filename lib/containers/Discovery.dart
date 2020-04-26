import 'package:flutter/material.dart';

class Discovery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
    );
  }
}
