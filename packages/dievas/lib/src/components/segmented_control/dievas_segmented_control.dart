import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A horizontal row of mutually exclusive segments.
///
/// The active segment displays with the theme's selected background and text
/// colour; inactive segments use the unselected colours. An [AnimatedContainer]
/// provides a smooth visual transition when the selection changes.
///
/// ```dart
/// DievasSegmentedControl(
///   options: ['Day', 'Week', 'Month'],
///   value: 'Week',
///   onChanged: (v) => print(v),
/// )
/// ```
class DievasSegmentedControl<T> extends StatelessWidget {
  const DievasSegmentedControl({
    super.key,
    required this.options,
    required this.value,
    this.onChanged,
    this.labelBuilder,
    this.enabled = true,
  });

  /// The list of selectable values.
  final List<T> options;

  /// The currently selected value.
  final T value;

  /// Called when the user taps a segment. Receives the tapped value.
  /// When `null` the control is read-only.
  final ValueChanged<T>? onChanged;

  /// Maps each option to its display label. Defaults to [Object.toString].
  final String Function(T)? labelBuilder;

  /// When `false` the control is dimmed and does not respond to taps.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).segmentedControl;
    final labelOf = labelBuilder ?? ((T v) => v.toString());

    final opacity = enabled ? 1.0 : theme.disabledOpacity;
    return Opacity(
      opacity: opacity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: theme.borderRadius,
          border: Border.all(color: theme.borderColor),
          color: theme.bgColor,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < options.length; i++) ...[
                if (i > 0)
                  SizedBox(
                    width: 1,
                    child: DecoratedBox(decoration: BoxDecoration(color: theme.borderColor)),
                  ),
                _SegmentTile(
                  key: ValueKey(options[i]),
                  label: labelOf(options[i]),
                  isSelected: options[i] == value,
                  animationDuration: theme.animationDuration,
                  minSegmentWidth: theme.minSegmentWidth,
                  minHeight: theme.minHeight,
                  padding: theme.padding,
                  borderRadius: theme.borderRadius,
                  selectedBgColor: theme.selectedBgColor,
                  selectedLabelStyle: theme.selectedLabelStyle.copyWith(color: theme.selectedTextColor),
                  unselectedLabelStyle: theme.labelStyle.copyWith(color: theme.textColor),
                  onTap: (enabled && onChanged != null) ? () => onChanged!(options[i]) : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentTile extends StatelessWidget {
  const _SegmentTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.animationDuration,
    required this.minSegmentWidth,
    required this.minHeight,
    required this.padding,
    required this.borderRadius,
    required this.selectedBgColor,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Duration animationDuration;
  final double minSegmentWidth;
  final double minHeight;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color selectedBgColor;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeOutCubic,
        constraints: BoxConstraints(minWidth: minSegmentWidth, minHeight: minHeight),
        padding: padding,
        decoration: BoxDecoration(color: isSelected ? selectedBgColor : null, borderRadius: borderRadius),
        alignment: Alignment.center,
        child: Text(label, style: isSelected ? selectedLabelStyle : unselectedLabelStyle),
      ),
    );
  }
}
