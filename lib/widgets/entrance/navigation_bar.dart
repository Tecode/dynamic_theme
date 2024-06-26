// @dart=2.14
import 'package:dynamic_theme/containers/entrance.dart';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final String activeKey;
  final Function onChange;
  const NavigationBar({
    required this.onChange,
    Key? key,
    this.activeKey = 'HOME',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 46.0 + MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            top: BorderSide(
              color: ColorTheme.of(context).borderColor,
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
                    key: ValueKey('tab_$index'),
                    onTap: () => onChange.call(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Entrance.navList[index]['key'] == activeKey
                                ? ColorTheme.of(context).activeNavColor
                                : ColorTheme.of(context).cubeColor,
                          ),
                        ),
                        Text(
                          '${Entrance.navList[index]['value']}',
                          style: TextStyle(
                            fontSize: 10.0,
                            height: 1.4,
                            color: Entrance.navList[index]['key'] == activeKey
                                ? ColorTheme.of(context).activeNavColor
                                : ColorTheme.of(context).cubeColor,
                          ),
                        ),
                        const SizedBox(height: 4.0)
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
