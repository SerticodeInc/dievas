import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

// Normalized selection progress, independent of visual opacity and timing.
const _unselectedProgress = 0.0;
const _selectedProgress = 1.0;

/// A controlled radio with an animated ring and dot, and keyboard access.
///
/// Update [groupValue] in [onChanged]. With [toggleable], selecting the active
/// radio reports null. A null callback disables the control.
class DievasRadio<T> extends StatefulWidget {
  const DievasRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.toggleable = false,
    this.activeColour,
    this.inactiveColour,
    this.tapAreaSize,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  }) : assert(tapAreaSize == null || tapAreaSize >= 0);

  final T value;
  final T? groupValue;

  /// Reports a selection or null when a toggleable selection is cleared.
  /// An already selected, non-toggleable radio does not call this callback.
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool toggleable;

  /// Overrides the selected ring and dot colour together.
  final Color? activeColour;

  /// Overrides the unselected ring colour.
  final Color? inactiveColour;

  /// Minimum hit target. Defaults to the theme's 40px height token.
  /// Zero removes extra hit padding without shrinking the visible radio.
  final double? tapAreaSize;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  @override
  State<DievasRadio<T>> createState() => _DievasRadioState<T>();
}

class _DievasRadioState<T> extends State<DievasRadio<T>> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).radio;
    final enabled = widget.onChanged != null;
    final selected = widget.value == widget.groupValue;
    final selectionProgress = selected ? _selectedProgress : _unselectedProgress;
    final tapSize = widget.tapAreaSize ?? DievasTheme.sizingOf(context).height40;

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
            _select();
            return null;
          },
        ),
      },
      child: Semantics(
        container: true,
        label: widget.semanticLabel ?? widget.label,
        checked: selected,
        enabled: enabled,
        inMutuallyExclusiveGroup: true,
        excludeSemantics: true,
        onTap: enabled ? _select : null,
        child: GestureDetector(
          excludeFromSemantics: true,
          behavior: .opaque,
          onTap: enabled ? _select : null,
          child: Opacity(
            opacity: enabled ? DievasTheme.opacityOf(context).opaque : theme.disabledOpacity,
            child: Row(
              mainAxisSize: .min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: tapSize, minHeight: tapSize),
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: SizedBox.square(
                      dimension: theme.size,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: selectionProgress, end: selectionProgress),
                        duration: switch (MediaQuery.disableAnimationsOf(context)) {
                          true => Duration.zero,
                          false => theme.animationDuration ?? DievasTheme.animationOf(context).standard,
                        },
                        curve: theme.animationCurve ?? DievasTheme.animationOf(context).easingStandard,
                        builder: (context, progress, child) => CustomPaint(
                          painter: _RadioPainter(
                            progress: progress,
                            strokeWidth: theme.strokeWidth,
                            dotSize: theme.dotSize,
                            background: theme.colourUnselected,
                            activeColour: switch ((widget.activeColour, enabled)) {
                              (final colour?, _) => colour,
                              (null, true) => theme.colourSelected,
                              (null, false) => theme.colourDisabled,
                            },
                            inactiveColour: switch ((widget.inactiveColour, enabled)) {
                              (final colour?, _) => colour,
                              (null, true) => theme.borderColourUnselected,
                              (null, false) => theme.borderColourDisabled,
                            },
                            dotColour: widget.activeColour ?? theme.dotColour,
                            focusColour: switch ((_focused, enabled)) {
                              (true, true) => DievasTheme.coloursOf(context).border.focusIndicatorColour,
                              _ => null,
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
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

  void _select() {
    switch ((widget.onChanged, widget.value == widget.groupValue, widget.toggleable)) {
      case (final changed?, false, _):
        changed(widget.value);
      case (final changed?, true, true):
        changed(null);
      default:
        break;
    }
  }
}

class _RadioPainter extends CustomPainter {
  const _RadioPainter({
    required this.progress,
    required this.strokeWidth,
    required this.dotSize,
    required this.background,
    required this.activeColour,
    required this.inactiveColour,
    required this.dotColour,
    required this.focusColour,
  });

  final double progress;
  final double strokeWidth;
  final double dotSize;
  final Color background;
  final Color activeColour;
  final Color inactiveColour;
  final Color dotColour;
  final Color? focusColour;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    canvas.drawCircle(center, radius, Paint()..color = background);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Color.from(
          alpha: inactiveColour.a + (activeColour.a - inactiveColour.a) * progress,
          red: inactiveColour.r + (activeColour.r - inactiveColour.r) * progress,
          green: inactiveColour.g + (activeColour.g - inactiveColour.g) * progress,
          blue: inactiveColour.b + (activeColour.b - inactiveColour.b) * progress,
        )
        ..style = .stroke
        ..strokeWidth = strokeWidth,
    );
    canvas.drawCircle(center, dotSize / 2 * progress, Paint()..color = dotColour);
    if (focusColour case final colour?) {
      canvas.drawCircle(
        center,
        radius + strokeWidth * 3,
        Paint()
          ..color = colour
          ..style = .stroke
          ..strokeWidth = strokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(_RadioPainter old) =>
      progress != old.progress ||
      strokeWidth != old.strokeWidth ||
      dotSize != old.dotSize ||
      background != old.background ||
      activeColour != old.activeColour ||
      inactiveColour != old.inactiveColour ||
      dotColour != old.dotColour ||
      focusColour != old.focusColour;
}
