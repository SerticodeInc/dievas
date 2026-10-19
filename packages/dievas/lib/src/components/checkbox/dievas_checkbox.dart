import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// The controlled value of a checkbox.
enum DievasCheckboxValue { checked, unchecked, indeterminate }

/// A token-based checkbox with animated check/dash drawing and keyboard access.
///
/// With [tristate], taps cycle unchecked → checked → indeterminate → unchecked.
/// Without it, unchecked/checked toggle and a supplied indeterminate value
/// advances to checked, preserving the original enum API.
class DievasCheckbox extends StatefulWidget {
  const DievasCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.tristate = false,
    this.checkColour,
    this.activeColour,
    this.inactiveColour,
    this.borderColour,
    this.tapAreaSize,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.labelPosition = .end,
    this.isFullWidth = false,
  }) : assert(tapAreaSize == null || tapAreaSize >= 0);

  final DievasCheckboxValue value;

  /// Null disables pointer and keyboard interaction and dims the control.
  final ValueChanged<DievasCheckboxValue>? onChanged;
  final String? label;
  final bool tristate;
  final Color? checkColour;
  final Color? activeColour;
  final Color? inactiveColour;
  final Color? borderColour;

  /// Minimum hit area, defaulting to the active theme's 40px height token.
  /// The visible box retains the checkbox theme's size.
  final double? tapAreaSize;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  /// Label placement relative to the box, mirrored in RTL.
  final DievasCheckboxLabelPosition labelPosition;

  /// Spread the label and box across bounded available width.
  final bool isFullWidth;

  @override
  State<DievasCheckbox> createState() => _DievasCheckboxState();
}

enum DievasCheckboxLabelPosition { start, end }

typedef _Levels = ({double fill, double check, double dash});

class _DievasCheckboxState extends State<DievasCheckbox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, value: 1);
  late _Levels _from = _target;
  bool _focused = false;

  _Levels get _target => switch (widget.value) {
    .unchecked => (fill: 0, check: 0, dash: 0),
    .checked => (fill: 1, check: 1, dash: 0),
    .indeterminate => (fill: 1, check: 0, dash: 1),
  };

  _Levels get _levels => _interpolate(widget.value);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DievasTheme.animationOf(context).standard;
    if (MediaQuery.disableAnimationsOf(context)) _controller.value = 1;
  }

  @override
  void didUpdateWidget(DievasCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      // Recover the current visual state before changing the target.
      _from = _interpolate(oldWidget.value);
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1;
      } else {
        _controller.forward(from: 0);
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
    final theme = DievasTheme.componentsOf(context).checkbox;
    final tapSize = widget.tapAreaSize ?? DievasTheme.sizingOf(context).height40;
    final enabled = widget.onChanged != null;

    return FocusableActionDetector(
      enabled: enabled,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      mouseCursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            _toggle();
            return null;
          },
        ),
      },
      child: Semantics(
        label: widget.semanticLabel,
        checked: widget.value == .checked,
        mixed: widget.value == .indeterminate,
        enabled: enabled,
        onTap: enabled ? _toggle : null,
        child: GestureDetector(
          excludeFromSemantics: true,
          onTap: enabled ? _toggle : null,
          behavior: .opaque,
          child: Opacity(
            opacity: enabled ? 1 : theme.disabledOpacity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final fullWidth = widget.isFullWidth && constraints.hasBoundedWidth;
                return SizedBox(
                  width: fullWidth ? constraints.maxWidth : null,
                  child: Row(
                    mainAxisSize: .min,
                    mainAxisAlignment: fullWidth ? .spaceBetween : .start,
                    children: [
                      if ((widget.label, widget.labelPosition) case (final label?, .start))
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: theme.labelSpacing),
                            child: Text(label, style: theme.labelStyle),
                          ),
                        ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: tapSize, minHeight: tapSize),
                        child: Center(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: SizedBox.square(
                            dimension: theme.size,
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) => CustomPaint(
                                painter: _CheckboxPainter(
                                  levels: _levels,
                                  radius: theme.borderRadius,
                                  strokeWidth: theme.strokeWidth,
                                  checkColour: widget.checkColour ?? theme.checkColour,
                                  activeColour: widget.activeColour ?? theme.colourChecked,
                                  inactiveColour: widget.inactiveColour ?? theme.colourUnchecked,
                                  borderColour: widget.borderColour ?? theme.borderColourUnchecked,
                                  focusColour: _focused && enabled
                                      ? DievasTheme.coloursOf(context).border.focusIndicatorColour
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if ((widget.label, widget.labelPosition) case (final label?, .end))
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: theme.labelSpacing),
                            child: Text(label, style: theme.labelStyle),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _Levels _interpolate(DievasCheckboxValue previous) {
    final target = switch (previous) {
      .unchecked => (fill: 0.0, check: 0.0, dash: 0.0),
      .checked => (fill: 1.0, check: 1.0, dash: 0.0),
      .indeterminate => (fill: 1.0, check: 0.0, dash: 1.0),
    };
    final t = DievasTheme.animationOf(context).easingStandard.transform(_controller.value);
    return (
      fill: _from.fill + (target.fill - _from.fill) * t,
      check:
          _from.check +
          (target.check - _from.check) *
              (target.check > _from.check ? const Interval(0.5, 1).transform(t) : const Interval(0, 0.5).transform(t)),
      dash:
          _from.dash +
          (target.dash - _from.dash) *
              (target.dash > _from.dash ? const Interval(0.5, 1).transform(t) : const Interval(0, 0.5).transform(t)),
    );
  }

  void _toggle() => widget.onChanged?.call(switch ((widget.tristate, widget.value)) {
    (_, .unchecked) => .checked,
    (true, .checked) => .indeterminate,
    (true, .indeterminate) || (false, .checked) => .unchecked,
    (false, .indeterminate) => .checked,
  });
}

class _CheckboxPainter extends CustomPainter {
  const _CheckboxPainter({
    required this.levels,
    required this.radius,
    required this.strokeWidth,
    required this.checkColour,
    required this.activeColour,
    required this.inactiveColour,
    required this.borderColour,
    required this.focusColour,
  });

  final _Levels levels;
  final BorderRadius radius;
  final double strokeWidth;
  final Color checkColour;
  final Color activeColour;
  final Color inactiveColour;
  final Color borderColour;
  final Color? focusColour;

  @override
  void paint(Canvas canvas, Size size) {
    final shape = RoundedRectangleBorder(borderRadius: radius);
    final bounds = (Offset.zero & size).deflate(strokeWidth / 2);
    canvas.drawPath(shape.getOuterPath(bounds), Paint()..color = _blend(inactiveColour, activeColour, levels.fill));
    shape
        .copyWith(
          side: BorderSide(
            color: borderColour.withValues(alpha: borderColour.a * (1 - levels.fill)),
            width: strokeWidth,
          ),
        )
        .paint(canvas, bounds);
    if (focusColour case final colour?) {
      shape
          .copyWith(
            side: BorderSide(color: colour, width: strokeWidth),
          )
          .paint(canvas, bounds.inflate(strokeWidth * 2));
    }
    final paint = Paint()
      ..color = checkColour
      ..strokeWidth = strokeWidth
      ..style = .stroke
      ..strokeCap = .round
      ..strokeJoin = .round;
    if (levels.check > 0) {
      final path = Path()
        ..moveTo(size.width * 0.15, size.height * 0.45)
        ..lineTo(size.width * 0.4, size.height * 0.7)
        ..lineTo(size.width * 0.85, size.height * 0.25);
      final metric = path.computeMetrics().first;
      canvas.drawPath(metric.extractPath(0, metric.length * levels.check), paint);
    }
    if (levels.dash > 0) {
      canvas.drawLine(
        Offset(size.width * (0.5 - 0.3 * levels.dash), size.height / 2),
        Offset(size.width * (0.5 + 0.3 * levels.dash), size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CheckboxPainter old) =>
      levels != old.levels ||
      radius != old.radius ||
      strokeWidth != old.strokeWidth ||
      checkColour != old.checkColour ||
      activeColour != old.activeColour ||
      inactiveColour != old.inactiveColour ||
      borderColour != old.borderColour ||
      focusColour != old.focusColour;

  Color _blend(Color from, Color to, double t) {
    final alpha = from.a * (1 - t) + to.a * t;
    return switch (alpha) {
      0 => const Color(0x00000000),
      _ => Color.from(
        alpha: alpha,
        red: (from.r * from.a * (1 - t) + to.r * to.a * t) / alpha,
        green: (from.g * from.a * (1 - t) + to.g * to.a * t) / alpha,
        blue: (from.b * from.a * (1 - t) + to.b * to.a * t) / alpha,
      ),
    };
  }
}
