import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

/// Size variants for [DievasIcon].
enum DievasIconSize {
  /// 16 dp — inline with body text.
  xs,

  /// 20 dp — inline with label text.
  sm,

  /// 24 dp — default stand-alone size.
  md,

  /// 32 dp — large feature icon.
  lg,
}

/// A thin wrapper around [Icon] / [ImageIcon] that enforces Dievas sizing
/// and colour semantics via the theme.
///
/// Prefer this over raw [Icon] inside Dievas components so sizing and colour
/// are always token-driven.
///
/// Moon reference: (utility — no direct Moon equivalent)
///
/// ```dart
/// DievasIcon(Icons.check)
/// DievasIcon(Icons.warning, color: context.colors.feedback.feedbackWarning.icon)
/// ```
class DievasIcon extends StatelessWidget {
  const DievasIcon(this.icon, {super.key, this.size = .md, this.color, this.semanticLabel});

  final IconData icon;
  final DievasIconSize size;

  /// Explicit colour override. Falls back to the primary icon colour from the
  /// active [DievasTheme].
  final Color? color;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final sizing = DievasTheme.sizingOf(context);

    final dimension = switch (size) {
      .xs => sizing.iconXs,
      .sm => sizing.iconSm,
      .md => sizing.iconMd,
      .lg => sizing.iconLg,
    };

    return Icon(
      icon,
      size: dimension,
      color: color ?? DievasTheme.colorsOf(context).icon.iconPrimary,
      semanticLabel: semanticLabel,
    );
  }
}
