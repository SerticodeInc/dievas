import 'package:flutter/widgets.dart';

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

  /// On-brand (inverted) stroke for use on filled surfaces.
  onBrand,
}

/// A circular spinner / progress ring.
///
/// Pass `value: null` for an indeterminate (spinning) indicator. Pass a value
/// between 0.0 and 1.0 to show a determinate arc.
///
/// Moon reference: CircularProgress
///
/// ```dart
/// const DievasCircularProgress()          // indeterminate
/// DievasCircularProgress(value: 0.4)      // determinate
/// ```
class DievasCircularProgress extends StatelessWidget {
  const DievasCircularProgress({super.key, this.value, this.size = .md, this.style = .primary});

  /// Progress from 0.0 to 1.0. `null` → indeterminate.
  final double? value;

  final DievasCircularProgressSize size;
  final DievasCircularProgressStyle style;

  @override
  Widget build(BuildContext context) {
    // Implementation lands in M3.
    assert(false, 'DievasCircularProgress is not yet implemented — it renders nothing. Implementation lands in M3.');
    return const SizedBox.shrink();
  }
  //       DievasTheme.componentsOf(context).circularProgress
  //return const SizedBox.shrink();
}
