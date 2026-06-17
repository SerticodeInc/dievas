import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A search field with an inline filtered-results list.
///
/// As the user types, [items] are filtered by [filter] (defaults to
/// case-insensitive substring match). Matching items appear in a list
/// directly below the search field. Tapping an item calls [onSelected]
/// and clears the search text.
///
/// All styling is derived from [DievasSearchThemeData] via
/// [DievasTheme.componentsOf].
///
/// Moon reference: SearchWithList
///
/// ```dart
/// DievasSearchWithList<String>(
///   items: ['Apple', 'Banana', 'Cherry', 'Date'],
///   displayString: (s) => s,
///   hint: 'Search fruits...',
///   onSelected: (fruit) => print(fruit),
/// )
/// ```
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
  });

  /// The full set of searchable items.
  final List<T> items;

  /// Converts an item to its display string for filtering and rendering.
  final String Function(T) displayString;

  /// Called when the user taps a result item. The search text is cleared
  /// automatically before this fires.
  final ValueChanged<T> onSelected;

  /// Placeholder text in the search field.
  final String? hint;

  /// Leading icon in the search field. Defaults to [Icons.search].
  final Widget? leadingIcon;

  /// Custom filter predicate. Defaults to case-insensitive substring match.
  final bool Function(T item, String query)? filter;

  /// When `false` the search field is read-only.
  final bool enabled;

  @override
  State<DievasSearchWithList<T>> createState() => _DievasSearchWithListState<T>();
}

class _DievasSearchWithListState<T> extends State<DievasSearchWithList<T>> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<T> _results = const [];

  bool get _hasQuery => _controller.text.isNotEmpty;
  bool get _showResults => _hasQuery && _results.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onQueryChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onQueryChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChange() {
    final query = _controller.text;
    if (query.isEmpty) {
      setState(() => _results = const []);
      return;
    }

    final filter = widget.filter ?? _defaultFilter;
    setState(() => _results = widget.items.where((item) => filter(item, query)).toList());
  }

  bool _defaultFilter(T item, String query) => widget.displayString(item).toLowerCase().contains(query.toLowerCase());

  void _onItemTap(T item) {
    _controller.clear();
    _focusNode.unfocus();
    widget.onSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).search;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        SizedBox(
          height: theme.height,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            style: theme.inputStyle,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: theme.placeholderStyle,
              contentPadding: theme.contentPadding,
              filled: true,
              fillColor: theme.bgColor,
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: theme.dividerIndent, end: theme.iconSize / 4),
                child: IconTheme(
                  data: IconThemeData(color: theme.iconColor, size: theme.iconSize),
                  child: widget.leadingIcon ?? const Icon(Icons.search),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: _showResults
                    ? BorderRadius.vertical(top: theme.borderRadius.topLeft)
                    : theme.borderRadius,
                borderSide: BorderSide(color: theme.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: _showResults
                    ? BorderRadius.vertical(top: theme.borderRadius.topLeft)
                    : theme.borderRadius,
                borderSide: BorderSide(color: theme.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: _showResults
                    ? BorderRadius.vertical(top: theme.borderRadius.topLeft)
                    : theme.borderRadius,
                borderSide: BorderSide(color: theme.borderColorFocused),
              ),
              isDense: true,
            ),
          ),
        ),
        if (_showResults)
          _ResultsList<T>(results: _results, displayString: widget.displayString, onItemTap: _onItemTap),
      ],
    );
  }
}

class _ResultsList<T> extends StatelessWidget {
  const _ResultsList({required this.results, required this.displayString, required this.onItemTap});

  final List<T> results;
  final String Function(T) displayString;
  final ValueChanged<T> onItemTap;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).search;

    return Container(
      constraints: BoxConstraints(maxHeight: theme.resultMaxHeight),
      decoration: BoxDecoration(
        color: theme.bgColor,
        borderRadius: BorderRadius.vertical(bottom: theme.borderRadius.topLeft),
        border: Border(
          left: BorderSide(color: theme.borderColorFocused),
          right: BorderSide(color: theme.borderColorFocused),
          bottom: BorderSide(color: theme.borderColorFocused),
        ),
        boxShadow: [
          BoxShadow(color: theme.borderColorFocused.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: results.length,
        separatorBuilder: (_, _) => Divider(
          height: 1,
          thickness: 1,
          color: theme.dividerColor,
          indent: theme.dividerIndent,
          endIndent: theme.dividerIndent,
        ),
        itemBuilder: (context, i) {
          final item = results[i];
          return InkWell(
            onTap: () => onItemTap(item),
            child: Padding(
              padding: theme.resultItemPadding,
              child: Text(displayString(item), style: theme.resultItemStyle),
            ),
          );
        },
      ),
    );
  }
}
