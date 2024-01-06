import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

void main() {
  testWidgets('LazyLoadIndexedStack', (final WidgetTester tester) async {
    const key = Key('key');
    final lazyLoadIndexedStack = LazyLoadIndexedStack(
      key: key,
      index: 0,
      preloadIndexes: const [1, 3],
      children: [
        _buildWidget(1),
        _buildWidget(2),
        _buildWidget(3),
        _buildWidget(4),
        _buildWidget(5),
      ],
    );

    await tester.pumpWidget(MaterialApp(home: lazyLoadIndexedStack));

    final StatefulElement element = tester.element(find.byKey(key));
    final elementState = element.state as State<LazyLoadIndexedStack>;
    expect(elementState.widget, equals(lazyLoadIndexedStack));

    final indexedStack = find.byType(IndexedStack);
    expect(indexedStack, findsOneWidget);

    final IndexedStack indexedStackWidget = tester.widget(indexedStack) as IndexedStack;
    final children = indexedStackWidget.children;

    // page1 is loaded.
    expect(find.text('page1'), findsOneWidget);

    // page2 is loaded.
    bool hasPage2 = children.any((Widget widget) {
      return widget is Center && widget.child is Text && (widget.child as Text).data == 'page2';
    });
    expect(hasPage2, isTrue);

    // page3 is not loaded.
    expect(find.text('page3'), findsNothing);

    // page4 is loaded.
    bool hasPage4 = children.any((Widget widget) {
      return widget is Center && widget.child is Text && (widget.child as Text).data == 'page4';
    });
    expect(hasPage4, isTrue);

    // page5 is not loaded.
    expect(find.text('page5'), findsNothing);
  });
}

Widget _buildWidget(final int num) {
  return Center(
    child: Text('page$num'),
  );
}
