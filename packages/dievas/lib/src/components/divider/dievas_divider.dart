import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Orientation of [DievasDivider].
enum DievasDividerOrientation {
  /// Full-width horizontal rule.
  horizontal,

  /// Full-height vertical rule.
  vertical,
}

/// A thin hairline rule that separates content regions.
///
/// Automatically uses `colors.border.borderDefault` and `border.strokeThin`
/// from the active [DievasTheme].
///
/// Moon reference: Divider
///
/// ```dart
/// const DievasDivider()
/// const DievasDivider(orientation: DievasDividerOrientation.vertical)
/// const DievasDivider(indent: 16, endIndent: 16)
/// ```
class DievasDivider extends StatelessWidget {
  const DievasDivider({super.key, this.orientation = .horizontal, this.indent = 0, this.endIndent = 0});

  final DievasDividerOrientation orientation;

  /// Leading inset before the line starts (dp).
  final double indent;

  /// Trailing inset after the line ends (dp).
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final color = DievasTheme.colorsOf(context).border.borderDefault;
    final thickness = DievasTheme.borderOf(context).strokeThick;

    return switch (orientation) {
      .horizontal => Container(
        height: thickness,
        margin: .only(left: indent, right: endIndent),
        color: color,
      ),
      .vertical => Container(
        width: thickness,
        margin: .only(top: indent, bottom: endIndent),
        color: color,
      ),
    };
  }
}
