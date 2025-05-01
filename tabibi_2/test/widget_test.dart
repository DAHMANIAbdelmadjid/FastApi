import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi_2/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp(prefs: prefs));
    
    // Verify that login screen is shown initially
    expect(find.text('Sign In'), findsOneWidget);
  });
}
