import 'dievas_button.dart';
import 'types/dievas_button_style.dart';

/// A button with a transparent background and a visible border.
///
/// Use [DievasOutlinedButtonStyle] to select the visual variant:
/// - [DievasOutlinedButtonStyle.primary] — brand-coloured border/foreground (default)
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
    required super.label,
    DievasOutlinedButtonStyle super.style = .primary,
    super.size = .md,
    super.state = .idle,
    super.shape = .square,
    super.iconStyleBehavior = .inheritFromState,
    super.leadingIcon,
    super.trailingIcon,
    super.onPressed,
  });
}
