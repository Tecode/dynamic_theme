import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.0 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          top: BorderSide(
            color: CustomColors.of(context).borderColor,
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ...List.generate(
            4,
            (_) => Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 20.0,
                    height: 20.0,
                    color: CustomColors.of(context).cubeColor,
                  ),
                  Text(
                    '标题',
                    style: TextStyle(
                      fontSize: 12.0,
                      height: 1.4,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
