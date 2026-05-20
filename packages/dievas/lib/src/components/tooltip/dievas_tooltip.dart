import 'package:flutter/material.dart' show Tooltip;
import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

/// A Dievas-styled tooltip that wraps the platform [Tooltip] widget.
///
/// Reads [DievasTooltipThemeData] from the tree for all visual tokens.
///
/// ```dart
/// DievasTooltip(
///   message: 'Delete item',
///   child: DievasIconButton(...),
/// )
/// ```
///
/// Moon reference: Tooltip
class DievasTooltip extends StatelessWidget {
  const DievasTooltip({super.key, required this.message, required this.child, this.preferBelow = true});

  /// The tooltip message text.
  final String message;

  /// The widget that triggers the tooltip.
  final Widget child;

  /// Whether to prefer showing the tooltip below the target.
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).tooltip;

    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      verticalOffset: theme.verticalOffset,
      waitDuration: theme.waitDuration,
      showDuration: theme.showDuration,
      decoration: BoxDecoration(color: theme.backgroundColor, borderRadius: theme.borderRadius),
      textStyle: theme.textStyle,
      padding: theme.padding,
      child: child,
    );
  }
}
