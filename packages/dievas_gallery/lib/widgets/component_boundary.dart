import 'package:flutter/widgets.dart';

/// Provides a toggle signal to [ComponentBoundary] widgets in the subtree.
///
/// Inserted by [ComponentBoundaryAddon] — do not use directly in use-cases.
class ComponentBoundaryScope extends InheritedWidget {
  const ComponentBoundaryScope({super.key, required this.show, required super.child});

  final bool show;

  static bool of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ComponentBoundaryScope>()?.show ?? false;

  @override
  bool updateShouldNotify(ComponentBoundaryScope old) => show != old.show;
}

/// Draws a 2dp dashed border around its child when the addon toggle is active.
///
/// Wrap individual components in use-cases to visualize their exact footprint:
/// ```dart
/// ComponentBoundary(child: DievasFilledButton(...))
/// ```
class ComponentBoundary extends StatelessWidget {
  const ComponentBoundary({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!ComponentBoundaryScope.of(context)) return child;

    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 237, 11, 11), width: 2)),
      child: child,
    );
  }
}
