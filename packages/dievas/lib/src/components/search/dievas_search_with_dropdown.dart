import 'package:flutter/material.dart';

import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/components/search/dievas_search_field.dart';

export 'dievas_search_field.dart' show DievasSearchSize;
import 'package:dievas/src/components/dropdown/dievas_dropdown.dart';
import 'package:dievas/src/components/menu_item/dievas_menu_item.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Search input composed with [DievasDropdown] and [DievasMenuItem].
///
/// Tapping the input opens all matching items, including for an empty query.
/// Selecting a result retains its label and releases focus. Outside dismissal
/// clears an unselected query; Clear resets the results without closing an open
/// menu. A zero gap joins the input and menu corners as in the Moon reference.
class DievasSearchWithDropdown<T> extends StatefulWidget {
  const DievasSearchWithDropdown({
    super.key,
    required this.items,
    required this.displayString,
    required this.onSelected,
    this.hint,
    this.size,
    this.filter,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.initialQuery,
    this.show,
    this.onChanged,
    this.onOpenChanged,
    this.activeBorderColour,
    this.inactiveBorderColour,
    this.hoverBorderColour,
    this.backgroundColour,
    this.borderRadius,
    this.distanceToTarget,
    this.maxHeight,
    this.showShadow = true,
    this.hasFloatingLabel = false,
    this.clearLabel,
    this.noResultsText,
  });

  final List<T> items;
  final String Function(T) displayString;

  /// Called after selection is retained in the input and the menu is dismissed.
  final ValueChanged<T> onSelected;
  final String? hint;
  final DievasSearchSize? size;
  final bool Function(T item, String query)? filter;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final T? initialValue;
  final String? initialQuery;
  final bool? show;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onOpenChanged;
  final Color? activeBorderColour;
  final Color? inactiveBorderColour;
  final Color? hoverBorderColour;
  final Color? backgroundColour;
  final BorderRadiusGeometry? borderRadius;
  final double? distanceToTarget;
  final double? maxHeight;
  final bool showShadow;
  final bool hasFloatingLabel;
  final String? clearLabel;
  final String? noResultsText;

  @override
  State<DievasSearchWithDropdown<T>> createState() => _DievasSearchWithDropdownState<T>();
}

class _DievasSearchWithDropdownState<T> extends State<DievasSearchWithDropdown<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String _lastQuery;
  T? _selected;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
    _open = widget.show ?? false;
    _controller = switch (widget.controller) {
      final controller? => controller,
      _ => TextEditingController(
        text: switch ((widget.initialQuery, widget.initialValue)) {
          (final query?, _) => query,
          (_, final value?) => widget.displayString(value),
          _ => '',
        },
      ),
    };
    _lastQuery = _controller.text;
    _controller.addListener(_onControllerChanged);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(DievasSearchWithDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller = switch ((oldWidget.controller, widget.controller)) {
      (final previous, final next) when previous != next => _replaceController(previous, next),
      _ => _controller,
    };
    _focusNode = switch ((oldWidget.focusNode, widget.focusNode)) {
      (final previous, final next) when previous != next => _replaceFocusNode(previous, next),
      _ => _focusNode,
    };
    _open = switch ((widget.enabled, widget.show)) {
      (false, _) => false,
      (true, final show?) => show,
      _ => _open,
    };
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).search;
    final direction = Directionality.of(context);
    final strings = DievasLocalizations.of(context);
    final radius = (widget.borderRadius ?? theme.borderRadius).resolve(direction);
    final distance = widget.distanceToTarget ?? DievasTheme.spacingOf(context).none;
    final joined = _open && widget.enabled && distance == 0;
    final inputRadius = switch (joined) {
      true => BorderRadius.only(topLeft: radius.topLeft, topRight: radius.topRight),
      false => radius,
    };
    final menuRadius = switch (joined) {
      true => BorderRadius.only(bottomLeft: radius.bottomLeft, bottomRight: radius.bottomRight),
      false => radius,
    };
    final borderColour = widget.inactiveBorderColour ?? theme.borderColour;
    final background = widget.backgroundColour ?? theme.bgColour;
    final results = _results;
    final side = BorderSide(color: borderColour, width: theme.strokeWidth);
    final hint = widget.hint ?? strings.searchHint;

    return DievasDropdown<T>(
      show: _open && widget.enabled,
      enabled: widget.enabled,
      constrainWidthToChild: true,
      distanceToTarget: distance,
      maxHeight: widget.maxHeight ?? theme.resultMaxHeight,
      contentPadding: EdgeInsets.all(DievasTheme.spacingOf(context).none),
      borderRadius: menuRadius,
      onTapOutside: _dismiss,
      onOpenChanged: (open) {
        if (!open && _open) _setOpen(false);
      },
      decoration: BoxDecoration(
        color: background,
        borderRadius: menuRadius,
        border: Border(left: side, right: side, bottom: side, top: joined ? BorderSide.none : side),
        boxShadow: widget.showShadow ? theme.shadow : const [],
      ),
      content: ClipRRect(
        borderRadius: menuRadius,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: switch (results.isEmpty) {
            true => DievasMenuItem(label: widget.noResultsText ?? strings.searchNoResults),
            false => _SearchResults<T>(results: results, displayString: widget.displayString, onSelect: _select),
          },
        ),
      ),
      child: DievasSearchField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        hasFloatingLabel: widget.hasFloatingLabel,
        size: widget.size,
        hint: hint,
        clearLabel: widget.clearLabel,
        borderRadius: inputRadius,
        backgroundColour: background,
        activeBorderColour: widget.activeBorderColour,
        inactiveBorderColour: widget.inactiveBorderColour,
        hoverBorderColour: widget.hoverBorderColour,
        onSearch: _search,
        onClear: _clear,
      ),
    );
  }

  List<T> get _results {
    final query = _controller.text.trim();
    return widget.items.where((item) => (widget.filter ?? _defaultFilter)(item, query)).toList();
  }

  bool get _selectionMatches => switch (_selected) {
    final item? => widget.displayString(item) == _controller.text,
    null => false,
  };

  TextEditingController _replaceController(TextEditingController? previous, TextEditingController? next) {
    final value = _controller.value;
    _controller.removeListener(_onControllerChanged);
    if (previous case null) _controller.dispose();
    final controller = switch (next) {
      final controller? => controller,
      null => TextEditingController.fromValue(value),
    };
    _lastQuery = controller.text;
    controller.addListener(_onControllerChanged);
    return controller;
  }

  FocusNode _replaceFocusNode(FocusNode? previous, FocusNode? next) {
    if (previous case null) _focusNode.dispose();
    return switch (next) {
      final focusNode? => focusNode,
      null => FocusNode(),
    };
  }

  bool _defaultFilter(T item, String query) => widget.displayString(item).toLowerCase().contains(query.toLowerCase());

  void _onControllerChanged() {
    if (_lastQuery == _controller.text) return;
    _lastQuery = _controller.text;
    if (!_selectionMatches) _selected = null;
    setState(() {});
    widget.onChanged?.call(_controller.text);
  }

  void _setOpen(bool open) {
    if (_open == open) return;
    setState(() => _open = open);
    widget.onOpenChanged?.call(open);
  }

  void _search() {
    if (widget.enabled) _setOpen(true);
  }

  void _select(T item) {
    _selected = item;
    _setOpen(false);
    _controller.text = widget.displayString(item);
    _focusNode.unfocus();
    widget.onSelected(item);
  }

  void _clear() {
    _selected = null;
    _controller.clear();
    setState(() {});
    _focusNode.requestFocus();
  }

  void _dismiss() {
    _setOpen(false);
    if (!_selectionMatches) _controller.clear();
    _focusNode.unfocus();
  }
}

class _SearchResults<T> extends StatelessWidget {
  const _SearchResults({required this.results, required this.displayString, required this.onSelect});
  final List<T> results;
  final String Function(T) displayString;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: true,
    padding: .zero,
    itemCount: results.length,
    itemBuilder: (context, index) =>
        _SearchResult<T>(item: results.elementAt(index), displayString: displayString, onSelect: onSelect),
  );
}

class _SearchResult<T> extends StatelessWidget {
  const _SearchResult({required this.item, required this.displayString, required this.onSelect});
  final T item;
  final String Function(T) displayString;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(minHeight: DievasTheme.sizingOf(context).height40),
    child: Align(
      heightFactor: 1,
      child: DievasMenuItem(label: displayString(item), onTap: () => onSelect(item)),
    ),
  );
}
