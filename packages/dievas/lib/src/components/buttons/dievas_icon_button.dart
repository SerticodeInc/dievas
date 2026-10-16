import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_press_mixin.dart';
import 'dievas_button_color_utils.dart';
import 'button_types/dievas_button_size.dart';

/// Visual style variants for [DievasIconButton].
///
/// The variants differ only by container: [ghost] is transparent, [tinted] sits
/// on a subtle surface fill. Both share the same icon colour.
enum DievasIconButtonStyle {
  /// Transparent background — icon only.
  ghost,

  /// Subtle surface fill behind the icon.
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
    this.size = .MD,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
    this.onPressed,
  });

  final Widget icon;
  final DievasIconButtonStyle style;
  final DievasButtonSize size;
  final OutlinedBorder? shape;
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
      .SM => (buttonTheme.size.SM, buttonTheme.iconSize.SM, buttonTheme.radius.SM),
      .MD => (buttonTheme.size.MD, buttonTheme.iconSize.MD, buttonTheme.radius.MD),
      .LG => (buttonTheme.size.LG, buttonTheme.iconSize.LG, buttonTheme.radius.LG),
    };

    final effectiveShape = widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.all(radius));

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      enabled: widget.onPressed != null,
      child: Material(
        type: .transparency,
        child: InkWell(
          statesController: statesController,
          onTap: widget.onPressed,
          customBorder: effectiveShape,
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

              final bgColour = resolveColour(
                override: widget.backgroundColor,
                fallback: activeStyle.background,
                opacity: opacityFactor,
              );
              final iconColour = resolveColour(
                override: widget.foregroundColor,
                fallback: activeStyle.icon,
                opacity: opacityFactor,
              );

              return AnimatedContainer(
                duration: pressDuration,
                width: containerSize,
                height: containerSize,
                decoration: ShapeDecoration(shape: effectiveShape, color: bgColour),
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
