import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.0 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            spreadRadius: 1.0,
            blurRadius: 6.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ...List.generate(
              5,
              (_) => Column(
                mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 20.0,
                        height: 20.0,
                        color: Colors.blueAccent,
                      ),
                      Text(
                        '标题',
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.4,
                        ),
                      )
                    ],
                  ))
        ],
      ),
    );
  }
}
