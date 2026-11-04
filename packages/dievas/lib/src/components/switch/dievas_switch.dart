import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/component/switch/dievas_switch_theme_data.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Moon-compatible switch sizes. XS is the default.
enum DievasSwitchSize { xxs, xs, sm }

/// A controlled switch with draggable thumb and optional state-specific content.
/// Update [value] in [onChanged]; a null callback disables all interaction.
class DievasSwitch extends StatefulWidget {
  const DievasSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.switchSize,
    this.activeTrackColour,
    this.inactiveTrackColour,
    this.thumbColour,
    this.width,
    this.height,
    this.thumbSize,
    this.padding,
    this.duration,
    this.curve,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.hasHapticFeedback = true,
    this.activeTrackWidget,
    this.inactiveTrackWidget,
    this.activeThumbWidget,
    this.inactiveThumbWidget,
  }) : assert(width == null || width > 0),
       assert(height == null || height > 0),
       assert(thumbSize == null || thumbSize > 0);

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final DievasSwitchSize? switchSize;
  final Color? activeTrackColour;
  final Color? inactiveTrackColour;
  final Color? thumbColour;
  final double? width;
  final double? height;
  final double? thumbSize;
  final EdgeInsetsGeometry? padding;
  final Duration? duration;
  final Curve? curve;

  /// Caller-owned; the switch never disposes this node.
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;
  final bool hasHapticFeedback;

  /// Content in the free half of the track, mirrored in RTL.
  final Widget? activeTrackWidget;
  final Widget? inactiveTrackWidget;
  final Widget? activeThumbWidget;
  final Widget? inactiveThumbWidget;

  @override
  State<DievasSwitch> createState() => _DievasSwitchState();
}

class _DievasSwitchState extends State<DievasSwitch> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _focused = false;
  bool _reduceMotion = false;
  Curve _curve = Curves.linear;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: widget.value ? 1 : 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _configureMotion();
  }

  @override
  void didUpdateWidget(DievasSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _configureMotion();
    if (oldWidget.value != widget.value || (oldWidget.onChanged != null && widget.onChanged == null)) {
      _settle();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).toggle;
    final sizing = DievasTheme.sizingOf(context);
    final geometry = switch (widget.switchSize) {
      .xxs => (width: sizing.width32, height: sizing.height16, thumb: sizing.height12, inset: 2.0),
      .xs => (width: sizing.width44, height: sizing.height24, thumb: sizing.height16, inset: 4.0),
      .sm => (width: sizing.width60, height: sizing.height32, thumb: sizing.height24, inset: 4.0),
      null => (width: theme.trackWidth, height: theme.trackHeight, thumb: theme.thumbSize, inset: theme.thumbPadding),
    };
    final width = widget.width ?? geometry.width;
    final height = widget.height ?? geometry.height;
    final thumb = widget.thumbSize ?? geometry.thumb;
    final padding = (widget.padding ?? EdgeInsets.all(geometry.inset)).resolve(Directionality.of(context));
    final travel = width - padding.horizontal - thumb;
    assert(travel > 0, 'The track must leave room for the thumb to move.');
    assert(height >= padding.vertical + thumb, 'The thumb must fit inside the track.');
    final enabled = widget.onChanged != null;

    return FocusableActionDetector(
      enabled: enabled,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      mouseCursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            _toggle();
            return null;
          },
        ),
      },
      child: Semantics(
        container: true,
        label: widget.semanticLabel ?? widget.label,
        toggled: widget.value,
        enabled: enabled,
        excludeSemantics: true,
        onTap: enabled ? _toggle : null,
        child: GestureDetector(
          behavior: .opaque,
          excludeFromSemantics: true,
          onTap: enabled ? _toggle : null,
          onHorizontalDragStart: switch (enabled) {
            true => (_) {
              _controller.stop();
              _vibrate();
            },
            false => null,
          },
          onHorizontalDragUpdate: switch (enabled) {
            true => (details) {
              final direction = Directionality.of(context) == TextDirection.rtl ? -1 : 1;
              _controller.value += direction * details.delta.dx / travel;
            },
            false => null,
          },
          onHorizontalDragEnd: enabled ? (_) => _endDrag() : null,
          onHorizontalDragCancel: enabled ? _settle : null,
          child: Opacity(
            opacity: enabled ? DievasTheme.opacityOf(context).opaque : theme.disabledOpacity,
            child: Row(
              mainAxisSize: .min,
              children: [
                _SwitchTrack(
                  controller: _controller,
                  theme: theme,
                  switchWidget: widget,
                  width: width,
                  height: height,
                  thumb: thumb,
                  padding: padding,
                  focused: enabled && _focused,
                ),
                if (widget.label case final label?)
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: theme.labelSpacing),
                      child: Text(label, style: theme.labelStyle),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _configureMotion() {
    final theme = DievasTheme.componentsOf(context).toggle;
    _controller.duration = widget.duration ?? theme.animationDuration;
    _curve = widget.curve ?? DievasTheme.animationOf(context).easingStandard;
    _reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (_reduceMotion) _controller.value = widget.value ? 1 : 0;
  }

  void _settle() {
    final target = widget.value ? 1.0 : 0.0;
    if (_reduceMotion) {
      _controller.value = target;
    } else {
      _controller.animateTo(target, curve: _curve);
    }
  }

  void _toggle() {
    if (widget.onChanged case final changed?) {
      changed(!widget.value);
      _vibrate();
    }
  }

  void _endDrag() {
    final requested = _controller.value >= 0.5;
    if (widget.onChanged case final changed? when requested != widget.value) changed(requested);
    // A subsequent owner rebuild settles to an accepted request; otherwise
    // return immediately to the existing controlled value.
    _settle();
  }

  void _vibrate() {
    if (widget.hasHapticFeedback) HapticFeedback.lightImpact();
  }
}

class _SwitchTrack extends AnimatedWidget {
  const _SwitchTrack({
    required this.controller,
    required this.theme,
    required this.switchWidget,
    required this.width,
    required this.height,
    required this.thumb,
    required this.padding,
    required this.focused,
  }) : super(listenable: controller);

  final AnimationController controller;
  final DievasSwitchThemeData theme;
  final DievasSwitch switchWidget;
  final double width;
  final double height;
  final double thumb;
  final EdgeInsets padding;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    final progress = controller.value;
    final colours = DievasTheme.coloursOf(context);
    final thumbContent = progress > 0.5 ? switchWidget.activeThumbWidget : switchWidget.inactiveThumbWidget;
    final fontSize = switch (switchWidget.switchSize) {
      .xxs => 6.0,
      .sm => 10.0,
      _ => 8.0,
    };
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color.lerp(
          switchWidget.inactiveTrackColour ?? theme.trackColourOff,
          switchWidget.activeTrackColour ?? theme.trackColourOn,
          progress,
        ),
        borderRadius: theme.trackRadius,
      ),
      child: Padding(
        padding: padding,
        child: Stack(
          clipBehavior: .none,
          alignment: .center,
          children: [
            Row(
              children: [
                Expanded(
                  child: _SwitchSlot(
                    opacity: ((progress - 0.7) / 0.3).clamp(0.0, 1.0),
                    colour: colours.staticColours.staticWhite,
                    iconSize: thumb,
                    fontSize: fontSize,
                    child: switchWidget.activeTrackWidget,
                  ),
                ),
                SizedBox(width: padding.left),
                Expanded(
                  child: _SwitchSlot(
                    opacity: (1 - progress / 0.3).clamp(0.0, 1.0),
                    colour: colours.text.textPrimary,
                    iconSize: thumb,
                    fontSize: fontSize,
                    child: switchWidget.inactiveTrackWidget,
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(-1 + 2 * progress, 0),
              child: Container(
                width: thumb,
                height: thumb,
                alignment: .center,
                decoration: BoxDecoration(
                  color: switchWidget.thumbColour ?? Color.lerp(theme.thumbColourOff, theme.thumbColourOn, progress),
                  borderRadius: theme.thumbRadius,
                  boxShadow: theme.thumbShadow ?? DievasTheme.elevationOf(context).sm,
                  border: focused ? Border.all(color: colours.border.focusIndicatorColour, width: 2) : null,
                ),
                child: _SwitchSlot(
                  opacity: (2 * progress - 1).abs(),
                  colour: colours.staticColours.staticBlack,
                  iconSize: thumb,
                  fontSize: fontSize,
                  child: thumbContent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchSlot extends StatelessWidget {
  const _SwitchSlot({
    required this.opacity,
    required this.colour,
    required this.iconSize,
    required this.fontSize,
    this.child,
  });
  final double opacity;
  final Color colour;
  final double iconSize;
  final double fontSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: ExcludeFocus(
      child: Opacity(
        opacity: opacity,
        child: IconTheme(
          data: IconThemeData(color: colour, size: iconSize),
          child: DefaultTextStyle(
            style: DievasTheme.typographyOf(
              context,
            ).bodyXs.copyWith(color: colour, fontSize: fontSize, letterSpacing: 0.1),
            textAlign: .center,
            child: Center(child: child),
          ),
        ),
      ),
    ),
  );
}
