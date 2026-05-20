import 'package:flutter/material.dart';

import '../../theme/dievas_theme.dart';

/// Size variants for [DievasCircularProgress].
enum DievasCircularProgressSize {
  /// 16 dp — inline loading indicator.
  sm,

  /// 24 dp — standard standalone indicator.
  md,

  /// 32 dp — prominent page-level indicator.
  lg,
}

/// Visual style of [DievasCircularProgress].
enum DievasCircularProgressStyle {
  /// Solid brand-coloured stroke.
  primary,

  /// On-brand (inverted) stroke — use on filled brand surfaces.
  onBrand,
}

/// A circular spinner / progress ring.
///
/// Pass `value: null` for an indeterminate (spinning) indicator. Pass a value
/// in [0.0, 1.0] for a determinate arc.
///
/// Moon reference: CircularProgress
///
/// ```dart
/// const DievasCircularProgress()          // indeterminate
/// DievasCircularProgress(value: 0.4)      // 40% determinate
/// ```
class DievasCircularProgress extends StatelessWidget {
  const DievasCircularProgress({super.key, this.value, this.size = .md, this.style = .primary});

  /// Progress from 0.0 to 1.0. `null` → indeterminate.
  final double? value;

  final DievasCircularProgressSize size;
  final DievasCircularProgressStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).circularProgress;

    final diameter = switch (size) {
      .sm => theme.sizeSm,
      .md => theme.sizeMd,
      .lg => theme.sizeLg,
    };

    final color = switch (style) {
      .primary => theme.colorPrimary,
      .onBrand => theme.colorOnBrand,
    };

    return SizedBox.square(
      dimension: diameter,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: theme.strokeWidth,
        color: color,
        backgroundColor: theme.trackColor,
        strokeCap: .round,
      ),
    );
  }
}
