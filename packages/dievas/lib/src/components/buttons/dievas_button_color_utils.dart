import 'dart:ui';

/// Resolves a colour override against a theme fallback, applying an opacity factor.
///
/// Used by button widgets to unify the pattern:
/// ```dart
/// final fg = widget.foregroundColor ?? activeStyle.foreground;
/// final resolved = fg.withValues(alpha: opacityFactor);
/// ```
Color resolveColour({
  Color? override,
  Color? fallback,
  required double opacity,
}) => (override ?? fallback ?? const Color(0x00000000)).withValues(alpha: opacity);
