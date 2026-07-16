import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_press_mixin.dart';
import 'button_types/dievas_button_size.dart';

/// Visual style variants for [DievasIconButton].
enum DievasIconButtonStyle {
  /// Transparent background, icon only — ghost behaviour.
  ghost,

  /// Tinted background matching the action primary fill.
  tinted,
}

/// A square or circular button that displays a single icon with no label.
///
/// ```dart
/// DievasIconButton(
///   icon: const Icon(Icons.close),
///   onPressed: () => Navigator.of(context).pop(),
/// )
/// ```
class DievasIconButton extends StatefulWidget {
  const DievasIconButton({
    super.key,
    required this.icon,
    this.style = .ghost,
    this.size = .md,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    this.onPressed,
  });

  final Widget icon;
  final DievasIconButtonStyle style;
  final DievasButtonSize size;
  final BorderRadiusGeometry? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;

  /// Screen-reader label. Defaults to the icon's own semantic label if set.
  final String? semanticLabel;

  /// Pressed callback. `null` → button is disabled.
  final VoidCallback? onPressed;

  @override
  State<DievasIconButton> createState() => _DievasIconButtonState();
}

class _DievasIconButtonState extends State<DievasIconButton> with DievasButtonPressMixin {
  @override
  Widget build(BuildContext context) {
    final components = DievasTheme.componentsOf(context);
    final pressDuration = DievasTheme.animationOf(context).quick;
    final buttonTheme = switch (widget.style) {
      .ghost => components.iconButton.ghost,
      .tinted => components.iconButton.tinted,
    };

    final (containerSize, iconSize, radius) = switch (widget.size) {
      .sm => (buttonTheme.size.sm, buttonTheme.iconSize.sm, buttonTheme.radius.sm),
      .md => (buttonTheme.size.md, buttonTheme.iconSize.md, buttonTheme.radius.md),
      .lg => (buttonTheme.size.lg, buttonTheme.iconSize.lg, buttonTheme.radius.lg),
    };

    final borderRadius = widget.shape?.resolve(Directionality.of(context)) ?? BorderRadius.all(radius);

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      enabled: widget.onPressed != null,
      child: Material(
        type: .transparency,
        child: InkWell(
          statesController: statesController,
          onTap: widget.onPressed,
          borderRadius: borderRadius,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: ValueListenableBuilder<Set<WidgetState>>(
            valueListenable: statesController,
            builder: (_, states, _) {
              final isPressed = states.contains(WidgetState.pressed);
              final isDisabled = states.contains(WidgetState.disabled) || widget.onPressed == null;

              final opacityFactor = isDisabled
                  ? buttonTheme.disabledOpacity
                  : (isPressed ? buttonTheme.pressOpacity : 1.0);

              final activeStyle = isPressed ? buttonTheme.style.focused : buttonTheme.style.idle;

              final bgColour = (widget.backgroundColor ?? activeStyle.background ?? Colors.transparent).withValues(alpha: opacityFactor);
              final iconColour = (widget.foregroundColor ?? activeStyle.icon).withValues(alpha: opacityFactor);

              return AnimatedContainer(
                duration: pressDuration,
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(color: bgColour, borderRadius: borderRadius),
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(color: iconColour, size: iconSize),
                    child: widget.icon,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
