import 'dievas_button.dart';
import 'types/dievas_button_style.dart';

/// A filled button with a solid background colour.
///
/// Use [DievasFilledButtonStyle] to select the visual variant:
/// - [DievasFilledButtonStyle.primary] — brand-colour CTA (default)
/// - [DievasFilledButtonStyle.secondary] — subdued secondary action
/// - [DievasFilledButtonStyle.destructive] — irreversible/dangerous action
///
/// ```dart
/// DievasFilledButton(
///   label: 'Continue',
///   onPressed: () { },
/// )
///
/// DievasFilledButton(
///   label: 'Delete account',
///   style: DievasFilledButtonStyle.destructive,
///   size: DievasButtonSize.sm,
///   state: _isDeleting ? DievasButtonState.loading : DievasButtonState.idle,
///   onPressed: _handleDelete,
/// )
/// ```
class DievasFilledButton extends DievasButton {
  const DievasFilledButton({
    super.key,
    required super.label,
    DievasFilledButtonStyle super.style = .primary,
    super.size = .md,
    super.state = .idle,
    super.shape = .square,
    super.iconStyleBehavior = .inheritFromState,
    super.leadingIcon,
    super.trailingIcon,
    super.onPressed,
  });
}
