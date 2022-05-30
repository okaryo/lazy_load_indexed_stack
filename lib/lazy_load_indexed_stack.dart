library lazy_load_indexed_stack;

import 'package:flutter/widgets.dart';

/// An extended IndexedStack that builds the required widget only when it is needed, and returns the pre-built widget when it is needed again.
class LazyLoadIndexedStack extends StatefulWidget {
  /// Widget to be built when not loaded. Default widget is [Container].
  late final Widget unloadWidget;

  /// Same as alignment attribute of original IndexedStack.
  final AlignmentGeometry alignment;

  /// Same as sizing attribute of original IndexedStack.
  final StackFit sizing;

  /// Same as textDirection attribute of original IndexedStack.
  final TextDirection? textDirection;

  /// The index of the child to show.
  final int index;

  /// The widgets below this widget in the tree.
  ///
  /// A child widget will not be built until the index associated with it is specified.
  /// When the index associated with the widget is specified again, the built widget is returned.
  final List<Widget> children;

  /// Creates LazyLoadIndexedStack that wraps IndexedStack.
  LazyLoadIndexedStack({
    Key? key,
    Widget? unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : super(key: key) {
    this.unloadWidget = unloadWidget == null ? Container() : unloadWidget;
  }

  @override
  _LazyLoadIndexedStackState createState() => _LazyLoadIndexedStackState();
}

class _LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  late final List<bool> _alreadyLoaded;

  late List<Widget> _children;

  final stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _alreadyLoaded = List.filled(widget.children.length, false);
    _alreadyLoaded[widget.index] = true;

    _children = _loadedChildren();
  }

  @override
  void didUpdateWidget(final LazyLoadIndexedStack oldWidget) {
    _alreadyLoaded[widget.index] = true;
    _children[widget.index] = widget.children[widget.index];
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      key: stackKey,
      index: widget.index,
      children: _children,
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
