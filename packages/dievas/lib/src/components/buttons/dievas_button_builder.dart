import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../theme/component/button/dievas_button_theme_state_style.dart';
import '../../theme/component/button/dievas_button_theme_style.dart';
import 'dievas_button_state_animated_loader_mixin.dart';
import 'dievas_button_state_switcher.dart';
import 'dievas_button_press_mixin.dart';
import 'types/dievas_button_icon_style_behavior.dart';
import 'types/dievas_button_state.dart';

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
    required this.iconSpacing,
    required this.iconSize,
    required this.textStyle,
    required this.iconStyleBehavior,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  final DievasButtonState state;
  final String label;
  final DievasButtonThemeStateStyle<DievasButtonThemeStyle> style;

  /// Callback that receives resolved state props and returns layout values.
  final DievasButtonDecoratorBuilder builder;

  final BorderRadius borderRadius;
  final double disabledOpacity;
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
                  : (apple && isPressed ? DievasButtonPressMixin.kApplePressedOpacity : 1.0);

              final activeStyle = isPressed ? widget.style.focused : widget.style.idle;

              final foreground = activeStyle.foreground.withValues(alpha: opacityFactor);
              final borderSide = activeStyle.borderSide ?? .none;
              final bgColor = (activeStyle.background ?? Colors.transparent).withValues(alpha: opacityFactor);

              final decoration = BoxDecoration(
                color: bgColor,
                borderRadius: widget.borderRadius,
                border: .fromBorderSide(borderSide.copyWith(color: borderSide.color.withValues(alpha: opacityFactor))),
              );

              Widget? maybeColourIcon(Widget? icon) {
                if (icon == null) return null;
                if (widget.iconStyleBehavior == .maintainOriginal) return icon;
                return IconTheme(
                  data: IconThemeData(color: foreground, size: widget.iconSize),
                  child: icon,
                );
              }

              // Estimate text height for padding calculation.
              final textScaler = MediaQuery.textScalerOf(context);
              final fontSize = widget.textStyle.fontSize ?? 14.0;
              final scaledSize = textScaler.scale(fontSize);
              final estimatedTextHeight = scaledSize * (widget.textStyle.height ?? 1.4);

              final content = Row(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
                spacing: widget.iconSpacing,
                children: [
                  ?maybeColourIcon(widget.leadingIcon),
                  if (widget.label.isNotEmpty)
                    AnimatedDefaultTextStyle(
                      duration: DievasButtonPressMixin.kAnimationDuration,
                      style: widget.textStyle.copyWith(color: foreground),
                      textAlign: .center,
                      child: Text(widget.label),
                    ),
                  ?maybeColourIcon(widget.trailingIcon),
                ],
              );

              final DievasButtonDecorator(:height, :padding, :child) = widget.builder(
                context,
                DievasButtonDecoratorStateProps(
                  borderSide: borderSide,
                  estimatedTextHeight: estimatedTextHeight,
                  child: content,
                ),
              );

              final loader = IconTheme(
                data: IconThemeData(color: foreground, size: widget.iconSize),
                child: animatedLoader,
              );

              final inner = DievasButtonStateSwitcher(state: widget.state, loader: loader, content: child);

              if (apple) {
                return AnimatedContainer(
                  duration: DievasButtonPressMixin.kAnimationDuration,
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
