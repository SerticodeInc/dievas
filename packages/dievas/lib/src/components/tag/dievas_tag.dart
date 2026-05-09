import 'package:flutter/widgets.dart';

/// Visual style of [DievasTag].
enum DievasTagStyle {
  /// Solid background.
  filled,

  /// Tinted background.
  tinted,

  /// Border only.
  outlined,
}

/// An interactive or read-only chip that can carry a label, an icon, and an
/// optional dismiss (×) affordance.
///
/// Moon reference: Tag
///
/// ```dart
/// DievasTag(label: 'Flutter')
/// DievasTag(label: 'Flutter', onRemove: () { ... })
/// ```
class DievasTag extends StatelessWidget {
  const DievasTag({
    super.key,
    required this.label,
    this.style = .tinted,
    this.leadingIcon,
    this.onPressed,
    this.onRemove,
  });

  final String label;
  final DievasTagStyle style;

  /// Optional leading icon widget.
  final Widget? leadingIcon;

  /// Tap callback. `null` → non-interactive (static display).
  final VoidCallback? onPressed;

  /// Remove callback. Renders a dismiss (×) button when non-null.
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    // Implementation lands in M3.
    assert(false, 'DievasTag is not yet implemented — it renders nothing. Implementation lands in M3.');
    return const SizedBox.shrink();
  }
}
