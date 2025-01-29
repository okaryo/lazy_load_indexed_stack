import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

void main() {
  group('LazyLoadIndexedStack', () {
    group('default behavior', () {
      testWidgets('only the selected index is loaded', (tester) async {
        const key = Key('default_test');
        final lazyLoadIndexedStack = LazyLoadIndexedStack(
          key: key,
          index: 0,
          children: [
            _buildWidget(1),
            _buildWidget(2),
            _buildWidget(3),
            _buildWidget(4),
            _buildWidget(5),
          ],
        );

        // initial state index = 0
        await tester.pumpWidget(MaterialApp(home: lazyLoadIndexedStack));

        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsNothing);
        expect(find.text('page3', skipOffstage: false), findsNothing);
        expect(find.text('page4', skipOffstage: false), findsNothing);
        expect(find.text('page5', skipOffstage: false), findsNothing);

        // switch to index = 2
        await tester.pumpWidget(
          MaterialApp(
            home: LazyLoadIndexedStack(
              key: key,
              index: 2,
              children: [
                _buildWidget(1),
                _buildWidget(2),
                _buildWidget(3),
                _buildWidget(4),
                _buildWidget(5),
              ],
            ),
          ),
        );
        await tester.pump();

        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsNothing);
        expect(find.text('page3', skipOffstage: false), findsOneWidget);
        expect(find.text('page4', skipOffstage: false), findsNothing);
        expect(find.text('page5', skipOffstage: false), findsNothing);
      });
    });

    group('#preloadIndexes', () {
      testWidgets('Only indexes in preloadIndexes should be preloaded', (tester) async {
        const key = Key('preload_test');
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

        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsOneWidget);
        expect(find.text('page3', skipOffstage: false), findsNothing);
        expect(find.text('page4', skipOffstage: false), findsOneWidget);
        expect(find.text('page5', skipOffstage: false), findsNothing);
      });
    });

    group('#autoDisposeIndexes', () {
      testWidgets('Widgets in autoDisposeIndexes should be disposed when not visible', (tester) async {
        const key = Key('auto_dispose_test');
        final lazyLoadIndexedStack = LazyLoadIndexedStack(
          key: key,
          index: 0,
          autoDisposeIndexes: const [2, 4],
          children: [
            _buildWidget(1),
            _buildWidget(2),
            _buildWidgetWithKey(3),
            _buildWidget(4),
            _buildWidgetWithKey(5),
          ],
        );

        await tester.pumpWidget(MaterialApp(home: lazyLoadIndexedStack));

        // initial state index = 0
        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsNothing);
        expect(find.text('page3', skipOffstage: false), findsNothing);
        expect(find.text('page4', skipOffstage: false), findsNothing);
        expect(find.text('page5', skipOffstage: false), findsNothing);

        // switch to index = 2
        await tester.pumpWidget(
          MaterialApp(
            home: LazyLoadIndexedStack(
              key: key,
              index: 2,
              autoDisposeIndexes: const [2, 4],
              children: [
                _buildWidget(1),
                _buildWidget(2),
                _buildWidgetWithKey(3),
                _buildWidget(4),
                _buildWidgetWithKey(5),
              ],
            ),
          ),
        );
        await tester.pump();

        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsNothing);
        expect(find.text('page3', skipOffstage: false), findsOneWidget);
        expect(find.text('page4', skipOffstage: false), findsNothing);
        expect(find.text('page5', skipOffstage: false), findsNothing);

        // back to index = 0 (3 should be disposed)
        await tester.pumpWidget(
          MaterialApp(
            home: LazyLoadIndexedStack(
              key: key,
              index: 0,
              autoDisposeIndexes: const [2, 4],
              children: [
                _buildWidget(1),
                _buildWidget(2),
                _buildWidgetWithKey(3),
                _buildWidget(4),
                _buildWidgetWithKey(5),
              ],
            ),
          ),
        );
        await tester.pump();

        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsNothing);
        expect(find.text('page3', skipOffstage: false), findsNothing);
        expect(find.text('page4', skipOffstage: false), findsNothing);
        expect(find.text('page5', skipOffstage: false), findsNothing);

        // switch back to index = 2 (3 should be rebuilt)
        await tester.pumpWidget(
          MaterialApp(
            home: LazyLoadIndexedStack(
              key: key,
              index: 2,
              autoDisposeIndexes: const [2, 4],
              children: [
                _buildWidget(1),
                _buildWidget(2),
                _buildWidgetWithKey(3),
                _buildWidget(4),
                _buildWidgetWithKey(5),
              ],
            ),
          ),
        );
        await tester.pump();

        expect(find.text('page1', skipOffstage: false), findsOneWidget);
        expect(find.text('page2', skipOffstage: false), findsNothing);
        expect(find.text('page3', skipOffstage: false), findsOneWidget);
        expect(find.text('page4', skipOffstage: false), findsNothing);
        expect(find.text('page5', skipOffstage: false), findsNothing);
      });
    });
  });
}

Widget _buildWidget(final int num) {
  return Center(
    child: Text('page$num'),
  );
}

Widget _buildWidgetWithKey(final int num) {
  return Center(
    key: ValueKey(num),
    child: Text('page$num'),
  );
}
