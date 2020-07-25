import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void entrance() {
  FlutterDriver driver;
  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      await driver.close();
    }
  });
// test('starts at 0', () async {
// Use the `driver.getText` method to verify the counter starts at 0.
// expect(await driver.getText(counterTextFinder), '0');
//    });

  test('切换页面', () async {
    await Future.delayed(Duration(seconds: 2));

  });

  test('滑动页面', () async {
    final listFinder = find.byValueKey('message_list');
    final itemFinder = find.byValueKey('item_50_text');
    await Future.delayed(Duration(seconds: 2));
    await driver.scrollUntilVisible(
      listFinder,
      itemFinder,
      dyScroll: -300.0,
    );
    await driver.close();
  });

//  test('跳转页面', () async {
//    final buttonFinder = find.byValueKey('jump_list');
//    // First, tap the button.
//    await driver.tap(buttonFinder);
//
//    // Then, verify the counter text is incremented by 1.
//    // expect(await driver.getText(counterTextFinder), '1');
//  });
}
