import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Size variants for [DievasIcon].
enum DievasIconSize {
  /// 16 dp — inline with body text.
  XS,

  /// 20 dp — inline with label text.
  SM,

  /// 24 dp — default stand-alone size.
  MD,

  /// 32 dp — large feature icon.
  LG,
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
/// DievasIcon(Icons.warning, color: context.colours.feedback.feedbackWarning.icon)
/// ```
class DievasIcon extends StatelessWidget {
  const DievasIcon(this.icon, {super.key, this.size = .MD, this.color, this.semanticLabel});

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
      .XS => sizing.iconXS,
      .SM => sizing.iconSM,
      .MD => sizing.iconMD,
      .LG => sizing.iconLG,
    };

    return Icon(
      icon,
      size: dimension,
      color: color ?? DievasTheme.coloursOf(context).icon.iconPrimary,
      semanticLabel: semanticLabel,
    );
  }
}
