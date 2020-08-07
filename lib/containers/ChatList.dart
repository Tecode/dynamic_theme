import 'dart:io';

import 'package:dynamic_theme/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ChatList extends StatefulWidget {
  static const String routeName = '/chatList';
  const ChatList();
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(start: 0.0),
        transitionBetweenRoutes: Platform.isIOS,
        middle: Text('45'),
        leading: GestureDetector(
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
      child: SafeArea(
        child: Material(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return EasyRefresh.custom(
                reverse: true,
                slivers: <Widget>[
//                  SliverList(
//                    delegate: SliverChildBuilderDelegate(
//                      (context, index) {
//                        return Text('445');
//                      },
//                      childCount: 4,
//                    ),
//                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: constraints.maxHeight,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
//                          for (MessageEntity entity in _msgList.reversed)
//                            _buildMsg(entity),
                          Container(
                            color: Colors.deepOrangeAccent,
                            height: 400,
                            child: Text('8998'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
