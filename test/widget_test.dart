// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfcareagent/shared/widgets/buttons/primary_button.dart';

void main() {
  testWidgets('PrimaryButton widget test', (WidgetTester tester) async {
    bool buttonPressed = false;
    
    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            text: 'Test Button',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Verify that the button is displayed
    expect(find.text('Test Button'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    
    // Tap the button and verify the callback
    await tester.tap(find.byType(PrimaryButton));
    expect(buttonPressed, isTrue);
  });
}
