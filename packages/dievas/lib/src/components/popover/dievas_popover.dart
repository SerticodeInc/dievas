import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

enum DievasPopoverPosition { bottom, top, left, right }

class DievasPopover extends StatefulWidget {
  const DievasPopover({super.key, required this.trigger, required this.content, this.position = .bottom});

  final Widget trigger;
  final Widget content;
  final DievasPopoverPosition position;

  @override
  State<DievasPopover> createState() => _DievasPopoverState();
}

class _DievasPopoverState extends State<DievasPopover> {
  final _link = LayerLink();
  OverlayEntry? _entry;

  @override
  void dispose() {
    _removeEntry();
    super.dispose();
  }

  void _toggle() {
    if (_entry != null) {
      _removeEntry();
      return;
    }

    final theme = DievasTheme.componentsOf(context).popover;
    final elevation = DievasTheme.elevationOf(context).md;

    final followerAnchor = switch (widget.position) {
      .bottom => Alignment.topCenter,
      .top => Alignment.bottomCenter,
      .left => Alignment.centerRight,
      .right => Alignment.centerLeft,
    };

    final targetAnchor = switch (widget.position) {
      .bottom => Alignment.bottomCenter,
      .top => Alignment.topCenter,
      .left => Alignment.centerLeft,
      .right => Alignment.centerRight,
    };

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeEntry,
                behavior: .opaque,
                child: Container(color: theme.barrierColor),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              targetAnchor: targetAnchor,
              followerAnchor: followerAnchor,
              child: Container(
                constraints: BoxConstraints(maxWidth: theme.maxWidth),
                padding: theme.padding,
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: theme.borderRadius,
                  boxShadow: elevation,
                ),
                child: DefaultTextStyle(style: theme.textStyle, child: widget.content),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(entry);
    _entry = entry;
  }

  void _removeEntry() {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: Listener(behavior: .opaque, onPointerDown: (_) => _toggle(), child: widget.trigger),
    );
  }
}
