import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A themed drawer over [child], opened through [DievasDrawerState].
///
/// Start/end placement follows the ambient text direction. Content remains
/// caller owned; the drawer supplies the surface, barrier and navigation semantics.
class DievasDrawer extends StatefulWidget {
  const DievasDrawer({
    super.key,
    required this.child,
    required this.drawer,
    this.width,
    this.backgroundColour,
    this.barrierColour,
    this.borderRadius,
    this.decoration,
    this.shadow,
    this.semanticLabel,
    this.alignment = .start,
    this.enableOpenDragGesture = true,
    this.barrierDismissible = true,
    this.onChanged,
  });

  final Widget child;
  final Widget drawer;
  final double? width;
  final Color? backgroundColour;
  final Color? barrierColour;
  final BorderRadiusGeometry? borderRadius;

  /// Complete surface decoration override, replacing background and shadows.
  /// Clipping still follows [borderRadius].
  final Decoration? decoration;
  final List<BoxShadow>? shadow;
  final String? semanticLabel;
  final DrawerAlignment alignment;
  final bool enableOpenDragGesture;
  final bool barrierDismissible;

  /// Reports open/close requests, including swipe and barrier interactions.
  final ValueChanged<bool>? onChanged;

  @override
  DievasDrawerState createState() => DievasDrawerState();
}

class DievasDrawerState extends State<DievasDrawer> {
  final _drawerKey = GlobalKey<DrawerControllerState>();
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void open() => _drawerKey.currentState?.open();

  void close() => _drawerKey.currentState?.close();

  void toggle() => switch (_isOpen) {
    true => close(),
    false => open(),
  };

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).drawer;
    final direction = Directionality.of(context);
    final opensFromLeft = (widget.alignment == .start) == (direction == .ltr);
    final radius = switch ((widget.borderRadius, opensFromLeft)) {
      (final radius?, _) => radius.resolve(direction),
      (null, true) => theme.borderRadius,
      (null, false) => BorderRadius.only(
        topLeft: theme.borderRadius.topRight,
        bottomLeft: theme.borderRadius.bottomRight,
        topRight: theme.borderRadius.topLeft,
        bottomRight: theme.borderRadius.bottomLeft,
      ),
    };

    return Stack(
      fit: .expand,
      children: [
        widget.child,
        DrawerController(
          key: _drawerKey,
          alignment: widget.alignment,
          drawerCallback: _onChanged,
          scrimColor: widget.barrierColour ?? theme.barrierColour,
          enableOpenDragGesture: widget.enableOpenDragGesture,
          drawerBarrierDismissible: widget.barrierDismissible,
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              width: (widget.width ?? theme.width).clamp(0, constraints.maxWidth),
              decoration:
                  widget.decoration ??
                  BoxDecoration(
                    color: widget.backgroundColour ?? theme.backgroundColour,
                    borderRadius: radius,
                    boxShadow: widget.shadow ?? theme.shadow,
                  ),
              child: Drawer(
                width: (widget.width ?? theme.width).clamp(0, constraints.maxWidth),
                elevation: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                semanticLabel: widget.semanticLabel,
                shape: RoundedRectangleBorder(borderRadius: radius),
                clipBehavior: .antiAlias,
                child: widget.drawer,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onChanged(bool isOpen) {
    if (_isOpen == isOpen) return;
    setState(() => _isOpen = isOpen);
    widget.onChanged?.call(isOpen);
  }
}
