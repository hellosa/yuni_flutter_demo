import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Basic widget test', (WidgetTester tester) async {
    // Build a simple widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Hello World'),
        ),
      ),
    );

    // Just verify basic functionality works
    expect(find.text('Hello World'), findsOneWidget);
  });
}
