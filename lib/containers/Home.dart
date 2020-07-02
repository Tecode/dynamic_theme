import 'package:dynamic_theme/containers/NewView.dart';
import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/helpers/customBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EasyRefreshController _controller;
  // ScrollController _scrollController;
  int _count = 20;
  // 是否开启加载
  bool _enableLoad = true;

  // 控制结束
  bool _enableControlFinish = false;

  // 是否开启刷新
  bool _enableRefresh = true;

  //  路由跳转
  void _launchRouter(BuildContext context) {
    // Timeline.instantSync('Start Transition', arguments: <String, String>{
    //   'from': Entrance.routeName,
    //   'to': NewView.routeName,
    // });
    Navigator.of(context)
        .pushNamed(
          NewView.routeName,
          arguments: NewView(
            content: '路由传参',
          ),
        )
        .then((value) => print(value));
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    // _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _launchRouter(context),
          child: Icon(
            Icons.track_changes,
            size: 24.0,
            color: CustomColors.of(context).color202326,
          ),
        ),
        transitionBetweenRoutes: false,
        middle: Text('消息'),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 44.0,
        ),
        child: ScrollConfiguration(
          behavior: CustomBehavior(),
          child: EasyRefresh.custom(
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            controller: _controller,
//            scrollController: _scrollController,
            header: ClassicalHeader(
              bgColor: Theme.of(context).backgroundColor,
              infoColor: Colors.black87,
              float: false,
              enableHapticFeedback: false,
              refreshText: '拉动刷新',
              refreshReadyText: '释放刷新',
              refreshingText: '数据加载中',
              refreshedText: '更新完成',
              refreshFailedText: '刷新失败',
              noMoreText: '没有更多了',
              infoText: '%T 更新了消息',
            ),
            footer: ClassicalFooter(
              enableInfiniteLoad: true,
              enableHapticFeedback: false,
              loadText: 'S.of(context).pushToLoad',
              loadReadyText: 'S.of(context).releaseToLoad',
              loadingText: 'S.of(context).loading',
              loadedText: 'S.of(context).loaded',
              loadFailedText: 'S.of(context).loadFailed',
              noMoreText: '没有更多了',
              infoText: '%T 更新',
            ),
            onRefresh: _enableRefresh
                ? () async {
                    await Future.delayed(Duration(seconds: 2), () {
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
                    await Future.delayed(Duration(seconds: 2), () {
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
                    if (index == 0) return SizedBox(height: 15.0);
                    return const AvatarWrapBox();
                  },
                  childCount: _count + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarWrapBox extends StatelessWidget {
  const AvatarWrapBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            margin: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              color: CustomColors.of(context).colorF3F3F6,
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
                color: CustomColors.of(context).colorF3F3F6,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 80.0 - 28.0,
                height: 18.0,
                color: CustomColors.of(context).colorF3F3F6,
              ),
            ],
          )
        ],
      ),
    );
  }
}
