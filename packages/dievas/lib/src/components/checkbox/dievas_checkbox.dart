import 'package:dievas/src/theme/component/checkbox/dievas_checkbox_theme_data.dart' show DievasCheckboxThemeData;
import 'package:flutter/widgets.dart';

import '../../theme/dievas_theme.dart';

/// State values for [DievasCheckbox].
enum DievasCheckboxValue {
  /// Box is ticked.
  checked,

  /// Box is clear.
  unchecked,

  /// Indeterminate / mixed state — renders a dash.
  indeterminate,
}

/// A custom-drawn checkbox that uses only Dievas theme tokens.
///
/// Supports three states via [DievasCheckboxValue]: checked, unchecked, and
/// indeterminate. A simple on/off use-case can map `bool` to `.checked` /
/// `.unchecked` at the call-site.
///
/// Moon reference: Checkbox
///
/// ```dart
/// DievasCheckbox(
///   value: isChecked ? .checked : .unchecked,
///   onChanged: (v) => setState(() => isChecked = v == .checked),
/// )
/// DievasCheckbox(value: .checked, label: 'Accept terms', onChanged: (_) {})
/// DievasCheckbox(value: .checked, onChanged: null) // disabled
/// ```
class DievasCheckbox extends StatelessWidget {
  const DievasCheckbox({super.key, required this.value, required this.onChanged, this.label});

  /// Current three-state value.
  final DievasCheckboxValue value;

  /// Called when the user taps. Receives the next toggled state.
  /// `null` renders the checkbox as disabled.
  final ValueChanged<DievasCheckboxValue>? onChanged;

  /// Optional label rendered to the right of the box.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).checkbox;
    final isDisabled = onChanged == null;

    Widget box = _CheckboxPainter(value: value, theme: theme);

    if (label case final text?) {
      box = Row(
        mainAxisSize: .min,
        children: [
          box,
          SizedBox(width: theme.labelSpacing),
          DefaultTextStyle(
            style: theme.labelStyle,
            child: Flexible(child: Text(text)),
          ),
        ],
      );
    }

    if (isDisabled) {
      return Opacity(opacity: theme.disabledOpacity, child: box);
    }

    return GestureDetector(onTap: () => onChanged!(_nextValue()), behavior: .opaque, child: box);
  }

  DievasCheckboxValue _nextValue() => switch (value) {
    .checked => .unchecked,
    .unchecked => .checked,
    .indeterminate => .checked,
  };
}

// Custom painter for the checkbox box and its check-mark / dash.
class _CheckboxPainter extends StatelessWidget {
  const _CheckboxPainter({required this.value, required this.theme});

  final DievasCheckboxValue value;
  final DievasCheckboxThemeData theme;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: theme.size,
    child: CustomPaint(
      painter: _BoxPainter(value: value, theme: theme),
    ),
  );
}

class _BoxPainter extends CustomPainter {
  const _BoxPainter({required this.value, required this.theme});

  final DievasCheckboxValue value;
  final DievasCheckboxThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final isChecked = value == .checked;
    final isIndeterminate = value == .indeterminate;
    final isActive = isChecked || isIndeterminate;

    final rrect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: theme.borderRadius.topLeft,
      topRight: theme.borderRadius.topRight,
      bottomLeft: theme.borderRadius.bottomLeft,
      bottomRight: theme.borderRadius.bottomRight,
    );

    // Fill
    final fillPaint = Paint()
      ..color = isActive ? theme.colorChecked : theme.colorUnchecked
      ..style = .fill;
    canvas.drawRRect(rrect, fillPaint);

    // Border (only in unchecked state — active state uses fill colour)
    if (!isActive) {
      final borderPaint = Paint()
        ..color = theme.borderColorUnchecked
        ..style = .stroke
        ..strokeWidth = theme.strokeWidth;
      canvas.drawRRect(rrect, borderPaint);
    }

    // Check-mark or dash
    if (isChecked) {
      _drawCheck(canvas, size);
    } else if (isIndeterminate) {
      _drawDash(canvas, size);
    }
  }

  void _drawCheck(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.checkColor
      ..style = .stroke
      ..strokeWidth = theme.strokeWidth
      ..strokeCap = .round
      ..strokeJoin = .round;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.5)
      ..lineTo(size.width * 0.42, size.height * 0.72)
      ..lineTo(size.width * 0.8, size.height * 0.28);

    canvas.drawPath(path, paint);
  }

  void _drawDash(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.checkColor
      ..style = .stroke
      ..strokeWidth = theme.strokeWidth
      ..strokeCap = .round;

    canvas.drawLine(Offset(size.width * 0.25, size.height * 0.5), Offset(size.width * 0.75, size.height * 0.5), paint);
  }

  @override
  bool shouldRepaint(_BoxPainter old) => old.value != value || old.theme != theme;
}
