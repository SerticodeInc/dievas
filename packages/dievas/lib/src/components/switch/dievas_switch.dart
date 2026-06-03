import 'package:dievas/src/theme/component/switch/dievas_switch_theme_data.dart';
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
    final theme = DievasTheme.componentsOf(context).toggle;
    _controller = AnimationController(vsync: this, duration: theme.animationDuration);
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
    Widget track = _DievasSwitchTrackBuilder(curve: _curve, theme: theme);

    if (widget.label case final text?) {
      track = Row(
        mainAxisSize: .min,
        children: [
          track,
          SizedBox(width: theme.labelSpacing),
          DefaultTextStyle(
            style: theme.labelStyle,
            child: Flexible(child: Text(text)),
          ),
        ],
      );
    }

    if (widget.onChanged == null) {
      return Opacity(opacity: theme.disabledOpacity, child: track);
    }

    return GestureDetector(onTap: () => widget.onChanged!(!widget.value), behavior: .opaque, child: track);
  }
}

class _DievasSwitchTrackBuilder extends StatelessWidget {
  const _DievasSwitchTrackBuilder({required this.curve, required this.theme});

  final CurvedAnimation curve;
  final DievasSwitchThemeData theme;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: curve,
    builder: (context, _) {
      final t = curve.value;
      final thumbOffset = t * (theme.trackWidth - theme.thumbSize - theme.thumbPadding * 2);

      return Container(
        width: theme.trackWidth,
        height: theme.trackHeight,
        decoration: BoxDecoration(
          color: .lerp(theme.trackColorOff, theme.trackColorOn, t)!,
          borderRadius: theme.trackRadius,
        ),
        child: Stack(
          clipBehavior: .none,
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
}
