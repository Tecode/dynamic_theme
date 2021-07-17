import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void entrance() {
  late FlutterDriver driver;
  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    await driver.close();
  });
// test('starts at 0', () async {
// Use the `driver.getText` method to verify the counter starts at 0.
// expect(await driver.getText(counterTextFinder), '0');
//    });

  test('切换页面', () async {
    await Future.delayed(Duration(seconds: 2));
    await driver.tap(find.byValueKey('tab_3'));
    await Future.delayed(Duration(seconds: 5));
    await driver.tap(find.byValueKey('tab_2'));
    await Future.delayed(Duration(seconds: 5));
    await driver.tap(find.byValueKey('tab_1'));
    await Future.delayed(Duration(seconds: 5));
    await driver.tap(find.byValueKey('tab_0'));
  });

  test('滑动页面到底部', () async {
    await driver.runUnsynchronized(() async {
      final listFinder = find.byValueKey('message_list');
      final itemFinder = find.byValueKey('item_78');
      await driver.scrollUntilVisible(
        listFinder,
        itemFinder,
        dyScroll: -300.0,
      );
    });
  });

  test('滑动页面到顶部', () async {
    await driver.runUnsynchronized(() async {
      final listFinder = find.byValueKey('message_list');
      final itemFinder = find.byValueKey('item_1');
      await driver.scrollUntilVisible(
        listFinder,
        itemFinder,
        dyScroll: 300.0,
      );
    });
  });

  test('跳转页面', () async {
    // First, tap the button.
    await driver.tap(find.byValueKey('jump_list'));

    // Then, verify the counter text is incremented by 1.
    expect(await driver.getText(find.byValueKey('title')), 'NewList-路由传参');
  });

  test('返回页面', () async {
    await Future.delayed(Duration(seconds: 5));
    final buttonFinder = find.byValueKey('back');
    // First, tap the button.
    await driver.tap(buttonFinder);

    // Then, verify the counter text is incremented by 1.
    // expect(await driver.getText(counterTextFinder), '1');
  });
}
