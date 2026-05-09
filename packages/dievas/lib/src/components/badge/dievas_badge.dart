import 'package:flutter/widgets.dart';

/// Visual style of [DievasBadge].
enum DievasBadgeStyle {
  /// Solid brand-coloured background — high emphasis.
  filled,

  /// Tinted brand background — medium emphasis.
  tinted,

  /// Border only, transparent background — low emphasis.
  outlined,
}

/// Colour variant driving the semantic tone of a [DievasBadge].
enum DievasBadgeTone {
  /// Default — neutral informational.
  neutral,

  /// Brand primary.
  primary,

  /// Success / positive state.
  success,

  /// Warning / cautionary state.
  warning,

  /// Error / destructive state.
  error,
}

/// A small label used to communicate status, count, or categorical metadata.
///
/// Moon reference: Chip / Tag (badge variant)
///
/// ```dart
/// DievasBadge(label: 'New')
/// DievasBadge(label: '3', style: DievasBadgeStyle.filled, tone: DievasBadgeTone.primary)
/// ```
class DievasBadge extends StatelessWidget {
  const DievasBadge({super.key, required this.label, this.style = .tinted, this.tone = .neutral, this.leadingIcon});

  final String label;
  final DievasBadgeStyle style;
  final DievasBadgeTone tone;

  /// Optional icon displayed before the label text.
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    // Implementation lands in M3.
    assert(false, 'DievasBadge is not yet implemented — it renders nothing. Implementation lands in M3.');
    return const SizedBox.shrink();
  }
}
