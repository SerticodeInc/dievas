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
  bool _isOpen = false;

  void _toggle() => setState(() => _isOpen = !_isOpen);

  void _close() => setState(() => _isOpen = false);

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).popover;
    final elevation = DievasTheme.elevationOf(context).md;

    final slideOffset = switch (widget.position) {
      .bottom => const Offset(0, 0.08),
      .top => const Offset(0, -0.08),
      .left => const Offset(-0.08, 0),
      .right => const Offset(0.08, 0),
    };

    final anchorAlignment = switch (widget.position) {
      .bottom => Alignment.bottomCenter,
      .top => Alignment.topCenter,
      .left => Alignment.centerLeft,
      .right => Alignment.centerRight,
    };

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(onTap: _toggle, child: widget.trigger),
        if (_isOpen)
          GestureDetector(
            onTap: _close,
            behavior: .translucent,
            child: Container(color: theme.barrierColor),
          ),
        if (_isOpen)
          Align(
            alignment: anchorAlignment,
            child: AnimatedSlide(
              offset: _isOpen ? Offset.zero : slideOffset,
              duration: theme.animationDuration,
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: _isOpen ? 1.0 : 0.0,
                duration: theme.animationDuration,
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
            ),
          ),
      ],
    );
  }
}
