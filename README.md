[![CI](https://github.com/okaryo/lazy_load_indexed_stack/actions/workflows/ci.yml/badge.svg)](https://github.com/okaryo/lazy_load_indexed_stack/actions/workflows/ci.yml)
[![Pub](https://img.shields.io/pub/v/lazy_load_indexed_stack)](https://pub.dev/packages/lazy_load_indexed_stack)

# lazy_load_indexed_stack

A package that extends IndexedStack to allow for lazy loading and provides enhanced control for reloading specific child widgets.

## Motivation

If you use the IndexedStack with bottom navigation, all the widgets specified in the children of the IndexedStack will be built.

Moreover, if the widget requires API requests or database access, or has a complex UI, the IndexedStack build time will be significant.

Therefore, we created an extended IndexedStack that builds the required widget only when it is needed and returns the pre-built widget when it is needed again.

## Features
* **Lazy Loading**: The main feature of `LazyLoadIndexedStack` is to build children widgets only when they are needed, reducing initial load time.
* **Preloading**: With the `preloadIndexes` parameter, you can specify indexes of children that should be built in advance, even if they are not currently visible. This is useful for preloading widgets that are likely to be needed soon.
* **Auto Disposal**: The `autoDisposeIndexes` parameter allows specific children to be automatically disposed of when they are no longer visible. When these children are accessed again, they will be rebuilt from scratch. This is useful for cases where widgets hold significant state or require resetting when revisited.

## Usage
You can use `LazyLoadIndexedStack` in the same way as `IndexedStack`, with additional options for preloading and auto dispose. If an index is included in both `preloadIndexes` and `autoDisposeIndexes`, it will be preloaded initially but disposed when it becomes invisible and rebuilt when accessed again.

### Basic Example
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
          preloadIndexes: [1, 2],
          autoDisposeIndexes: [2, 3],
          children: [
            Page1(), // Load by initial index
            Page2(), // Preloaded initially
            Page3(), // Preloaded initially but disposed when other index is selected
            Page4(), // Not preloaded and disposed when other index is selected
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
            BottomNavigationBarItem4(),
          ],
        ),
      ),
    );
  }
}
```

See more details in [Example](https://pub.dev/packages/lazy_load_indexed_stack/example) or [API reference](https://pub.dev/documentation/lazy_load_indexed_stack/latest/lazy_load_indexed_stack/LazyLoadIndexedStack-class.html)!
