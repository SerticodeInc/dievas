import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:dievas/src/theme/component/divider/dievas_divider_indent.dart';

/// Orientation of [DievasDivider].
enum DievasDividerOrientation {
  /// Full-width horizontal rule.
  horizontal,

  /// Full-height vertical rule.
  vertical,
}

/// A thin hairline rule that separates content regions.
///
/// Uses [DievasDividerThemeData] from the active [DievasTheme].
/// Per-instance [colour], [thickness], [indent], and [endIndent] override
/// the theme value.
///
/// Use [DievasDividerIndent] named constants for token-aligned spacing:
/// ```dart
/// DievasDivider(indent: DievasDividerIndent.md)
/// ```
///
/// Moon reference: Divider
///
/// ```dart
/// const DievasDivider()
/// const DievasDivider(orientation: DievasDividerOrientation.vertical)
/// const DievasDivider(indent: DievasDividerIndent.md, endIndent: DievasDividerIndent.md)
/// const DievasDivider(colour: myColour, thickness: 1)
/// ```
class DievasDivider extends StatelessWidget {
  const DievasDivider({
    super.key,
    this.orientation = .horizontal,
    this.indent = .none,
    this.endIndent = .none,
    this.colour,
    this.thickness,
  });

  final DievasDividerOrientation orientation;

  /// Leading inset. Uses [DievasDividerIndent] for token-aligned spacing.
  /// Falls back to [DievasDividerThemeData.indent].
  final DievasDividerIndent indent;

  /// Trailing inset. Uses [DievasDividerIndent] for token-aligned spacing.
  /// Falls back to [DievasDividerThemeData.endIndent].
  final DievasDividerIndent endIndent;

  /// Override colour. Falls back to [DievasDividerThemeData.colour].
  final Color? colour;

  /// Override thickness (dp). Falls back to [DievasDividerThemeData.thickness].
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).divider;
    final resolvedThickness = thickness ?? theme.thickness;

    return Padding(
      padding: switch (orientation) {
        .horizontal => .only(left: indent.resolve(), right: endIndent.resolve()),
        .vertical => .only(top: indent.resolve(), bottom: endIndent.resolve()),
      },
      child: SizedBox(
        height: orientation == .horizontal ? resolvedThickness : null,
        width: orientation == .vertical ? resolvedThickness : null,
        child: ColoredBox(color: colour ?? theme.colour),
      ),
    );
  }
}
