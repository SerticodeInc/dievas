import 'dievas_button.dart';
import 'dievas_button_types.dart';

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
///   size: DievasButtonSize.SM,
///   state: _isDeleting ? DievasButtonState.loading : DievasButtonState.idle,
///   onPressed: _handleDelete,
/// )
/// ```
class DievasFilledButton extends DievasButton {
  const DievasFilledButton({
    super.key,
    super.label,
    super.child,
    DievasFilledButtonStyle super.style = .primary,
    super.size = .MD,
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
