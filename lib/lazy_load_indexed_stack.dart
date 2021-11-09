library lazy_load_indexed_stack;

import 'package:flutter/material.dart';

class LazyLoadIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Widget unloadWidget;

  const LazyLoadIndexedStack({
    required this.index,
    required this.children,
    required this.unloadWidget,
  });

  @override
  _LazyLoadIndexedStackState createState() => _LazyLoadIndexedStackState();
}

class _LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  late List<bool> _alreadyLoaded;

  _LazyLoadIndexedStackState();

  @override
  void initState() {
    super.initState();

    _alreadyLoaded = List.generate(widget.children.length, (index) => widget.index == index ? true : false);
  }

  @override
  void didUpdateWidget(final LazyLoadIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    _alreadyLoaded[widget.index] = true;
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      index: widget.index,
      children: _loadedChildren(),
    );
  }

  List<Widget> _loadedChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;
      return _alreadyLoaded[index] ? childWidget : widget.unloadWidget;
    }).toList();
  }
}
