import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Size variants for [DievasTextInputGroup].
enum DievasTextInputGroupSize {
  /// 40 dp segment height.
  sm,

  /// 48 dp segment height — default.
  md,

  /// 52 dp segment height.
  lg,
}

/// A horizontally-grouped set of input segments with a shared border.
///
/// Each child is wrapped in a segment container. The first and last segments
/// carry the group's border radius; inner segments have flat sides. A thin
/// vertical divider separates adjacent segments.
///
/// When any child [FocusNode] gains focus, the entire group border switches
/// to the focused colour and stroke width.
///
/// Moon reference: TextInputGroup
///
/// ```dart
/// DievasTextInputGroup(
///   children: [
///     DievasTextInput(hint: 'First name'),
///     DievasTextInput(hint: 'Last name'),
///   ],
/// )
/// DievasTextInputGroup(size: .sm, children: [...])
/// DievasTextInputGroup(enabled: false, children: [...])
/// ```
class DievasTextInputGroup extends StatefulWidget {
  const DievasTextInputGroup({super.key, required this.children, this.size = .md, this.enabled = true});

  /// Segment widgets — typically [DievasTextInput] or adornment widgets.
  final List<Widget> children;

  final DievasTextInputGroupSize size;

  /// When `false` the entire group is dimmed.
  final bool enabled;

  @override
  State<DievasTextInputGroup> createState() => _DievasTextInputGroupState();
}

class _DievasTextInputGroupState extends State<DievasTextInputGroup> {
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(DievasTextInputGroup old) {
    super.didUpdateWidget(old);
    if (old.enabled != widget.enabled && !widget.enabled) {
      _isFocused = false;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() => _isFocused = _focusNode.hasFocus);

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).textInputGroup;

    final height = switch (widget.size) {
      .sm => theme.height.sm,
      .md => theme.height.md,
      .lg => theme.height.lg,
    };

    final contentPadding = switch (widget.size) {
      .sm => theme.contentPadding.sm,
      .md => theme.contentPadding.md,
      .lg => theme.contentPadding.lg,
    };

    final strokeColor = _isFocused ? theme.borderColorFocused : theme.borderColor;
    final strokeWidth = _isFocused ? theme.strokeWidthFocused : theme.strokeWidth;

    final rowChildren = <Widget>[];
    for (var i = 0; i < widget.children.length; i++) {
      final isFirst = i == 0;
      final isLast = i == widget.children.length - 1;

      BorderRadiusGeometry segmentRadius;
      if (widget.children.length == 1) {
        segmentRadius = theme.borderRadius;
      } else if (isFirst) {
        segmentRadius = .horizontal(left: theme.borderRadius.topLeft);
      } else if (isLast) {
        segmentRadius = .horizontal(right: theme.borderRadius.topRight);
      } else {
        segmentRadius = .zero;
      }

      rowChildren.add(
        Expanded(
          child: Container(
            height: height,
            padding: contentPadding,
            decoration: BoxDecoration(
              color: theme.bgColor,
              border: Border(
                top: BorderSide(color: strokeColor, width: strokeWidth),
                bottom: BorderSide(color: strokeColor, width: strokeWidth),
                left: isFirst ? BorderSide(color: strokeColor, width: strokeWidth) : BorderSide.none,
                right: isLast ? BorderSide(color: strokeColor, width: strokeWidth) : BorderSide.none,
              ),
              borderRadius: segmentRadius,
            ),
            child: widget.children[i],
          ),
        ),
      );

      if (!isLast) {
        rowChildren.add(Container(height: height, width: theme.dividerWidth, color: theme.dividerColor));
      }
    }

    Widget group = Focus(
      focusNode: _focusNode,
      canRequestFocus: false,
      child: Row(crossAxisAlignment: .stretch, children: rowChildren),
    );

    if (!widget.enabled) {
      group = Opacity(opacity: theme.disabledOpacity, child: group);
    }

    return group;
  }
}
