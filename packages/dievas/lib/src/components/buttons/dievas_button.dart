import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:dievas/src/theme/component/button/dievas_button_theme_data.dart';
import 'package:dievas/src/theme/component/button/dievas_button_theme_style.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_builder.dart';
import 'button_types/dievas_button_icon_style_behavior.dart';
import 'button_types/dievas_button_size.dart';
import 'button_types/dievas_button_state.dart';
import 'button_types/dievas_button_style.dart';

/// Internal base widget shared by [DievasFilledButton] and [DievasOutlinedButton].
///
/// Resolves the correct theme data slot from [DievasComponentThemeData], maps
/// [size] to layout values, and delegates painting to [DievasButtonBuilder].
///
/// Not exported — use the variant widgets directly.
@internal
class DievasButton extends StatelessWidget {
  const DievasButton({
    super.key,
    required this.style,
    required this.size,
    required this.state,
    this.label,
    this.child,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.iconStyleBehavior = .inheritFromState,
    this.leadingIcon,
    this.trailingIcon,
    this.onPressed,
  }) : assert(label != null || child != null, 'Either label or child must be provided'),
       assert(
         child == null || (leadingIcon == null && trailingIcon == null),
         'leadingIcon/trailingIcon are ignored when child is provided',
       );

  final DievasButtonStyle style;
  final DievasButtonSize size;
  final DievasButtonState state;
  final String? label;
  final Widget? child;
  final BorderRadiusGeometry? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final DievasButtonIconStyleBehavior iconStyleBehavior;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  /// Pressed callback. `null` or [DievasButtonState.loading] → non-interactive.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final components = DievasTheme.componentsOf(context);

    // Resolve the correct theme data variant from the style discriminator.
    final DievasButtonThemeData<DievasButtonThemeStyle> themeData = switch (style) {
      DievasFilledButtonStyle.primary => components.filledButton.primary,
      DievasFilledButtonStyle.secondary => components.filledButton.secondary,
      DievasFilledButtonStyle.destructive => components.filledButton.destructive,
      DievasOutlinedButtonStyle.primary => components.outlinedButton.primary,
      DievasOutlinedButtonStyle.destructive => components.outlinedButton.destructive,
    };

    // Unpack the size-keyed layout values in one switch.
    final (textStyle, height, iconSize, iconSpacing, radius, padding) = switch (size) {
      .sm => (
        themeData.textStyle.sm,
        themeData.height.sm,
        themeData.iconSize.sm,
        themeData.iconSpacing.sm,
        themeData.radius.sm,
        themeData.padding.sm,
      ),
      .md => (
        themeData.textStyle.md,
        themeData.height.md,
        themeData.iconSize.md,
        themeData.iconSpacing.md,
        themeData.radius.md,
        themeData.padding.md,
      ),
      .lg => (
        themeData.textStyle.lg,
        themeData.height.lg,
        themeData.iconSize.lg,
        themeData.iconSpacing.lg,
        themeData.radius.lg,
        themeData.padding.lg,
      ),
    };

    final borderRadius = shape?.resolve(Directionality.of(context)) ?? BorderRadius.all(radius.square);

    return DievasButtonBuilder(
      state: state,
      label: label,
      child: child,
      style: themeData.style,
      borderRadius: borderRadius,
      disabledOpacity: themeData.disabledOpacity,
      pressOpacity: themeData.pressOpacity,
      loaderRotationDuration: DievasTheme.animationOf(context).loader,
      iconSpacing: iconSpacing,
      iconSize: iconSize,
      textStyle: textStyle,
      iconStyleBehavior: iconStyleBehavior,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      onPressed: onPressed,
      builder: (_, props) {
        final borderWidth = props.borderSide.width;
        final effectiveHeight = math.max(height, props.estimatedTextHeight + padding.vertical);
        final rawVerticalPad = (height - borderWidth * 2 - props.estimatedTextHeight) / 2;
        final effectivePadding = padding + .symmetric(vertical: rawVerticalPad.clamp(0.0, .infinity));

        final child = Center(
          child: switch (size) {
            .sm || .md => UnconstrainedBox(constrainedAxis: .vertical, child: props.child),
            .lg => props.child,
          },
        );

        return DievasButtonDecorator(height: effectiveHeight, padding: effectivePadding, child: child);
      },
    );
  }
}
