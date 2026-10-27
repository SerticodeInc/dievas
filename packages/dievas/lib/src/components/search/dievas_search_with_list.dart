import 'package:flutter/material.dart';

import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/components/menu_item/dievas_menu_item.dart';
import 'package:dievas/src/components/search/dievas_search_field.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

export 'dievas_search_field.dart' show DievasSearchSize;

/// Search with inline results on the page, rather than in an overlay.
///
/// Tapping the field shows all matching items. Clear resets the query while
/// retaining results; Close clears the query, hides results and releases focus.
/// Selection reports the item without changing the query or visibility.
/// In a bounded parent the results scroll through the remaining height.
class DievasSearchWithList<T> extends StatefulWidget {
  const DievasSearchWithList({
    super.key,
    required this.items,
    required this.displayString,
    required this.onSelected,
    this.hint,
    this.leadingIcon,
    this.filter,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.initialQuery,
    this.show,
    this.onChanged,
    this.onOpenChanged,
    this.size,
    this.activeBorderColour,
    this.inactiveBorderColour,
    this.hoverBorderColour,
    this.backgroundColour,
    this.borderRadius,
    this.hasFloatingLabel = false,
    this.clearLabel,
    this.noResultsText,
    this.description,
  });

  final List<T> items;
  final String Function(T) displayString;
  final ValueChanged<T> onSelected;
  final String? hint;
  final Widget? leadingIcon;
  final bool Function(T item, String query)? filter;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialQuery;
  final bool? show;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onOpenChanged;
  final DievasSearchSize? size;
  final Color? activeBorderColour;
  final Color? inactiveBorderColour;
  final Color? hoverBorderColour;
  final Color? backgroundColour;
  final BorderRadiusGeometry? borderRadius;
  final bool hasFloatingLabel;
  final String? clearLabel;
  final String? noResultsText;
  final String? description;

  @override
  State<DievasSearchWithList<T>> createState() => _DievasSearchWithListState<T>();
}

class _DievasSearchWithListState<T> extends State<DievasSearchWithList<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String _lastQuery;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.show ?? false;
    _controller = widget.controller ?? TextEditingController(text: widget.initialQuery);
    _lastQuery = _controller.text;
    _controller.addListener(_onQueryChanged);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(DievasSearchWithList<T> oldWidget) {
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
    _controller.removeListener(_onQueryChanged);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = DievasLocalizations.of(context);
    final query = _controller.text.trim();
    final results = widget.items.where((item) => (widget.filter ?? _defaultFilter)(item, query)).toList();
    final open = _open && widget.enabled;
    return LayoutBuilder(
      builder: (context, constraints) => _SearchListLayout<T>(
        bounded: constraints.hasBoundedHeight,
        input: DievasSearchField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          hasFloatingLabel: widget.hasFloatingLabel,
          size: widget.size,
          hint: widget.hint,
          clearLabel: widget.clearLabel,
          leadingIcon: widget.leadingIcon,
          borderRadius: widget.borderRadius,
          activeBorderColour: widget.activeBorderColour,
          inactiveBorderColour: widget.inactiveBorderColour,
          hoverBorderColour: widget.hoverBorderColour,
          backgroundColour: widget.backgroundColour,
          onSearch: _search,
          onClear: _clear,
          onClose: _close,
        ),
        results: results,
        open: open,
        displayString: widget.displayString,
        onSelect: widget.onSelected,
        message: switch ((open, results.isEmpty)) {
          (false, _) => widget.description ?? strings.searchListDescription,
          (true, true) => widget.noResultsText ?? strings.searchNoResults,
          _ => null,
        },
      ),
    );
  }

  TextEditingController _replaceController(TextEditingController? previous, TextEditingController? next) {
    final value = _controller.value;
    _controller.removeListener(_onQueryChanged);
    if (previous case null) _controller.dispose();
    final controller = switch (next) {
      final controller? => controller,
      null => TextEditingController.fromValue(value),
    };
    _lastQuery = controller.text;
    controller.addListener(_onQueryChanged);
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

  void _onQueryChanged() {
    if (_lastQuery == _controller.text) return;
    _lastQuery = _controller.text;
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

  void _clear() {
    _controller.clear();
    _focusNode.requestFocus();
  }

  void _close() {
    _controller.clear();
    _setOpen(false);
    _focusNode.unfocus();
  }
}

class _SearchListLayout<T> extends StatelessWidget {
  const _SearchListLayout({
    required this.bounded,
    required this.input,
    required this.results,
    required this.open,
    required this.displayString,
    required this.onSelect,
    required this.message,
  });

  final bool bounded;
  final Widget input;
  final List<T> results;
  final bool open;
  final String Function(T) displayString;
  final ValueChanged<T> onSelect;
  final String? message;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Column(
        mainAxisSize: bounded ? .max : .min,
        crossAxisAlignment: .stretch,
        children: [
          input,
          if ((bounded, message) case (false, final message?))
            Padding(
              padding: .symmetric(vertical: DievasTheme.spacingOf(context).xl3),
              child: Text(message, textAlign: .center, style: DievasTheme.componentsOf(context).search.inputStyle),
            ),
          if (open && results.isNotEmpty)
            switch (bounded) {
              true => Expanded(
                child: _InlineResults<T>(results: results, displayString: displayString, onSelect: onSelect),
              ),
              false => _InlineResults<T>(results: results, displayString: displayString, onSelect: onSelect),
            },
        ],
      ),
      if ((bounded, message) case (true, final message?))
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: Text(message, textAlign: .center, style: DievasTheme.componentsOf(context).search.inputStyle),
            ),
          ),
        ),
    ],
  );
}

class _InlineResults<T> extends StatelessWidget {
  const _InlineResults({required this.results, required this.displayString, required this.onSelect});
  final List<T> results;
  final String Function(T) displayString;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) => ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(scrollbars: false),
    child: ListView.builder(
      shrinkWrap: true,
      padding: .only(top: DievasTheme.spacingOf(context).sm),
      itemCount: results.length,
      itemBuilder: (context, index) =>
          _InlineResult<T>(item: results.elementAt(index), displayString: displayString, onSelect: onSelect),
    ),
  );
}

class _InlineResult<T> extends StatelessWidget {
  const _InlineResult({required this.item, required this.displayString, required this.onSelect});
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
