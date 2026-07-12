import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_protection/core/services/prtection_pridge.dart';
import 'package:otp_protection/main.dart';

void main() {
  void setupTestScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(1125, 2436); // 375x812 design size * 3 ratio
    tester.view.devicePixelRatio = 3.0;
    ProtectionBridge().init();
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('OTP Protection Home Screen renders correctly', (WidgetTester tester) async {
    setupTestScreen(tester);
    
    // Build the app.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify home screen elements render.
    expect(find.text('Active Protection Running'), findsOneWidget);
    expect(find.text('Listening for OTP and call state...'), findsOneWidget);
    expect(find.text('Trigger Test Scenarios'), findsOneWidget);
  });

  testWidgets('Triggering Normal OTP scenario shows standard warning dialog', (WidgetTester tester) async {
    setupTestScreen(tester);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Tap the test trigger button.
    await tester.tap(find.text('Trigger Test Scenarios'));
    await tester.pumpAndSettle();

    // Verify bottom sheet options appear.
    expect(find.text('Normal: OTP Detected'), findsOneWidget);

    // Tap on the Normal: OTP Detected option.
    await tester.tap(find.text('Normal: OTP Detected'));
    await tester.pumpAndSettle();

    // Verify that the Normal Warning dialog renders.
    expect(find.text('OTP Detected'), findsOneWidget);
    expect(find.text('Understood'), findsOneWidget);

    // Close the dialog.
    await tester.tap(find.text('Understood'));
    await tester.pumpAndSettle();

    // Verify dialog is closed.
    expect(find.text('OTP Detected'), findsNothing);
  });

  testWidgets('Triggering Danger OTP scenario shows critical alert dialog', (WidgetTester tester) async {
    setupTestScreen(tester);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Tap the test trigger button.
    await tester.tap(find.text('Trigger Test Scenarios'));
    await tester.pumpAndSettle();

    // Tap on the Danger: OTP During Active Call option.
    await tester.tap(find.text('Danger: OTP During Active Call'));
    await tester.pumpAndSettle();

    // Verify that the Critical Alert dialog renders.
    expect(find.text('CRITICAL ALERT'), findsOneWidget);
    expect(find.text('I Will Not Share It'), findsOneWidget);

    // Close the dialog.
    await tester.tap(find.text('I Will Not Share It'));
    await tester.pumpAndSettle();

    // Verify dialog is closed.
    expect(find.text('CRITICAL ALERT'), findsNothing);
  });
}
