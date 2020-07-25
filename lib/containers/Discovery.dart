import 'dart:convert';

import 'package:dynamic_theme/containers/DiscoveryDetail.dart';
import 'package:dynamic_theme/helpers/customBehavior.dart';
import 'package:dynamic_theme/widgets/common/RefreshFooter.dart';
import 'package:dynamic_theme/widgets/common/RefreshHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class NetworkSource {
  final String url;
  final int width;
  final int height;
  final int imgId;
  NetworkSource({this.url, this.width, this.height, this.imgId});
}

class Discovery extends StatefulWidget {
  @override
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;

  ScrollController _scrollController;

  final int _count = 100;
  int _index = 1;
  int totalElements = 0;

  final bool _enableLoad = true;

  final bool _enableControlFinish = false;

  final bool _enableRefresh = true;

  @override
  bool get wantKeepAlive => true;

  List<NetworkSource> _imageList = [
    NetworkSource(
      url:
          'https://c-ssl.duitang.com/uploads/item/201912/31/20191231204136_ypgdq.jpg',
    ),
    NetworkSource(
      url:
          'https://c-ssl.duitang.com/uploads/item/201912/31/20191231204137_xrpfz.jpg',
    ),
  ];

  List<NetworkSource> parseJson(List data) => data
      .map((itemData) => NetworkSource(
            url: itemData['img_url'] as String,
            width: itemData['width'] as int,
            height: itemData['height'] as int,
            imgId: itemData['img_id'] as int,
          ))
      .toList();
// 分页
  void _pagination() {
    rootBundle.loadString('assets/network_image.json').then((value) {
      var _json = json.decode(value);
      var _contentList = _json['content']
          .sublist((_index - 1) * _count, _index * _count) as List;
      setState(() {
        _imageList = [..._imageList, ...parseJson(_contentList)];
        totalElements = _json['totalElements'] as int;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _pagination();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text('发现'),
      ),
      child: ScrollConfiguration(
        behavior: CustomBehavior(),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 44.0,
          ),
          child: EasyRefresh.custom(
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
            footer: RefreshFooter(),
            onRefresh: _enableRefresh
                ? () async {
                    await Future.delayed(Duration(seconds: 1), () {
                      if (mounted) {
                        _index = 1;
                        if (!_enableControlFinish) {
                          _controller.resetLoadState();
                          _controller.finishRefresh();
                        }
                        _pagination();
                      }
                    });
                  }
                : null,
            onLoad: _enableLoad
                ? () async {
                    await Future.delayed(Duration(seconds: 1), () {
                      if (mounted) {
                        _index++;
                        if (!_enableControlFinish) {
                          _controller.finishLoad(
                              noMore:
                                  _index >= (totalElements / _count).ceil());
                        }
                        _pagination();
                      }
                    });
                  }
                : null,
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120.0,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final _data = _imageList[index];
                    return Hero(
                      tag: '$index TAG${_data.imgId}',
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          PageRouteBuilder<void>(pageBuilder: (
                            BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                          ) {
                            const opacityCurve = Interval(0.0, 0.75,
                                curve: Curves.fastOutSlowIn);
                            // 过渡动画
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget child) =>
                                  Opacity(
                                opacity:
                                    opacityCurve.transform(animation.value),
                                child: DiscoveryDetail(
                                  tag: '$index TAG${_data.imgId}',
                                  url: _data.url,
                                ),
                              ),
                            );
                          }),
                        ),
                        behavior: HitTestBehavior.opaque,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: _data.url,
                          imageCacheWidth: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  childCount: _imageList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
