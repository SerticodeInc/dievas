import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

class DievasDrawer extends StatefulWidget {
  const DievasDrawer({super.key, required this.child, required this.drawer, this.width});

  final Widget child;
  final Widget drawer;
  final double? width;

  @override
  DievasDrawerState createState() => DievasDrawerState();
}

class DievasDrawerState extends State<DievasDrawer> {
  final _drawerKey = GlobalKey<DrawerControllerState>();
  bool _isOpen = false;

  void open() => _drawerKey.currentState?.open();

  void close() => _drawerKey.currentState?.close();

  void toggle() => switch (_isOpen) {
    true => close(),
    false => open(),
  };

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).drawer;
    final drawerWidth = widget.width ?? theme.width;

    return Stack(
      children: [
        widget.child,
        DrawerController(
          key: _drawerKey,
          alignment: .start,
          drawerCallback: (isOpen) => setState(() => _isOpen = isOpen),
          scrimColor: theme.barrierColor,
          child: Drawer(
            width: drawerWidth,
            elevation: theme.elevation,
            backgroundColor: theme.backgroundColor,
            child: widget.drawer,
          ),
        ),
      ],
    );
  }
}
