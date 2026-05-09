import 'package:flutter/widgets.dart';

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

  /// Explicit colour override. Falls back to the ambient [IconTheme] colour.
  final Color? color;

  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    // Implementation lands in M3.
    assert(false, 'DievasIcon is not yet implemented — it renders nothing. Implementation lands in M3.');
    return const SizedBox.shrink();
  }
  //       DievasTheme.sizingOf(context)
  //return const SizedBox.shrink();
}
