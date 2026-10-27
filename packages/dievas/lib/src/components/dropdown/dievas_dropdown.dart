import 'package:flutter/material.dart' show Icons, Theme;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Positions dropdown content relative to its trigger.
enum DievasDropdownAnchorPosition {
  top,
  topLeft,
  topRight,
  bottom,
  bottomLeft,
  bottomRight,
  left,
  right,
  vertical,
  horizontal,
}

/// A themed dropdown that supports selectable options or caller-built menus.
///
/// Use [selectedValues] and [onMultiChanged] for multi select content. Supply
/// [contentBuilder] and [child] to build custom and nested menus.
class DievasDropdown<T> extends StatefulWidget {
  const DievasDropdown({
    super.key,
    this.options = const [],
    this.value,
    this.selectedValues,
    this.onChanged,
    this.onMultiChanged,
    this.hint,
    this.label,
    this.labelBuilder,
    this.child,
    this.content,
    this.triggerBuilder,
    this.contentBuilder,
    this.optionBuilder,
    this.enabled = true,
    this.show,
    this.constrainWidthToChild = true,
    this.dropdownAnchorPosition = .bottom,
    this.followerAnchor,
    this.targetAnchor,
    this.offset,
    this.minHeight,
    this.minWidth,
    this.maxHeight,
    this.maxWidth,
    this.distanceToTarget,
    this.dropdownMargin,
    this.contentPadding,
    this.backgroundColour,
    this.borderColour,
    this.borderRadius,
    this.borderWidth,
    this.showBorder = true,
    this.decoration,
    this.shadow,
    this.showShadow = true,
    this.semanticLabel,
    this.groupId,
    this.onTapOutside,
    this.onOpenChanged,
  });

  final List<T> options;
  final T? value;
  final List<T>? selectedValues;
  final ValueChanged<T>? onChanged;
  final ValueChanged<List<T>>? onMultiChanged;
  final String? hint;
  final String? label;
  final String Function(T)? labelBuilder;
  final Widget? child;

  /// Caller owned menu content, matching the controlled overlay composition.
  /// Takes precedence over [contentBuilder] and [options].
  final Widget? content;
  final Widget Function(BuildContext context, bool open, VoidCallback? toggle)? triggerBuilder;
  final Widget Function(BuildContext context, ValueChanged<T> select, VoidCallback dismiss)? contentBuilder;
  final Widget Function(BuildContext context, T option, bool selected, VoidCallback select)? optionBuilder;
  final bool enabled;

  /// Optional externally supplied visibility, with changes reported by [onOpenChanged].
  final bool? show;
  final bool constrainWidthToChild;
  final DievasDropdownAnchorPosition dropdownAnchorPosition;
  final Alignment? followerAnchor;
  final Alignment? targetAnchor;
  final Offset? offset;
  final double? minHeight;
  final double? minWidth;
  final double? maxHeight;
  final double? maxWidth;
  final double? distanceToTarget;
  final EdgeInsetsGeometry? dropdownMargin;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColour;
  final Color? borderColour;
  final BorderRadiusGeometry? borderRadius;
  final double? borderWidth;
  final bool showBorder;
  final Decoration? decoration;
  final List<BoxShadow>? shadow;
  final bool showShadow;
  final String? semanticLabel;
  final Object? groupId;
  final VoidCallback? onTapOutside;
  final ValueChanged<bool>? onOpenChanged;

  @override
  State<DievasDropdown<T>> createState() => _DievasDropdownState<T>();
}

class _DievasDropdownState<T> extends State<DievasDropdown<T>> with SingleTickerProviderStateMixin {
  final _link = LayerLink();
  final _triggerKey = GlobalKey();
  final _privateTapRegionGroup = Object();
  OverlayEntry? _overlay;
  late final AnimationController _controller;
  late final CurvedAnimation _curve;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration.zero);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    if (widget.show == true) _scheduleOverlayUpdate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DievasTheme.componentsOf(context).dropdown.animationDuration;
    _curve.curve = DievasTheme.animationOf(context).easingStandard;
  }

  @override
  void didUpdateWidget(DievasDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isOpen || widget.show == true) _scheduleOverlayUpdate();
  }

  @override
  void dispose() {
    _overlay?.remove();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dropdown;
    final labelOf = widget.labelBuilder ?? ((T value) => value.toString());
    final values = widget.selectedValues;
    final hasSelection = values != null ? values.isNotEmpty : widget.value != null;
    final selectedLabel = switch ((values, widget.value)) {
      (final values?, _) when values.isNotEmpty => '${values.length} selected',
      (_, final value?) => labelOf(value),
      _ => null,
    };
    final trigger = switch ((widget.triggerBuilder, widget.child)) {
      (final builder?, _) => builder(context, _isOpen, _canOpen ? _toggleOverlay : null),
      (null, final child?) => GestureDetector(onTap: _canOpen ? _toggleOverlay : null, child: child),
      _ => GestureDetector(
        behavior: .opaque,
        onTap: _canOpen ? _toggleOverlay : null,
        child: Container(
          constraints: BoxConstraints(minHeight: theme.minHeight),
          padding: theme.triggerPadding,
          decoration: BoxDecoration(
            color: theme.triggerBgColour,
            borderRadius: theme.borderRadius,
            border: .all(color: _isOpen ? theme.triggerBorderColourFocused : theme.triggerBorderColour),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              Expanded(
                child: Text(
                  selectedLabel ?? widget.hint ?? '',
                  style: hasSelection ? theme.triggerStyle : theme.hintStyle,
                ),
              ),
              SizedBox(width: theme.iconSize / 2),
              AnimatedRotation(
                duration: theme.animationDuration,
                turns: _isOpen ? .5 : 0,
                child: Icon(Icons.keyboard_arrow_down, size: theme.iconSize, color: theme.iconColour),
              ),
            ],
          ),
        ),
      ),
    };
    final labeledTrigger = switch ((widget.label, trigger)) {
      (final label?, final trigger) => Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(label, style: theme.labelStyle),
          SizedBox(height: theme.labelSpacing),
          trigger,
        ],
      ),
      (null, final trigger) => trigger,
    };

    return TapRegion(
      groupId: _effectiveGroupId,
      child: CompositedTransformTarget(
        key: _triggerKey,
        link: _link,
        child: Opacity(opacity: widget.enabled ? 1 : theme.disabledOpacity, child: labeledTrigger),
      ),
    );
  }

  Object get _effectiveGroupId => widget.groupId ?? _privateTapRegionGroup;

  bool get _canOpen =>
      switch ((widget.enabled, widget.onChanged, widget.onMultiChanged, widget.content, widget.contentBuilder)) {
        (false, _, _, _, _) || (true, null, null, null, null) => false,
        _ => true,
      };

  void _toggleOverlay() => _isOpen ? _removeOverlay() : _showOverlay();

  void _showOverlay() {
    final overlay = OverlayEntry(
      builder: (_) => DievasTheme(
        data: DievasTheme.of(context),
        child: Theme(
          data: Theme.of(context),
          child: Directionality(
            textDirection: Directionality.of(context),
            child: _DropdownOverlay<T>(
              dropdown: widget,
              sourceContext: context,
              triggerKey: _triggerKey,
              link: _link,
              opacity: _curve,
              groupId: _effectiveGroupId,
              onSelect: _select,
              onDismiss: _removeOverlay,
              onTapOutside: _dismissFromOutside,
            ),
          ),
        ),
      ),
    );
    _overlay = overlay;
    Overlay.of(context).insert(overlay);
    setState(() => _isOpen = true);
    _controller.forward(from: 0);
    widget.onOpenChanged?.call(true);
  }

  void _removeOverlay() {
    if (!_isOpen) return;
    final overlay = _overlay;
    _overlay = null;
    _controller.reverse().whenCompleteOrCancel(() => overlay?.remove());
    setState(() => _isOpen = false);
    widget.onOpenChanged?.call(false);
  }

  void _dismissFromOutside() {
    widget.onTapOutside?.call();
    _removeOverlay();
  }

  void _select(T option) {
    if (widget.selectedValues case final selected?) {
      final next = [...selected];
      if (next.contains(option)) {
        next.remove(option);
      } else {
        next.add(option);
      }
      widget.onMultiChanged?.call(next);
      _overlay?.markNeedsBuild();
      return;
    }
    widget.onChanged?.call(option);
    _removeOverlay();
  }

  void _scheduleOverlayUpdate() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;

    switch ((widget.show, _canOpen, _isOpen)) {
      case (_, false, true) || (false, _, true):
        _removeOverlay();
      case (true, true, false):
        _showOverlay();
      default:
        _overlay?.markNeedsBuild();
    }
  });
}

class _DropdownOverlay<T> extends StatelessWidget {
  const _DropdownOverlay({
    required this.dropdown,
    required this.sourceContext,
    required this.triggerKey,
    required this.link,
    required this.opacity,
    required this.groupId,
    required this.onSelect,
    required this.onDismiss,
    required this.onTapOutside,
  });

  final DievasDropdown<T> dropdown;
  final BuildContext sourceContext;
  final GlobalKey triggerKey;
  final LayerLink link;
  final Animation<double> opacity;
  final Object groupId;
  final ValueChanged<T> onSelect;
  final VoidCallback onDismiss;
  final VoidCallback onTapOutside;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dropdown;
    final overlayBox = Overlay.of(sourceContext).context.findRenderObject() as RenderBox;
    final targetBox = triggerKey.currentContext?.findRenderObject() as RenderBox?;
    final targetSize = targetBox?.size ?? Size.zero;
    final targetOrigin = targetBox?.localToGlobal(Offset.zero, ancestor: overlayBox) ?? Offset.zero;
    final targetCenter = targetOrigin + Offset(targetSize.width / 2, targetSize.height / 2);
    final position = _resolvePosition(overlayBox.size, targetCenter);
    final anchors = _anchors(position);
    final distance = dropdown.distanceToTarget ?? theme.distanceToTarget;
    final margin = (dropdown.dropdownMargin ?? theme.dropdownMargin).resolve(Directionality.of(sourceContext));
    final availableWidth = switch (position) {
      .left => targetOrigin.dx - margin.left - distance,
      .right => overlayBox.size.width - targetOrigin.dx - targetSize.width - margin.right - distance,
      .topLeft || .bottomLeft => overlayBox.size.width - targetOrigin.dx - margin.horizontal,
      .topRight || .bottomRight => targetOrigin.dx + targetSize.width - margin.horizontal,
      _ => overlayBox.size.width - margin.horizontal,
    }.clamp(0.0, overlayBox.size.width);
    final minWidth = (dropdown.minWidth ?? 0).clamp(0.0, availableWidth);
    final width = switch (dropdown.constrainWidthToChild) {
      true => targetSize.width.clamp(minWidth, availableWidth),
      false => (dropdown.maxWidth ?? availableWidth).clamp(minWidth, availableWidth),
    };
    final borderRadius = dropdown.borderRadius ?? theme.overlayBorderRadius;
    final background = dropdown.backgroundColour ?? theme.overlayBgColour;
    final border = dropdown.borderColour ?? theme.overlayBorderColour;
    final shadows = switch ((dropdown.showShadow, dropdown.shadow)) {
      (false, _) => const <BoxShadow>[],
      (true, final shadow?) => shadow,
      _ => theme.shadow,
    };
    final content = switch ((dropdown.content, dropdown.contentBuilder)) {
      (final content?, _) => content,
      (_, final builder?) => builder(context, onSelect, onDismiss),
      _ => _DropdownOptions<T>(dropdown: dropdown, onSelect: onSelect),
    };

    return Positioned.fill(
      child: Align(
        alignment: .topLeft,
        child: CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          targetAnchor: dropdown.targetAnchor ?? anchors.$1,
          followerAnchor: dropdown.followerAnchor ?? anchors.$2,
          offset: dropdown.offset ?? _offset(position, distance),
          child: TapRegion(
            groupId: groupId,
            onTapOutside: (event) {
              final viewport = overlayBox.localToGlobal(Offset.zero) & overlayBox.size;
              if (viewport.contains(event.position)) onTapOutside();
            },
            child: FadeTransition(
              opacity: opacity,
              child: Semantics(
                label: dropdown.semanticLabel,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: minWidth,
                    maxWidth: width,
                    minHeight: dropdown.minHeight ?? 0,
                    maxHeight: dropdown.maxHeight ?? theme.maxHeight,
                  ),
                  child: Container(
                    width: width,
                    padding: dropdown.contentPadding ?? theme.contentPadding,
                    decoration: switch (dropdown.decoration) {
                      final decoration? => decoration,
                      null => BoxDecoration(
                        color: background,
                        borderRadius: borderRadius,
                        border: switch ((dropdown.showBorder, dropdown.borderWidth)) {
                          (false, _) => null,
                          (true, final width?) => Border.all(color: border, width: width),
                          (true, null) => Border.all(color: border, width: theme.borderWidth),
                        },
                        boxShadow: shadows,
                      ),
                    },
                    child: DefaultTextStyle(
                      style: theme.optionStyle.copyWith(color: theme.optionTextColour),
                      child: IconTheme(
                        data: IconThemeData(color: theme.iconColour),
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

  DievasDropdownAnchorPosition _resolvePosition(Size overlay, Offset center) {
    final direction = Directionality.of(sourceContext);
    final position = switch ((dropdown.dropdownAnchorPosition, direction)) {
      (.vertical, _) =>
        center.dy < overlay.height / 2 ? DievasDropdownAnchorPosition.bottom : DievasDropdownAnchorPosition.top,
      (.horizontal, _) =>
        center.dx < overlay.width / 2 ? DievasDropdownAnchorPosition.right : DievasDropdownAnchorPosition.left,
      (.left, .rtl) => DievasDropdownAnchorPosition.right,
      (.right, .rtl) => DievasDropdownAnchorPosition.left,
      (.topLeft, .rtl) => DievasDropdownAnchorPosition.topRight,
      (.topRight, .rtl) => DievasDropdownAnchorPosition.topLeft,
      (.bottomLeft, .rtl) => DievasDropdownAnchorPosition.bottomRight,
      (.bottomRight, .rtl) => DievasDropdownAnchorPosition.bottomLeft,
      (final position, _) => position,
    };
    return position;
  }

  (Alignment, Alignment) _anchors(DievasDropdownAnchorPosition position) => switch (position) {
    .top => (.topCenter, .bottomCenter),
    .topLeft => (.topLeft, .bottomLeft),
    .topRight => (.topRight, .bottomRight),
    .bottom => (.bottomCenter, .topCenter),
    .bottomLeft => (.bottomLeft, .topLeft),
    .bottomRight => (.bottomRight, .topRight),
    .left => (.centerLeft, .centerRight),
    .right => (.centerRight, .centerLeft),
    .vertical => (.bottomCenter, .topCenter),
    .horizontal => (.centerRight, .centerLeft),
  };

  Offset _offset(DievasDropdownAnchorPosition position, double distance) => switch (position) {
    .top || .topLeft || .topRight => Offset(0, -distance),
    .bottom || .bottomLeft || .bottomRight => Offset(0, distance),
    .left => Offset(-distance, 0),
    .right => Offset(distance, 0),
    .vertical || .horizontal => .zero,
  };
}

class _DropdownOptions<T> extends StatelessWidget {
  const _DropdownOptions({required this.dropdown, required this.onSelect});

  final DievasDropdown<T> dropdown;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) => ListView(
    padding: .zero,
    shrinkWrap: true,
    children: [
      for (final option in dropdown.options) _DropdownOption<T>(dropdown: dropdown, option: option, onSelect: onSelect),
    ],
  );
}

class _DropdownOption<T> extends StatelessWidget {
  const _DropdownOption({required this.dropdown, required this.option, required this.onSelect});

  final DievasDropdown<T> dropdown;
  final T option;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).dropdown;
    final selected = switch (dropdown.selectedValues) {
      final values? => values.contains(option),
      null => dropdown.value == option,
    };
    return switch (dropdown.optionBuilder) {
      final builder? => builder(context, option, selected, () => onSelect(option)),
      null => _OptionRow(
        label: (dropdown.labelBuilder ?? ((T value) => value.toString()))(option),
        isSelected: selected,
        padding: theme.optionPadding,
        style: theme.optionStyle,
        textColour: theme.optionTextColour,
        selectedColour: theme.optionSelectedColour,
        onTap: () => onSelect(option),
      ),
    };
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.isSelected,
    required this.padding,
    required this.style,
    required this.textColour,
    required this.selectedColour,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  final TextStyle style;
  final Color textColour;
  final Color selectedColour;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: isSelected,
    child: FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => onTap())},
      child: GestureDetector(
        behavior: .opaque,
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(color: isSelected ? selectedColour : null),
          child: Text(label, style: style.copyWith(color: textColour)),
        ),
      ),
    ),
  );
}
