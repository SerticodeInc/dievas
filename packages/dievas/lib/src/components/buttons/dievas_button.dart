import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:dievas/src/theme/component/button/dievas_button_theme_data.dart';
import 'package:dievas/src/theme/component/button/dievas_button_theme_style.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_builder.dart';
import 'dievas_button_types.dart';

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
    this.onLongPress,
    this.borderRadius,
    this.showBorder,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.animateLoading = true,
    this.showPulseEffectJiggle = false,
    this.semanticLabel,
  }) : assert(label != null || child != null || leadingIcon != null || trailingIcon != null, 'Provide button content'),
       assert(
         child == null || (leadingIcon == null && trailingIcon == null),
         'leadingIcon/trailingIcon are ignored when child is provided',
       );

  final DievasButtonStyle style;
  final DievasButtonSize size;
  final DievasButtonState state;
  final String? label;
  final Widget? child;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final DievasButtonIconStyleBehavior iconStyleBehavior;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  /// Tap action. Both callbacks being null, loading, or disabled blocks interaction.
  final VoidCallback? onPressed;

  /// Long-press action. A long-press-only button remains enabled.
  final VoidCallback? onLongPress;

  /// Radius override when no custom [shape] is supplied.
  final BorderRadiusGeometry? borderRadius;

  /// Border visibility. Null preserves the variant default or explicit colour.
  final bool? showBorder;

  /// Expand to the bounded parent's width; retain natural width when unbounded.
  final bool isFullWidth;

  /// Animate a subtle scale response while pressed.
  final bool showPulseEffect;

  /// Fade and scale between content and loader. Reduced motion switches instantly.
  final bool animateLoading;

  /// Add rotation to the pulse response. Requires [showPulseEffect].
  final bool showPulseEffectJiggle;

  /// Accessible name for icon-only or otherwise unlabeled buttons.
  final String? semanticLabel;

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
      .SM => (
        themeData.textStyle.SM,
        themeData.height.SM,
        themeData.iconSize.SM,
        themeData.iconSpacing.SM,
        themeData.radius.SM,
        themeData.padding.SM,
      ),
      .MD => (
        themeData.textStyle.MD,
        themeData.height.MD,
        themeData.iconSize.MD,
        themeData.iconSpacing.MD,
        themeData.radius.MD,
        themeData.padding.MD,
      ),
      .LG => (
        themeData.textStyle.LG,
        themeData.height.LG,
        themeData.iconSize.LG,
        themeData.iconSpacing.LG,
        themeData.radius.LG,
        themeData.padding.LG,
      ),
    };

    final effectiveShape = switch ((shape, borderRadius)) {
      (final shape?, _) => shape,
      (_, final radius?) => RoundedRectangleBorder(borderRadius: radius),
      _ => RoundedRectangleBorder(borderRadius: BorderRadius.all(radius.square)),
    };

    return DievasButtonBuilder(
      state: state,
      label: label,
      style: themeData.style,
      shape: effectiveShape,
      disabledOpacity: themeData.disabledOpacity,
      pressOpacity: themeData.pressOpacity,
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
      height: height,
      padding: padding + EdgeInsets.symmetric(vertical: DievasTheme.spacingOf(context).XS),
      onLongPress: onLongPress,
      showBorder: showBorder,
      isFullWidth: isFullWidth,
      showPulseEffect: showPulseEffect,
      animateLoading: animateLoading,
      showPulseEffectJiggle: showPulseEffectJiggle,
      semanticLabel: semanticLabel,
      child: child,
    );
  }
}
