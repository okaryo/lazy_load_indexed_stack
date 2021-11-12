library lazy_load_indexed_stack;

import 'package:flutter/material.dart';

class LazyLoadIndexedStack extends StatefulWidget {
  late final Widget unloadWidget;
  final AlignmentGeometry alignment;
  final StackFit sizing;
  final TextDirection? textDirection;
  final int index;
  final List<Widget> children;

  LazyLoadIndexedStack({
    Key? key,
    Widget? unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : super(key: key) {
    if (unloadWidget == null) unloadWidget = Container();
  }

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
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
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
