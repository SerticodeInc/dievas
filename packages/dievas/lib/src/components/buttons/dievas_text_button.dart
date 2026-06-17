import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_state_animated_loader_mixin.dart';
import 'dievas_button_state_switcher.dart';
import 'dievas_button_press_mixin.dart';
import 'button_types/dievas_button_size.dart';
import 'button_types/dievas_button_state.dart';

/// Visual style variants for [DievasTextButton].
enum DievasTextButtonStyle {
  /// Brand-coloured foreground — primary inline action.
  primary,

  /// Error-red foreground — destructive inline action.
  destructive,
}

/// A text-only button with no background or border.
///
/// Sizes itself to its content. Used for inline actions, links, and
/// secondary affordance where a full-height button would be too heavy.
///
/// ```dart
/// DievasTextButton(
///   label: 'View details',
///   onPressed: () { },
/// )
/// ```
class DievasTextButton extends StatefulWidget with DievasButtonStateAnimatedLoaderMixin {
  const DievasTextButton({
    super.key,
    required this.label,
    this.style = .primary,
    this.size = .md,
    this.state = .idle,
    this.leadingIcon,
    this.trailingIcon,
    this.onPressed,
    this.loaderRotationDuration = DievasAnimationSemantic.loader,
  });

  @override
  final Duration loaderRotationDuration;

  final String label;
  final DievasTextButtonStyle style;
  final DievasButtonSize size;

  @override
  final DievasButtonState state;

  final Widget? leadingIcon;
  final Widget? trailingIcon;

  /// Pressed callback. `null`, [DievasButtonState.loading], or
  /// [DievasButtonState.disabled] → non-interactive.
  final VoidCallback? onPressed;

  @override
  State<DievasTextButton> createState() => _DievasTextButtonState();
}

class _DievasTextButtonState extends State<DievasTextButton>
    with SingleTickerProviderStateMixin, DievasButtonStateAnimatedLoaderProviderMixin, DievasButtonPressMixin {
  @override
  Widget build(BuildContext context) {
    final components = DievasTheme.componentsOf(context);
    final buttonTheme = switch (widget.style) {
      .primary => components.textButton.primary,
      .destructive => components.textButton.destructive,
    };

    final textStyle = switch (widget.size) {
      .sm => buttonTheme.textStyle.sm,
      .md => buttonTheme.textStyle.md,
      .lg => buttonTheme.textStyle.lg,
    };

    final iconSize = switch (widget.size) {
      .sm => buttonTheme.iconSize.sm,
      .md => buttonTheme.iconSize.md,
      .lg => buttonTheme.iconSize.lg,
    };

    final iconSpacing = switch (widget.size) {
      .sm => buttonTheme.iconSpacing.sm,
      .md => buttonTheme.iconSpacing.md,
      .lg => buttonTheme.iconSpacing.lg,
    };

    final apple = isApplePlatform;
    final pressDuration = DievasTheme.animationOf(context).quick;

    return Semantics(
      button: true,
      child: Material(
        type: .transparency,
        child: InkWell(
          statesController: statesController,
          onTap: (widget.state == .loading || widget.state == .disabled) ? null : widget.onPressed,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: ValueListenableBuilder<Set<WidgetState>>(
            valueListenable: statesController,
            builder: (_, states, _) {
              final isPressed = states.contains(WidgetState.pressed);
              final isDisabled =
                  widget.state == .disabled || states.contains(WidgetState.disabled) || widget.onPressed == null;

              final opacityFactor = isDisabled
                  ? buttonTheme.disabledOpacity
                  : (apple && isPressed ? buttonTheme.pressOpacity : 1.0);

              final themeStyle = buttonTheme.style;
              final activeStyle = isPressed ? themeStyle.focused : themeStyle.idle;
              final foreground = activeStyle.foreground.withValues(alpha: opacityFactor);

              final content = Row(
                mainAxisSize: .min,
                spacing: iconSpacing,
                children: [
                  if (widget.leadingIcon case final icon?)
                    IconTheme(
                      data: IconThemeData(color: foreground, size: iconSize),
                      child: icon,
                    ),
                  AnimatedDefaultTextStyle(
                    duration: pressDuration,
                    style: textStyle.copyWith(color: foreground),
                    child: Text(widget.label),
                  ),
                  if (widget.trailingIcon case final icon?)
                    IconTheme(
                      data: IconThemeData(color: foreground, size: iconSize),
                      child: icon,
                    ),
                ],
              );

              return DievasButtonStateSwitcher(
                state: widget.state,
                loader: IconTheme(
                  data: IconThemeData(color: foreground, size: iconSize),
                  child: animatedLoader,
                ),
                content: content,
              );
            },
          ),
        ),
      ),
    );
  }
}
