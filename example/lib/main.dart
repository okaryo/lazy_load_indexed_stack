import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
          preloadIndexes: const [2],
          children: const [
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: 'MAIL',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'CALENDAR',
            ),
            BottomNavigationBarItem(
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
  const Page1({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('page1'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('page2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('page3'),
    );
  }
}
