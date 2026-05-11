import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

/// A custom-drawn animated toggle switch that uses only Dievas theme tokens.
///
/// The thumb slides between OFF (left) and ON (right) positions with a smooth
/// animation driven by [DievasSwitchThemeData.animationDuration].
///
/// Moon reference: Switch
///
/// ```dart
/// DievasSwitch(value: isOn, onChanged: (v) => setState(() => isOn = v))
/// DievasSwitch(value: true, onChanged: null)   // disabled
/// DievasSwitch(value: isOn, label: 'Dark mode', onChanged: (_) {})
/// ```
class DievasSwitch extends StatefulWidget {
  const DievasSwitch({super.key, required this.value, required this.onChanged, this.label});

  /// Whether the switch is in the ON position.
  final bool value;

  /// Called when the user toggles the switch. `null` → disabled.
  final ValueChanged<bool>? onChanged;

  /// Optional label rendered to the right of the track.
  final String? label;

  @override
  State<DievasSwitch> createState() => _DievasSwitchState();
}

class _DievasSwitchState extends State<DievasSwitch> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    if (widget.value) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(DievasSwitch old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
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
    final isDisabled = widget.onChanged == null;

    Widget track = AnimatedBuilder(
      animation: _curve,
      builder: (context, _) {
        final t = _curve.value;
        final trackColor = Color.lerp(theme.trackColorOff, theme.trackColorOn, t)!;
        final borderColor = Color.lerp(theme.borderColorOff, const Color(0x00000000), t)!;
        final thumbOffset = t * (theme.trackWidth - theme.thumbSize - theme.thumbPadding * 2);

        return Container(
          width: theme.trackWidth,
          height: theme.trackHeight,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: theme.trackRadius,
            border: Border.all(color: borderColor),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: theme.thumbPadding + thumbOffset,
                top: theme.thumbPadding,
                child: Container(
                  width: theme.thumbSize,
                  height: theme.thumbSize,
                  decoration: BoxDecoration(color: theme.thumbColor, borderRadius: theme.thumbRadius),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (widget.label != null) {
      track = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          track,
          SizedBox(width: theme.labelSpacing),
          DefaultTextStyle(
            style: theme.labelStyle,
            child: Flexible(child: Text(widget.label!)),
          ),
        ],
      );
    }

    if (isDisabled) {
      return Opacity(opacity: theme.disabledOpacity, child: track);
    }

    return GestureDetector(
      onTap: () => widget.onChanged!(!widget.value),
      behavior: HitTestBehavior.opaque,
      child: track,
    );
  }
}
