import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

void main() {
  testWidgets('LazyLoadIndexedStack', (final WidgetTester tester) async {
    const key = Key('key');
    final lazyLoadIndexedStack = LazyLoadIndexedStack(
      key: key,
      index: 0,
      children: [
        _buildWidget(1),
        _buildWidget(2),
        _buildWidget(3),
      ],
    );

    await tester.pumpWidget(MaterialApp(home: lazyLoadIndexedStack));

    final StatefulElement element = tester.element(find.byKey(key));
    final elementState = element.state as State<LazyLoadIndexedStack>;
    expect(elementState.widget, equals(lazyLoadIndexedStack));
    expect(find.text('page1'), findsOneWidget);
    expect(find.text('page2'), findsNothing);
    expect(find.text('page3'), findsNothing);
  });
}

Widget _buildWidget(final int num) {
  return Center(
    child: Text('page$num'),
  );
}
