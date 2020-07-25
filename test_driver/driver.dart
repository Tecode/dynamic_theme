// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  group('--------------------- ADD 10 --------------------------', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      final envVars = Platform.environment;
      final adbPath = join(
        envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'],
        'platform-tools',
        Platform.isWindows ? 'adb.exe' : 'adb',
      );
      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.example.yourapp', // replace with your app id
        'android.permission.RECORD_AUDIO'
      ]);
      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.zapit.zapit', // replace with your app id
        'android.permission.CAMERA'
      ]);
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('noReceipts', () async {
      expect(await driver.getText(find.byValueKey('NoReceipts')), "אין קבלות");
    });
    test('searchTitle', () async {
      expect(await driver.getText(find.byValueKey('searchTitle')), "חפש קבלה");
    });
    test('add 10 receipt', () async {
      var names = <String>[
        'receipt 1',
        'receipt 2',
        'receipt 3',
        'receipt 4',
        'receipt 5',
        'receipt 6',
        'receipt 7',
        'receipt 8',
        'receipt 9',
        'receipt 10',
      ];
      for (var name in names) {
        await driver.waitFor(find.byValueKey("gotoTakePictureScreen"));

        await driver.tap(find.byValueKey('gotoTakePictureScreen'));

        await driver.waitFor(find.byValueKey('NoCameraTstContainer'));

        await driver.waitFor(find.byValueKey('addManuallyButton'));
        await driver.waitFor(find.byValueKey('getImageFromGalleryButton'));

        await driver.waitFor(find.byValueKey('addManuallyButton'));
        await driver.tap(find.byValueKey('addManuallyButton'));

        await driver.waitFor(find.text("כותרת החשבונית"));
        await driver.waitFor(find.byValueKey('receiptPrice'));
        await driver.waitFor(find.byValueKey('receiptPhone'));
        await driver.waitFor(find.byValueKey('receiptDate'));
        await driver.waitFor(find.byValueKey('receiptTitle'));

        await driver.tap(find.byValueKey('receiptTitle'));

        await driver.tap(find.byValueKey('zTextFieldEdit'));
        await driver.enterText(name);
        await driver.waitFor(find.text(name));
        await driver.tap(find.byValueKey('zTextFieldEditSubmit'));

        await driver.waitFor(find.byValueKey('saveReceiptButton'));
        await driver.tap(find.byValueKey('saveReceiptButton'));
        await driver.waitFor(find.byValueKey('TappableSearchBar'));
        await driver.waitFor(find.text(name));
      }
    });
  }); //group
}