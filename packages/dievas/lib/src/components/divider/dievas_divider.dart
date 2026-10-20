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
/// Uses [DievasDividerThemeData] from the active [DievasTheme] for colour
/// and thickness. Per-instance [colour] and [thickness] override the theme.
///
/// Use [DievasDividerIndent] named constants for token-aligned spacing:
/// ```dart
/// DievasDivider(indent: DievasDividerIndent.MD)
/// ```
///
/// Moon reference: Divider
///
/// ```dart
/// const DievasDivider()
/// const DievasDivider(orientation: DievasDividerOrientation.vertical)
/// const DievasDivider(indent: DievasDividerIndent.MD, endIndent: DievasDividerIndent.MD)
/// const DievasDivider(colour: myColour, thickness: 1)
/// ```
class DievasDivider extends StatelessWidget {
  const DievasDivider({
    super.key,
    this.orientation = .horizontal,
    this.indent = .NONE,
    this.endIndent = .NONE,
    this.colour,
    this.thickness,
    this.label,
    this.labelStyle,
    this.labelGap,
  });

  final DievasDividerOrientation orientation;

  /// Leading inset. Uses [DievasDividerIndent] for token-aligned spacing.
  final DievasDividerIndent indent;

  /// Trailing inset. Uses [DievasDividerIndent] for token-aligned spacing.
  final DievasDividerIndent endIndent;

  /// Override colour. Falls back to [DievasDividerThemeData.colour].
  final Color? colour;

  /// Override thickness (dp). Falls back to [DievasDividerThemeData.thickness].
  final double? thickness;

  /// Optional text centred between equal line segments.
  final String? label;

  /// Label typography. Defaults to the theme's secondary label style.
  final TextStyle? labelStyle;

  /// Space on either side of the label, along the divider axis.
  final double? labelGap;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).divider;
    final resolvedThickness = thickness ?? theme.thickness;

    return Padding(
      padding: switch (orientation) {
        .horizontal => .only(left: indent.resolve(), right: endIndent.resolve()),
        .vertical => .only(top: indent.resolve(), bottom: endIndent.resolve()),
      },
      child: switch (label) {
        final text? => Flex(
          direction: orientation == .horizontal ? .horizontal : .vertical,
          children: [
            Expanded(
              child: _Rule(orientation: orientation, thickness: resolvedThickness, colour: colour ?? theme.colour),
            ),
            Flexible(
              child: Padding(
                padding: orientation == .horizontal
                    ? EdgeInsets.symmetric(horizontal: labelGap ?? DievasTheme.spacingOf(context).md)
                    : EdgeInsets.symmetric(vertical: labelGap ?? DievasTheme.spacingOf(context).md),
                child: Text(
                  text,
                  textAlign: .center,
                  style:
                      labelStyle ??
                      DievasTheme.typographyOf(
                        context,
                      ).labelXs.copyWith(color: DievasTheme.coloursOf(context).text.textSecondary),
                ),
              ),
            ),
            Expanded(
              child: _Rule(orientation: orientation, thickness: resolvedThickness, colour: colour ?? theme.colour),
            ),
          ],
        ),
        null => _Rule(orientation: orientation, thickness: resolvedThickness, colour: colour ?? theme.colour),
      },
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.orientation, required this.thickness, required this.colour});
  final DievasDividerOrientation orientation;
  final double thickness;
  final Color colour;

  @override
  Widget build(BuildContext context) => Align(
    heightFactor: orientation == .horizontal ? 1 : null,
    widthFactor: orientation == .vertical ? 1 : null,
    child: SizedBox(
      height: orientation == .horizontal ? thickness : double.infinity,
      width: orientation == .vertical ? thickness : double.infinity,
      child: ColoredBox(color: colour),
    ),
  );
}
