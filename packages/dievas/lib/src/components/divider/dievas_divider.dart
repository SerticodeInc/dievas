import 'package:flutter/widgets.dart';

/// Orientation of [DievasDivider].
enum DievasDividerOrientation {
  /// Full-width horizontal rule.
  horizontal,

  /// Full-height vertical rule.
  vertical,
}

/// A thin hairline rule that separates content regions.
///
/// Automatically uses `colors.border.borderDefault` from the active theme.
///
/// Moon reference: Divider
///
/// ```dart
/// const DievasDivider()
/// const DievasDivider(orientation: DievasDividerOrientation.vertical)
/// ```
class DievasDivider extends StatelessWidget {
  const DievasDivider({super.key, this.orientation = .horizontal, this.indent = 0, this.endIndent = 0});

  final DievasDividerOrientation orientation;

  /// Leading space before the line (dp).
  final double indent;

  /// Trailing space after the line (dp).
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    // Implementation lands in M3.
    assert(false, 'DievasDivider is not yet implemented — it renders nothing. Implementation lands in M3.');
    return const SizedBox.shrink();
  }
  //       thickness from context.border.borderWidthSm
  //return const SizedBox.shrink();
}
