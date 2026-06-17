import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Visual style of [DievasLinearProgress].
enum DievasLinearProgressStyle {
  /// Solid brand-coloured fill.
  primary,

  /// Success-green fill.
  success,

  /// Error-red fill.
  error,
}

/// A horizontal progress bar.
///
/// Pass `value: null` for an indeterminate (animated) indicator. Pass a value
/// in [0.0, 1.0] for a determinate fill.
///
/// Moon reference: LinearProgress
///
/// ```dart
/// DievasLinearProgress(value: 0.6)
/// const DievasLinearProgress()                               // indeterminate
/// DievasLinearProgress(value: 0.8, style: .success)
/// ```
class DievasLinearProgress extends StatelessWidget {
  const DievasLinearProgress({super.key, this.value, this.style = .primary});

  /// Progress from 0.0 to 1.0. `null` → indeterminate.
  final double? value;

  final DievasLinearProgressStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).linearProgress;

    final color = switch (style) {
      .primary => theme.colorPrimary,
      .success => theme.colorSuccess,
      .error => theme.colorError,
    };

    return ClipRRect(
      borderRadius: theme.borderRadius,
      child: SizedBox(
        height: theme.height,
        child: LinearProgressIndicator(
          value: value,
          color: color,
          backgroundColor: theme.trackColor,
          borderRadius: theme.borderRadius,
        ),
      ),
    );
  }
}
