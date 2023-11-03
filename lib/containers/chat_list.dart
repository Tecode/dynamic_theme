import 'dart:io';

import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/helpers/textThemeStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:keyboard_attachable/keyboard_attachable.dart';

class ChatList extends StatefulWidget {
  static const String routeName = '/chatList';
  const ChatList({Key? key}) : super(key: key);
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.only(),
        transitionBetweenRoutes: Platform.isIOS,
        middle: Text(AppLocalizations.of(context)!.messageDetail),
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context, '数据传参'),
          child: Container(
            width: 42.0,
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Image.asset(
              'assets/icons/ic_arrow_left_gray.png',
              color: ColorTheme.of(context).color202326,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: Material(
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                onVerticalDragDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      children: [
                        Text(
                          '''KeyboardAttachable is a widget that adds space below its baseline when the soft keyboard is shown and hidden with an animation that matches that of the platform keyboard. This widget can be used to animate its child when the soft keyboard is shown or hidden, so that the child widget appears to be attached to the keyboard.
You can combine these two widgets by passing a KeyboardAttachable widget as the footer of a FooterLayout to create a page that shrinks and expands when the soft keyboard appears and disappears, with an animation that matches the platform keyboard animation. Additionally, you can pass a child widget to your KeyboardAttachable to have a footer in your page that attaches itself to the soft keyboard when shown.
In order for this to work with animations, the resizeToAvoidBottomInset parameter of the Scaffold above the page has to be false.
''',
                          style: TextThemeStyle.of(context).font16,
                        ),
                        Text(
                          '''KeyboardAttachable is a widget that adds space below its baseline when the soft keyboard is shown and hidden with an animation that matches that of the platform keyboard. This widget can be used to animate its child when the soft keyboard is shown or hidden, so that the child widget appears to be attached to the keyboard.
You can combine these two widgets by passing a KeyboardAttachable widget as the footer of a FooterLayout to create a page that shrinks and expands when the soft keyboard appears and disappears, with an animation that matches the platform keyboard animation. Additionally, you can pass a child widget to your KeyboardAttachable to have a footer in your page that attaches itself to the soft keyboard when shown.
In order for this to work with animations, the resizeToAvoidBottomInset parameter of the Scaffold above the page has to be false.
''',
                          style: TextThemeStyle.of(context).font16,
                        ),
                        Text(
                          '''KeyboardAttachable is a widget that adds space below its baseline when the soft keyboard is shown and hidden with an animation that matches that of the platform keyboard. This widget can be used to animate its child when the soft keyboard is shown or hidden, so that the child widget appears to be attached to the keyboard.
You can combine these two widgets by passing a KeyboardAttachable widget as the footer of a FooterLayout to create a page that shrinks and expands when the soft keyboard appears and disappears, with an animation that matches the platform keyboard animation. Additionally, you can pass a child widget to your KeyboardAttachable to have a footer in your page that attaches itself to the soft keyboard when shown.
In order for this to work with animations, the resizeToAvoidBottomInset parameter of the Scaffold above the page has to be false.
''',
                          style: TextThemeStyle.of(context).font16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: ColorTheme.of(context).colorF3F3F6,
                  child: const TextField(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
