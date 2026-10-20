import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_builder.dart';
import 'dievas_button_types.dart';

export 'dievas_button_types.dart' show DievasTextButtonStyle;

/// A text button with a transparent, borderless default surface.
///
/// Uses the size variant’s minimum height. Used for inline actions, links, and
/// secondary affordance where a full-height button would be too heavy.
///
/// ```dart
/// DievasTextButton(
///   label: 'View details',
///   onPressed: () { },
/// )
/// ```
class DievasTextButton extends StatefulWidget {
  const DievasTextButton({
    super.key,
    this.style = .primary,
    this.size = .md,
    this.state = .idle,
    this.label,
    this.child,
    this.shape,
    this.foregroundColor,
    this.leadingIcon,
    this.trailingIcon,
    this.onPressed,
    this.onLongPress,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.showBorder,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.animateLoading = true,
    this.showPulseEffectJiggle = false,
    this.iconStyleBehavior = .inheritFromState,
    this.semanticLabel,
    this.loaderRotationDuration = DievasAnimationSemantic.loader,
  }) : assert(label != null || child != null || leadingIcon != null || trailingIcon != null, 'Provide button content'),
       assert(
         child == null || (leadingIcon == null && trailingIcon == null),
         'leadingIcon/trailingIcon are ignored when child is provided',
       );

  final Duration loaderRotationDuration;

  final DievasTextButtonStyle style;
  final DievasButtonSize size;

  final DievasButtonState state;

  final String? label;
  final Widget? child;
  final OutlinedBorder? shape;
  final Color? foregroundColor;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  /// Tap action. Both callbacks being null, loading, or disabled blocks interaction.
  final VoidCallback? onPressed;

  /// Long-press action, independent of the tap callback.
  final VoidCallback? onLongPress;

  /// Optional surface fill; transparent by default.
  final Color? backgroundColor;

  /// Border colour override. Explicit false [showBorder] takes precedence.
  final Color? borderColor;

  /// Radius override, used when [shape] is null.
  final BorderRadiusGeometry? borderRadius;

  /// Optional border visibility; text buttons default to borderless.
  final bool? showBorder;

  /// Fill bounded available width; retain natural width when unbounded.
  final bool isFullWidth;

  /// Enable a press-scale response, respecting reduced motion.
  final bool showPulseEffect;

  /// Fade and scale between content and loader. Reduced motion switches instantly.
  final bool animateLoading;

  /// Add a rotational jiggle when [showPulseEffect] is enabled.
  final bool showPulseEffectJiggle;

  /// Whether icon slots use the resolved foreground or their own styling.
  final DievasButtonIconStyleBehavior iconStyleBehavior;

  /// Accessible name for an icon-only button.
  final String? semanticLabel;

  @override
  State<DievasTextButton> createState() => _DievasTextButtonState();
}

class _DievasTextButtonState extends State<DievasTextButton> {
  @override
  Widget build(BuildContext context) {
    final components = DievasTheme.componentsOf(context);
    final theme = switch (widget.style) {
      .primary => components.textButton.primary,
      .destructive => components.textButton.destructive,
    };
    final (textStyle, iconSize, gap) = switch (widget.size) {
      .sm => (theme.textStyle.sm, theme.iconSize.sm, theme.iconSpacing.sm),
      .md => (theme.textStyle.md, theme.iconSize.md, theme.iconSpacing.md),
      .lg => (theme.textStyle.lg, theme.iconSize.lg, theme.iconSpacing.lg),
    };
    return DievasButtonBuilder(
      state: widget.state,
      style: theme.style,
      shape: switch ((widget.shape, widget.borderRadius)) {
        (final shape?, _) => shape,
        (_, final radius?) => RoundedRectangleBorder(borderRadius: radius),
        _ => RoundedRectangleBorder(borderRadius: DievasTheme.borderOf(context).md),
      },
      disabledOpacity: theme.disabledOpacity,
      pressOpacity: theme.pressOpacity,
      iconSpacing: gap,
      iconSize: iconSize,
      textStyle: textStyle,
      height: switch (widget.size) {
        .sm => DievasTheme.sizingOf(context).buttonHeightSm,
        .md => DievasTheme.sizingOf(context).buttonHeightMd,
        .lg => DievasTheme.sizingOf(context).buttonHeightLg,
      },
      padding: EdgeInsets.symmetric(
        horizontal: DievasTheme.spacingOf(context).md,
        vertical: DievasTheme.spacingOf(context).xs,
      ),
      label: widget.label,
      leadingIcon: widget.leadingIcon,
      trailingIcon: widget.trailingIcon,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      borderColor: widget.borderColor,
      showBorder: widget.showBorder,
      isFullWidth: widget.isFullWidth,
      showPulseEffect: widget.showPulseEffect,
      animateLoading: widget.animateLoading,
      showPulseEffectJiggle: widget.showPulseEffectJiggle,
      iconStyleBehavior: widget.iconStyleBehavior,
      semanticLabel: widget.semanticLabel,
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      loaderRotationDuration: widget.loaderRotationDuration,
      child: widget.child,
    );
  }
}
