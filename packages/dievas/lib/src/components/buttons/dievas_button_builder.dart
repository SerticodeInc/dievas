import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:dievas/src/components/icon/dievas_icon.dart';
import 'package:dievas/src/components/loader/dievas_loader.dart';
import 'package:dievas/src/theme/component/button/dievas_button_theme_state_style.dart';
import 'package:dievas/src/theme/component/button/dievas_button_theme_style.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'dievas_button_types.dart';

/// Shared layout, keyboard, pointer, and motion layer for the three text buttons.
@internal
class DievasButtonBuilder extends StatefulWidget {
  const DievasButtonBuilder({
    super.key,
    required this.state,
    required this.style,
    required this.shape,
    required this.disabledOpacity,
    required this.pressOpacity,
    required this.iconSpacing,
    required this.iconSize,
    required this.textStyle,
    required this.height,
    required this.padding,
    this.iconStyleBehavior = .inheritFromState,
    this.label,
    this.child,
    this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.showBorder,
    this.isFullWidth = false,
    this.showPulseEffect = false,
    this.animateLoading = true,
    this.showPulseEffectJiggle = false,
    this.onPressed,
    this.onLongPress,
    this.semanticLabel,
    this.loaderRotationDuration,
  });

  final DievasButtonState state;
  final DievasButtonThemeStateStyle<DievasButtonThemeStyle> style;
  final OutlinedBorder shape;
  final double disabledOpacity;
  final double pressOpacity;
  final double iconSpacing;
  final double iconSize;
  final TextStyle textStyle;
  final double height;
  final EdgeInsetsGeometry padding;
  final DievasButtonIconStyleBehavior iconStyleBehavior;
  final String? label;
  final Widget? child;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool? showBorder;
  final bool isFullWidth;
  final bool showPulseEffect;

  /// Fade and scale between content and loader. Reduced motion switches instantly.
  final bool animateLoading;
  final bool showPulseEffectJiggle;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? semanticLabel;
  final Duration? loaderRotationDuration;

  @override
  State<DievasButtonBuilder> createState() => _DievasButtonBuilderState();
}

class _DievasButtonBuilderState extends State<DievasButtonBuilder> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this);
  bool _pressed = false;
  bool _focused = false;

  bool get _enabled => widget.state == .idle && (widget.onPressed != null || widget.onLongPress != null);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pulse.duration = DievasTheme.animationOf(context).quick;
    if (MediaQuery.disableAnimationsOf(context)) _pulse.value = 0;
  }

  @override
  void didUpdateWidget(DievasButtonBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_enabled) _pressed = false;
    if (!_enabled || !widget.showPulseEffect) _pulse.value = 0;
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.of(context);
    final activeStyle = _pressed && _enabled ? widget.style.focused : widget.style.idle;
    final foreground = widget.foregroundColor ?? activeStyle.foreground;
    final border = switch ((widget.showBorder, activeStyle.borderSide, widget.borderColor)) {
      (false, _, _) => BorderSide.none,
      (_, final side?, _) => side.copyWith(color: widget.borderColor ?? side.color),
      (true, _, _) || (_, _, _?) => BorderSide(
        color: widget.borderColor ?? theme.colours.border.dividerColour,
        width: theme.border.strokeThin,
      ),
      _ => BorderSide.none,
    };
    final content = switch (widget.child) {
      final child? => child,
      _ => Row(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        spacing: widget.iconSpacing,
        children: [
          if (widget.leadingIcon case final icon?)
            _ButtonIcon(icon: icon, colour: foreground, size: widget.iconSize, behaviour: widget.iconStyleBehavior),
          if (widget.label case final label? when label.isNotEmpty) Flexible(child: Text(label, textAlign: .center)),
          if (widget.trailingIcon case final icon?)
            _ButtonIcon(icon: icon, colour: foreground, size: widget.iconSize, behaviour: widget.iconStyleBehavior),
        ],
      ),
    };

    return FocusableActionDetector(
      enabled: _enabled,
      mouseCursor: _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (focused) => setState(() => _focused = focused),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onPressed?.call();
            return null;
          },
        ),
      },
      child: Semantics(
        button: true,
        enabled: _enabled,
        label: widget.semanticLabel,
        onTap: _enabled ? widget.onPressed : null,
        onLongPress: _enabled ? widget.onLongPress : null,
        child: GestureDetector(
          excludeFromSemantics: true,
          behavior: .opaque,
          onTap: _enabled ? widget.onPressed : null,
          onLongPress: _enabled ? widget.onLongPress : null,
          onTapDown: _enabled ? (_) => _setPressed(true) : null,
          onTapUp: _enabled ? (_) => _setPressed(false) : null,
          onTapCancel: _enabled ? () => _setPressed(false) : null,
          child: AnimatedBuilder(
            animation: _pulse,
            builder: (context, child) => Transform.rotate(
              angle: widget.showPulseEffectJiggle ? math.sin(_pulse.value * math.pi * 4) * 0.035 : 0,
              child: Transform.scale(scale: 1 - _pulse.value * 0.04, child: child),
            ),
            child: Opacity(
              opacity: switch ((_enabled, widget.state, _pressed)) {
                (false, .disabled, _) || (false, .idle, _) => widget.disabledOpacity,
                (_, _, true) => widget.pressOpacity,
                _ => 1,
              },
              child: LayoutBuilder(
                builder: (context, constraints) => Align(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    width: widget.isFullWidth && constraints.hasBoundedWidth ? constraints.maxWidth : null,
                    constraints: BoxConstraints(minHeight: widget.height),
                    padding: widget.padding,
                    decoration: ShapeDecoration(
                      shape: widget.shape.copyWith(side: border),
                      color: widget.backgroundColor ?? activeStyle.background,
                      shadows: _focused && _enabled
                          ? [BoxShadow(color: theme.colours.core.primary, spreadRadius: theme.border.strokeDefault)]
                          : null,
                    ),
                    child: DefaultTextStyle(
                      style: widget.textStyle.copyWith(color: foreground),
                      child: _ButtonLoadingContent(
                        loading: widget.state == .loading,
                        animate: widget.animateLoading,
                        iconSize: widget.iconSize,
                        colour: foreground,
                        loaderDuration: widget.loaderRotationDuration ?? theme.animation.loader,
                        child: content,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setPressed(bool pressed) {
    setState(() => _pressed = pressed);
    if (widget.showPulseEffect && !MediaQuery.disableAnimationsOf(context)) {
      if (pressed) {
        _pulse.forward();
      } else {
        _pulse.forward().then((_) {
          if (mounted && !_pressed) _pulse.reverse();
        });
      }
    }
  }
}

class _ButtonIcon extends StatelessWidget {
  const _ButtonIcon({required this.icon, required this.colour, required this.size, required this.behaviour});

  final Widget icon;
  final Color colour;
  final double size;
  final DievasButtonIconStyleBehavior behaviour;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: FittedBox(
      child: switch ((behaviour, icon)) {
        (.maintainOriginal, _) => icon,
        (_, DievasIcon(icon: final data, :final semanticLabel)) => DievasIcon(
          data,
          color: colour,
          semanticLabel: semanticLabel,
        ),
        (_, Icon(icon: final data?, :final semanticLabel)) => DievasIcon(
          data,
          color: colour,
          semanticLabel: semanticLabel,
        ),
        _ => icon,
      },
    ),
  );
}

class _ButtonLoadingContent extends StatefulWidget {
  const _ButtonLoadingContent({
    required this.loading,
    required this.animate,
    required this.iconSize,
    required this.colour,
    required this.loaderDuration,
    required this.child,
  });

  final bool loading;
  final bool animate;
  final double iconSize;
  final Color colour;
  final Duration loaderDuration;
  final Widget child;

  @override
  State<_ButtonLoadingContent> createState() => _ButtonLoadingContentState();
}

class _ButtonLoadingContentState extends State<_ButtonLoadingContent> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, value: widget.loading ? 1 : 0)
    ..addStatusListener(_onStatus);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DievasTheme.animationOf(context).standard;
    if (!widget.animate || MediaQuery.disableAnimationsOf(context)) _controller.value = widget.loading ? 1 : 0;
  }

  @override
  void didUpdateWidget(_ButtonLoadingContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.animate || MediaQuery.disableAnimationsOf(context)) {
      _controller.value = widget.loading ? 1 : 0;
    } else if (widget.loading != oldWidget.loading) {
      widget.loading ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurveTween(curve: DievasTheme.animationOf(context).easingStandard).animate(_controller);
    return Stack(
      alignment: .center,
      children: [
        IgnorePointer(
          ignoring: widget.loading,
          child: FadeTransition(
            opacity: ReverseAnimation(animation),
            alwaysIncludeSemantics: true,
            child: ScaleTransition(scale: Tween<double>(begin: 1, end: 0.95).animate(animation), child: widget.child),
          ),
        ),
        if (widget.loading || !_controller.isDismissed)
          ExcludeSemantics(
            child: FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.85, end: 1).animate(animation),
                child: DievasLoader(
                  diameter: widget.iconSize,
                  colour: widget.colour,
                  animationDuration: widget.loaderDuration,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _onStatus(AnimationStatus status) {
    if (status == .dismissed) setState(() {});
  }
}
