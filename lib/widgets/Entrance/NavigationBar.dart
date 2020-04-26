import 'package:dynamic_theme/containers/Entrance.dart';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final String activeKey;
  final Function onChange;
  NavigationBar({
    this.activeKey = 'HOME',
    this.onChange,
  });

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
        children: Entrance.navList
            .asMap()
            .keys
            .map(
              (int index) => Expanded(
                child: GestureDetector(
                  onTap: () => onChange.call(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 20.0,
                        height: 20.0,
                        color: Entrance.navList[index]['key'] == activeKey
                            ? CustomColors.of(context).activeNavColor
                            : CustomColors.of(context).cubeColor,
                      ),
                      Text(
                        '${Entrance.navList[index]['value']}',
                        style: TextStyle(
                          fontSize: 11.0,
                          height: 1.4,
                          color: Entrance.navList[index]['key'] == activeKey
                              ? CustomColors.of(context).activeNavColor
                              : CustomColors.of(context).cubeColor,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
