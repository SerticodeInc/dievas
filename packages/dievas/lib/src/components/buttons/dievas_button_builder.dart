import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:dievas/src/theme/component/button/dievas_button_theme_state_style.dart';
import 'package:dievas/src/theme/component/button/dievas_button_theme_style.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_state_animated_loader_mixin.dart';
import 'dievas_button_state_switcher.dart';
import 'dievas_button_press_mixin.dart';
import 'button_types/dievas_button_icon_style_behavior.dart';
import 'button_types/dievas_button_state.dart';

/// The internal layout-and-gesture layer shared by [DievasFilledButton] and
/// [DievasOutlinedButton].
///
/// Not part of the public API — use the variant widgets directly.
@internal
class DievasButtonBuilder extends StatefulWidget with DievasButtonStateAnimatedLoaderMixin {
  const DievasButtonBuilder({
    super.key,
    required this.state,
    required this.label,
    required this.style,
    required this.builder,
    required this.borderRadius,
    required this.disabledOpacity,
    required this.pressOpacity,
    required this.loaderRotationDuration,
    required this.iconSpacing,
    required this.iconSize,
    required this.textStyle,
    required this.iconStyleBehavior,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  final Duration loaderRotationDuration;

  @override
  final DievasButtonState state;
  final String label;
  final DievasButtonThemeStateStyle<DievasButtonThemeStyle> style;

  /// Callback that receives resolved state props and returns layout values.
  final DievasButtonDecoratorBuilder builder;

  final BorderRadius borderRadius;
  final double disabledOpacity;
  final double pressOpacity;
  final double iconSpacing;
  final double iconSize;
  final TextStyle textStyle;
  final DievasButtonIconStyleBehavior iconStyleBehavior;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final VoidCallback? onPressed;

  @override
  State<DievasButtonBuilder> createState() => _DievasButtonBuilderState();
}

class _DievasButtonBuilderState extends State<DievasButtonBuilder>
    with SingleTickerProviderStateMixin, DievasButtonStateAnimatedLoaderProviderMixin, DievasButtonPressMixin {
  @override
  Widget build(BuildContext context) {
    final apple = isApplePlatform;
    final pressDuration = DievasTheme.animationOf(context).quick;

    return Semantics(
      button: true,
      child: Material(
        type: .transparency,
        child: InkWell(
          statesController: statesController,
          onTap: (widget.state == .loading || widget.state == .disabled) ? null : widget.onPressed,
          borderRadius: widget.borderRadius,
          splashFactory: apple ? NoSplash.splashFactory : InkRipple.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: ValueListenableBuilder<Set<WidgetState>>(
            valueListenable: statesController,
            builder: (context, states, _) {
              final isPressed = states.contains(WidgetState.pressed);
              final isDisabled =
                  widget.state == .disabled || states.contains(WidgetState.disabled) || widget.onPressed == null;

              final opacityFactor = isDisabled
                  ? widget.disabledOpacity
                  : (apple && isPressed ? widget.pressOpacity : 1.0);

              final activeStyle = isPressed ? widget.style.focused : widget.style.idle;

              final foreground = activeStyle.foreground.withValues(alpha: opacityFactor);
              final borderSide = activeStyle.borderSide ?? .none;
              final bgColor = (activeStyle.background ?? Colors.transparent).withValues(alpha: opacityFactor);

              final decoration = BoxDecoration(
                color: bgColor,
                borderRadius: widget.borderRadius,
                border: .fromBorderSide(borderSide.copyWith(color: borderSide.color.withValues(alpha: opacityFactor))),
              );

              Widget? maybeColourIcon(Widget? icon) => switch ((icon, widget.iconStyleBehavior)) {
                (null, _) => null,
                (final icon, .maintainOriginal) => icon,
                (final icon?, _) => IconTheme(
                  data: IconThemeData(color: foreground, size: widget.iconSize),
                  child: icon,
                ),
              };

              // Estimate content height for padding calculation.
              // When icons are present the Row height is driven by iconSize, not
              // the text line-height — so we take the larger of the two to ensure
              // the content area is tall enough for the icons to fit without
              // overflowing the vertical constraint applied by UnconstrainedBox.
              final textScaler = MediaQuery.textScalerOf(context);
              final placeholderFontSize = 14.0;
              final placeholderTextHeight = 1.4;
              final fontSize = widget.textStyle.fontSize ?? placeholderFontSize;
              final scaledSize = textScaler.scale(fontSize);
              final hasIcon = widget.leadingIcon != null || widget.trailingIcon != null;
              final estimatedTextHeight = math.max(
                scaledSize * (widget.textStyle.height ?? placeholderTextHeight),
                hasIcon ? widget.iconSize : 0.0,
              );

              // Fixed-size bounding box ensures consistent Row alignment regardless
              // of how the inner icon widget reports its own intrinsic size.
              Widget sizedIcon(Widget? icon) => SizedBox.square(
                dimension: widget.iconSize,
                child: Center(child: icon),
              );

              final DievasButtonDecorator(:height, :padding, :child) = widget.builder(
                context,
                DievasButtonDecoratorStateProps(
                  borderSide: borderSide,
                  estimatedTextHeight: estimatedTextHeight,
                  child: Row(
                    mainAxisSize: .min,
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .center,
                    spacing: widget.iconSpacing,
                    children: [
                      if (widget.leadingIcon != null) sizedIcon(maybeColourIcon(widget.leadingIcon)),
                      if (widget.label.isNotEmpty)
                        AnimatedDefaultTextStyle(
                          duration: pressDuration,
                          style: widget.textStyle.copyWith(color: foreground),
                          textAlign: .center,
                          child: Text(widget.label),
                        ),
                      if (widget.trailingIcon != null) sizedIcon(maybeColourIcon(widget.trailingIcon)),
                    ],
                  ),
                ),
              );

              final inner = DievasButtonStateSwitcher(
                state: widget.state,
                loader: IconTheme(
                  data: IconThemeData(color: foreground, size: widget.iconSize),
                  child: animatedLoader,
                ),
                content: child,
              );

              if (apple) {
                return AnimatedContainer(
                  duration: pressDuration,
                  height: height,
                  padding: padding,
                  decoration: decoration,
                  child: inner,
                );
              }

              return Ink(height: height, padding: padding, decoration: decoration, child: inner);
            },
          ),
        ),
      ),
    );
  }
}

// Decorator types (internal, not file-private)
/// Signature for the layout callback passed to [DievasButtonBuilder].
@internal
typedef DievasButtonDecoratorBuilder =
    DievasButtonDecorator Function(BuildContext context, DievasButtonDecoratorStateProps props);

/// State-dependent props passed from [DievasButtonBuilder] to its decorator callback.
@internal
final class DievasButtonDecoratorStateProps with EquatableMixin {
  const DievasButtonDecoratorStateProps({
    required this.borderSide,
    required this.estimatedTextHeight,
    required this.child,
  });

  final BorderSide borderSide;
  final double estimatedTextHeight;
  final Widget child;

  @override
  List<Object?> get props => [borderSide, estimatedTextHeight, child];
}

/// Resolved layout values returned by the decorator builder.
@internal
final class DievasButtonDecorator with EquatableMixin {
  const DievasButtonDecorator({required this.height, required this.padding, required this.child});

  final double height;
  final EdgeInsets padding;
  final Widget child;

  @override
  List<Object?> get props => [height, padding, child];
}
