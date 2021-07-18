// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dynamic_theme/containers/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('珍珠白'), findsNothing);
    expect(find.text('暗夜黑'), findsOneWidget);
  });
}
