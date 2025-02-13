import 'package:flutter/widgets.dart';

/// An extended IndexedStack that builds the required widget only when it is needed, and returns the pre-built widget when it is needed again.
class LazyLoadIndexedStack extends StatefulWidget {
  /// Widget to be built when not loaded. Default widget is [Container].
  late final Widget unloadWidget;

  /// The indexes of children that should be preloaded.
  final List<int> preloadIndexes;

  /// The indexes of children that should be automatically disposed and rebuilt when accessed again.
  final List<int> autoDisposeIndexes;

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
    super.key,
    Widget? unloadWidget,
    this.preloadIndexes = const [],
    this.autoDisposeIndexes = const [],
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) {
    this.unloadWidget = unloadWidget ?? Container();
  }

  @override
  LazyLoadIndexedStackState createState() => LazyLoadIndexedStackState();
}

class LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  late List<Widget> _children;
  final _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _children = _initialChildren();

    final conflictingIndexes = widget.preloadIndexes.toSet().intersection(widget.autoDisposeIndexes.toSet());
    if (conflictingIndexes.isNotEmpty) {
      debugPrint('[LazyLoadIndexedStack] Warning: The same index is in both preloadIndexes and autoDisposeIndexes. '
          'It will be preloaded initially but disposed when not visible. Conflicting indexes: $conflictingIndexes');
    }
  }

  @override
  void didUpdateWidget(final LazyLoadIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.children.length != oldWidget.children.length) {
      _children = _initialChildren();
    }

    _children = _replaceAutoDisposedUnusedChildrenWithUnloadWidget();

    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      key: _stackKey,
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }

  List<Widget> _initialChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;

      if (index == widget.index || widget.preloadIndexes.contains(index)) {
        return childWidget;
      }

      return widget.unloadWidget;
    }).toList();
  }

  List<Widget> _replaceAutoDisposedUnusedChildrenWithUnloadWidget() {
    return List.generate(_children.length, (index) {
      if (index != widget.index && widget.autoDisposeIndexes.contains(index)) {
        return widget.unloadWidget;
      }

      return _children[index];
    });
  }
}
