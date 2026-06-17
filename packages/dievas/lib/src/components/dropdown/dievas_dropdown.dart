import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A select-style dropdown that shows a trigger with the current selection
/// and opens an overlay with options on tap.
///
/// ```dart
/// String? selected;
/// DievasDropdown<String>(
///   options: ['Apple', 'Banana', 'Cherry'],
///   value: selected,
///   onChanged: (v) => selected = v,
///   hint: 'Choose a fruit',
/// )
/// ```
class DievasDropdown<T> extends StatefulWidget {
  const DievasDropdown({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
    this.labelBuilder,
    this.enabled = true,
  });

  /// The list of selectable values.
  final List<T> options;

  /// The currently selected value, or `null` if nothing is selected.
  final T? value;

  /// Called when the user selects an option. When `null` the dropdown is read-only.
  final ValueChanged<T>? onChanged;

  /// Placeholder text shown when [value] is `null`.
  final String? hint;

  /// Optional label displayed above the trigger.
  final String? label;

  /// Maps each value to its display string. Defaults to [Object.toString].
  final String Function(T)? labelBuilder;

  /// When `false` the dropdown is dimmed and does not respond to taps.
  final bool enabled;

  @override
  State<DievasDropdown<T>> createState() => _DievasDropdownState<T>();
}

class _DievasDropdownState<T> extends State<DievasDropdown<T>> {
  final _link = LayerLink();
  final _triggerKey = GlobalKey();
  OverlayEntry? _overlay;
  bool _isOpen = false;

  @override
  void dispose() {
    _overlay?.remove();
    _overlay = null;
    super.dispose();
  }

  void _toggleOverlay() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final renderBox = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    final triggerWidth = renderBox?.size.width ?? double.infinity;

    _overlay = OverlayEntry(
      builder: (context) => _DropdownOverlay<T>(
        link: _link,
        width: triggerWidth,
        options: widget.options,
        value: widget.value,
        onSelected: _onSelected,
        onDismiss: _removeOverlay,
        labelBuilder: widget.labelBuilder ?? ((T v) => v.toString()),
      ),
    );
    Overlay.of(context).insert(_overlay!);
    _isOpen = true;
    setState(() {});
  }

  void _removeOverlay() {
    _overlay?.remove();
    _overlay = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  void _onSelected(T option) {
    _removeOverlay();
    widget.onChanged?.call(option);
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dropdown;
    final labelOf = widget.labelBuilder ?? ((T v) => v.toString());
    final value = widget.value;
    final hasValue = value != null;
    final selectedLabel = hasValue ? labelOf(value) : null;

    final trigger = GestureDetector(
      key: _triggerKey,
      onTap: (widget.enabled && widget.onChanged != null) ? _toggleOverlay : null,
      child: Container(
        constraints: BoxConstraints(minHeight: theme.minHeight),
        padding: theme.triggerPadding,
        decoration: BoxDecoration(
          color: theme.triggerBgColor,
          borderRadius: theme.borderRadius,
          border: Border.all(color: _isOpen ? theme.triggerBorderColorFocused : theme.triggerBorderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(selectedLabel ?? widget.hint ?? '', style: hasValue ? theme.triggerStyle : theme.hintStyle),
            ),
            SizedBox(width: theme.iconSize / 2),
            Icon(Icons.keyboard_arrow_down, size: theme.iconSize, color: theme.iconColor),
          ],
        ),
      ),
    );

    final label = widget.label;
    final content = label != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.labelStyle),
              SizedBox(height: theme.labelSpacing),
              trigger,
            ],
          )
        : trigger;

    final opacity = widget.enabled ? 1.0 : theme.disabledOpacity;

    return CompositedTransformTarget(
      link: _link,
      child: Opacity(opacity: opacity, child: content),
    );
  }
}

class _DropdownOverlay<T> extends StatelessWidget {
  const _DropdownOverlay({
    required this.link,
    required this.width,
    required this.options,
    required this.value,
    required this.onSelected,
    required this.onDismiss,
    required this.labelBuilder,
  });

  final LayerLink link;
  final double width;
  final List<T> options;
  final T? value;
  final ValueChanged<T> onSelected;
  final VoidCallback onDismiss;
  final String Function(T) labelBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dropdown;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(onTap: onDismiss, behavior: .opaque, child: const SizedBox.expand()),
        ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: .bottomLeft,
          followerAnchor: .topLeft,
          offset: const Offset(0, 4),
          child: Material(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: theme.overlayBgColor,
                borderRadius: theme.overlayBorderRadius,
                border: .all(color: theme.overlayBorderColor),
                boxShadow: theme.overlayElevation,
              ),
              constraints: const BoxConstraints(maxHeight: 240),
              child: ListView(
                padding: .zero,
                shrinkWrap: true,
                children: [
                  for (final option in options)
                    _OptionRow(
                      label: labelBuilder(option),
                      isSelected: value != null && option == value,
                      padding: theme.optionPadding,
                      style: theme.optionStyle,
                      textColor: theme.optionTextColor,
                      selectedColor: theme.optionSelectedColor,
                      onTap: () => onSelected(option),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.isSelected,
    required this.padding,
    required this.style,
    required this.textColor,
    required this.selectedColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  final TextStyle style;
  final Color textColor;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding,
      decoration: BoxDecoration(color: isSelected ? selectedColor : null),
      child: Text(label, style: style.copyWith(color: textColor)),
    ),
  );
}
