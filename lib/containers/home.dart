import 'dart:io';

import 'package:dynamic_theme/containers/new_view.dart';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/widgets/common/refresh_footer.dart';
import 'package:dynamic_theme/widgets/common/refresh_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'chat_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late EasyRefreshController _controller;
  late ScrollController _scrollController;
  int _count = 20;
  // 是否开启加载
  final bool _enableLoad = true;

  // 控制结束
  final bool _enableControlFinish = false;

  // 是否开启刷新
  final bool _enableRefresh = true;

  //  路由跳转
  void _launchRouter(BuildContext context) {
    // Timeline.instantSync('Start Transition', arguments: <String, String>{
    //   'from': Entrance.routeName,
    //   'to': NewView.routeName,
    // });
//    _controller.callRefresh();
    Navigator.of(context)
        .pushNamed(
          NewView.routeName,
          arguments: const NewView(content: '路由传参'),
        )
        .then((error) => debugPrint("$error"));
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = PrimaryScrollController.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: Platform.isIOS,
        trailing: GestureDetector(
          key: const ValueKey('jump_list'),
          behavior: HitTestBehavior.opaque,
          onTap: () => _launchRouter(context),
          child: Icon(
            Icons.track_changes,
            size: 24.0,
            color: ColorTheme.of(context).color202326,
          ),
        ),
        middle: Text(AppLocalizations.of(context)!.information),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 44.0,
        ),
        child: EasyRefresh.custom(
          key: const Key('message_list'),
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          controller: _controller,
          scrollController: _scrollController,
          header: RefreshHeader(
            refreshedText: '小暑金将伏，微凉麦正秋',
            refreshingText: '小暑金将伏，微凉麦正秋',
            refreshReadyText: '小暑金将伏，微凉麦正秋',
            refreshText: '小暑金将伏，微凉麦正秋',
          ),
          footer: RefreshFooter(
            key: const Key('home_footer'),
          ),
          onRefresh: _enableRefresh
              ? () async {
                  await Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        _count = 20;
                      });
                      if (!_enableControlFinish) {
                        _controller.resetLoadState();
                        _controller.finishRefresh();
                      }
                    }
                  });
                }
              : null,
          onLoad: _enableLoad
              ? () async {
                  await Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        _count += 20;
                      });
                      if (!_enableControlFinish) {
                        _controller.finishLoad(noMore: _count >= 80);
                      }
                    }
                  });
                }
              : null,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) return const SizedBox(height: 15.0);
                  return AvatarWrapBox(
                    key: Key('item_$index'),
                    onTap: () => Navigator.of(context).pushNamed(ChatList.routeName),
                  );
                },
                childCount: _count + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarWrapBox extends StatelessWidget {
  final GestureTapCallback? onTap;
  const AvatarWrapBox({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap?.call(),
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              margin: const EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                color: ColorTheme.of(context).colorF3F3F6,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 160.0,
                  height: 18.0,
                  color: ColorTheme.of(context).colorF3F3F6,
                ),
                Container(
                  width: 260.0,
                  height: 18.0,
                  color: ColorTheme.of(context).colorF3F3F6,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Key>('key', key));
  }
}
