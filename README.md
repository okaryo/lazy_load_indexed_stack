[![Test and Lint](https://github.com/okaryo/lazy_load_indexed_stack/actions/workflows/test-and-lint.yml/badge.svg)](https://github.com/okaryo/lazy_load_indexed_stack/actions/workflows/test-and-lint.yml)

# lazy_load_indexed_stack

A package that extends IndexedStack to allow for lazy loading.

## Motivation

If you use the IndexedStack with bottom navigation, all the widgets specified in the children of the IndexedStack will be built.

Moreover, if the widget requires API requests or database access, or has a complex UI, the IndexedStack build time will be significant.

Therefore, we created an extended IndexedStack that builds the required widget only when it is needed, and returns the pre-built widget when it is needed again.

## Usage
You can use `LazyLoadIndexedStack` in the same way as `IndexedStack`.

```dart
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LazyLoadIndexedStack(
          index: _index,
          children: [
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() => _index = index);
          },
          currentIndex: _index,
          items: [
            BottomNavigationBarItem1(),
            BottomNavigationBarItem2(),
            BottomNavigationBarItem3(),
          ],
        ),
      ),
    );
  }
}
```

See more details in [Example](https://pub.dev/packages/lazy_load_indexed_stack/example) or [API reference](https://pub.dev/documentation/lazy_load_indexed_stack/latest/lazy_load_indexed_stack/LazyLoadIndexedStack-class.html)!
