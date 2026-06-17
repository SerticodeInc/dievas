import 'package:dievas/src/theme/component/radio/dievas_radio_theme_data.dart' show DievasRadioThemeData;
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A custom-drawn radio button that uses only Dievas theme tokens.
///
/// Follows the standard radio group pattern: each button in a group shares
/// the same [groupValue] and emits its own [value] via [onChanged].
///
/// Moon reference: Radio
///
/// ```dart
/// DievasRadio<String>(
///   value: 'option_a',
///   groupValue: selectedOption,
///   onChanged: (v) => setState(() => selectedOption = v),
/// )
/// DievasRadio<String>(
///   value: 'option_b',
///   groupValue: selectedOption,
///   label: 'Option B',
///   onChanged: (v) => setState(() => selectedOption = v),
/// )
/// ```
class DievasRadio<T> extends StatelessWidget {
  const DievasRadio({super.key, required this.value, required this.groupValue, required this.onChanged, this.label});

  /// The value this radio button represents.
  final T value;

  /// The currently selected value in the group.
  final T? groupValue;

  /// Called with [value] when the user taps this button.
  /// `null` → disabled.
  final ValueChanged<T>? onChanged;

  /// Optional label rendered to the right of the circle.
  final String? label;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).radio;

    Widget circle = _DievasRadioCircle(isSelected: _isSelected, theme: theme);

    if (label case final text?) {
      circle = Row(
        mainAxisSize: .min,
        children: [
          circle,
          SizedBox(width: theme.labelSpacing),
          DefaultTextStyle(
            style: theme.labelStyle,
            child: Flexible(child: Text(text)),
          ),
        ],
      );
    }

    if (onChanged == null) {
      return Opacity(opacity: theme.disabledOpacity, child: circle);
    }

    return GestureDetector(onTap: () => onChanged!(value), behavior: .opaque, child: circle);
  }
}

class _DievasRadioCircle extends StatelessWidget {
  const _DievasRadioCircle({required this.isSelected, required this.theme});

  final bool isSelected;
  final DievasRadioThemeData theme;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: theme.size,
    child: CustomPaint(
      painter: _RadioPainter(isSelected: isSelected, theme: theme),
    ),
  );
}

class _RadioPainter extends CustomPainter {
  const _RadioPainter({required this.isSelected, required this.theme});

  final bool isSelected;
  final DievasRadioThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer ring
    if (isSelected) {
      // Filled outer ring using brand colour
      final fillPaint = Paint()
        ..color = theme.colorSelected
        ..style = .fill;
      canvas.drawCircle(center, radius, fillPaint);

      // Inner dot (white / token)
      final dotPaint = Paint()
        ..color = theme.dotColor
        ..style = .fill;
      canvas.drawCircle(center, theme.dotSize / 2, dotPaint);
    } else {
      // Transparent fill + border ring
      final borderPaint = Paint()
        ..color = theme.borderColorUnselected
        ..style = .stroke
        ..strokeWidth = theme.strokeWidth;
      canvas.drawCircle(center, radius - theme.strokeWidth / 2, borderPaint);
    }
  }

  @override
  bool shouldRepaint(_RadioPainter old) => old.isSelected != isSelected || old.theme != theme;
}
