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

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
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
            const BottomNavigationBarItem(icon: Icon(Icons.email), label: 'MAIL'),
            const BottomNavigationBarItem(icon: Icon(Icons.today), label: 'CALENDAR'),
            const BottomNavigationBarItem(icon: Icon(Icons.group), label: 'USER'),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('page3'),
    );
  }
}
