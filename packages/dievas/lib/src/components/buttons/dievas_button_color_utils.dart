import 'dart:ui';

/// Resolves a colour override against a theme fallback, scaling alpha by [opacity].
///
/// The factor scales the base colour's own alpha rather than replacing it:
/// replacing turned transparent backgrounds (`Color(0x00000000)`) into
/// semi-transparent black boxes on press and disabled states.
Color resolveColour({Color? override, Color? fallback, required double opacity}) {
  final base = override ?? fallback ?? const Color(0x00000000);
  return base.withValues(alpha: base.a * opacity);
}
