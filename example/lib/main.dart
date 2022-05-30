import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  final indexStackKey = GlobalKey();

  final page1Key = GlobalKey();
  final page2Key = GlobalKey();
  final page3Key = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: LazyLoadIndexedStack(
          key: indexStackKey,
          index: _index,
          children: [
            Page1(key: page1Key),
            Page2(key: page2Key),
            Page3(key: page3Key),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() => _index = index);
          },
          currentIndex: _index,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: 'MAIL',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'CALENDAR',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'USER',
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    String className = (this).runtimeType.toString();
    print('Build $className $key');

    return const Center(
      child: Text('page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    String className = (this).runtimeType.toString();
    print('Build $className $key');

    return const Center(
      child: Text('page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);
  @override
  Widget build(final BuildContext context) {
    String className = (this).runtimeType.toString();
    print('Build $className $key');

    return const Center(
      child: Text('page3'),
    );
  }
}
