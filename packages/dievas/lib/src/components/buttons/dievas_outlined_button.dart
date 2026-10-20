import 'dievas_button.dart';
import 'dievas_button_types.dart';

/// A button with a transparent background and a visible border.
///
/// Use [DievasOutlinedButtonStyle] to select the visual variant:
/// - [DievasOutlinedButtonStyle.primary] — neutral border/foreground (default)
/// - [DievasOutlinedButtonStyle.destructive] — error-red border/foreground
///
/// ```dart
/// DievasOutlinedButton(
///   label: 'Cancel',
///   onPressed: () => Navigator.of(context).pop(),
/// )
/// ```
class DievasOutlinedButton extends DievasButton {
  const DievasOutlinedButton({
    super.key,
    super.label,
    super.child,
    DievasOutlinedButtonStyle super.style = .primary,
    super.size = .md,
    super.state = .idle,
    super.shape,
    super.backgroundColor,
    super.foregroundColor,
    super.borderColor,
    super.iconStyleBehavior = .inheritFromState,
    super.leadingIcon,
    super.trailingIcon,
    super.onPressed,
    super.onLongPress,
    super.borderRadius,
    super.showBorder,
    super.isFullWidth,
    super.showPulseEffect,
    super.animateLoading,
    super.showPulseEffectJiggle,
    super.semanticLabel,
  });
}
