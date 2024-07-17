import 'dart:async';
import 'dart:convert';

import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/widgets/common/nav_back_button.dart';
import 'package:dynamic_theme/widgets/tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Debounce {
  final Duration delay;
  VoidCallback? _onDebounced;
  Timer? _timer;

  Debounce({required this.delay});

  void run(VoidCallback onDebounced) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _onDebounced = onDebounced;
    _timer = Timer(delay, _onDebounced!);
  }
}

class NavigationPositioning extends StatefulWidget {
  static const String routeName = '/navigation_positioning';
  const NavigationPositioning({super.key});

  @override
  State<NavigationPositioning> createState() => _ScrollNavigationPositioningState();
}

class _ScrollNavigationPositioningState extends State<NavigationPositioning> {
  late Map<dynamic, dynamic> cityMap = {};
  List<GlobalKey> keyList = [];
  BuildContext? tabContext;
  late ScrollController _controller;
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _cityListLoad();
    // 监听状态栏点击事件
    Future.microtask(() {
      _controller = PrimaryScrollController.of(context);
      _controller.addListener(() => _debounce.run(handleTabChange));
    });
  }

  // 加载省市数据
  void _cityListLoad() {
    rootBundle.loadString('assets/city_list.json').then((value) {
      var jsonValue = json.decode(value) as Map;
      cityMap = jsonValue;
      for (int index = 0; index < cityMap.length; index++) {
        keyList.add(GlobalKey());
      }
      setState(() {});
    });
  }

  void handleTabChange() {
    late RenderBox box;

    for (var i = 0; i < keyList.length; i++) {
      if (keyList[i].currentContext == null) {
        continue;
      }
      box = keyList[i].currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);

      if ((MediaQuery.of(context).padding.top + 92) >= position.dy) {
        DefaultTabController.of(tabContext!).animateTo(
          i,
          duration: const Duration(milliseconds: 100),
        );
      }
    }
  }

  void handleScroll(int index) async {
    _controller.removeListener(() => _debounce.run(handleTabChange));
    final context = keyList[index].currentContext;
    if (context == null) {
      return;
    }
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
    );
    _controller.addListener(() => _debounce.run(handleTabChange));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: const Text('滑动定位'),
        leading: NavBackButton(onTap: () => Navigator.pop(context, '数据传参')),
      ),
      child: Material(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              DefaultTabController(
                length: cityMap.keys.length,
                child: Builder(
                  builder: (context) {
                    tabContext = context;
                    return TabBar(
                      indicator: const TabIndicator(),
                      indicatorColor: ColorTheme.of(context).borderColor,
                      labelColor: ColorTheme.of(context).borderColor,
                      isScrollable: true,
                      tabs: List.generate(
                        cityMap.keys.length,
                        (index) {
                          var key = cityMap.keys.toList()[index];
                          var list = (cityMap[key] as List).first;
                          return Tab(
                            child: Text(
                              '${list['province']}',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        },
                      ),
                      onTap: handleScroll,
                    );
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: List.generate(
                      cityMap.keys.length,
                      (index) {
                        var key0 = cityMap.keys.toList()[index];
                        var list0 = cityMap[key0] as List;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              key: keyList[index],
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                '${list0.first['province']}',
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                list0.length,
                                (index) => Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black.withOpacity(0.08)),
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    '${list0[index]['name']}',
                                    style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 15.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // child: ListView.builder(
                //   controller: _controller,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   itemBuilder: (context, index) {
                //     var _key = cityMap.keys.toList()[index];
                //     var _list = cityMap[_key] as List;
                //     return Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(top: 10.0),
                //           child: Text(
                //             '${_list.first['province']}',
                //             style: TextStyle(
                //               color: isDark ? Colors.white : Colors.black,
                //               fontSize: 16.0,
                //               fontWeight: FontWeight.w500,
                //             ),
                //             key: keyList[index],
                //           ),
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: List.generate(
                //             _list.length,
                //                 (index) => Container(
                //               child: Text(
                //                 '${_list[index]['name']}',
                //                 style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 15.0),
                //               ),
                //               padding: const EdgeInsets.symmetric(vertical: 15),
                //               decoration: BoxDecoration(
                //                 border: Border(
                //                   bottom: BorderSide(color: Colors.black.withOpacity(0.08)),
                //                 ),
                //               ),
                //               width: double.infinity,
                //             ),
                //           ),
                //         ),
                //       ],
                //     );
                //   },
                //   itemCount: cityMap.keys.length,
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
