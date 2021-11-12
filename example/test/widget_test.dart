import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_load_indexed_stack_example/main.dart';

void main() {
  testWidgets('lazy load page2 after bottom navigation item tapped', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MainApp());

    // Verify that only page1 is loaded.
    expect(find.text('page1'), findsOneWidget);
    expect(find.text('page2'), findsNothing);
    expect(find.text('page3'), findsNothing);

    // Tap bottom navigation icon associated with page2.
    await tester.tap(find.byIcon(Icons.today));
    await tester.pump();

    // Verify that page2 also is loaded.
    expect(find.text('page1'), findsOneWidget);
    expect(find.text('page2'), findsOneWidget);
    expect(find.text('page3'), findsNothing);
  });
}
