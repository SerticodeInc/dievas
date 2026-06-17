import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// A search field with an overlay dropdown showing filtered results.
///
/// As the user types, [items] are filtered and matching results appear in a
/// dropdown overlay positioned below the search field. Tapping outside the
/// dropdown or clearing the search text dismisses it.
///
/// Unlike [DievasSearchWithList] (which renders results inline), this
/// variant uses an [Overlay] so the dropdown can extend beyond the parent's
/// clip bounds — useful inside dialogs, side panels, or tight layouts.
///
/// All styling is derived from [DievasSearchThemeData] via
/// [DievasTheme.componentsOf].
///
/// Moon reference: SearchWithDropdown
///
/// ```dart
/// DievasSearchWithDropdown<String>(
///   items: ['Apple', 'Banana', 'Cherry'],
///   displayString: (s) => s,
///   hint: 'Search...',
///   onSelected: (fruit) => print(fruit),
/// )
/// ```
class DievasSearchWithDropdown<T> extends StatefulWidget {
  const DievasSearchWithDropdown({
    super.key,
    required this.items,
    required this.displayString,
    required this.onSelected,
    this.hint,
    this.filter,
    this.enabled = true,
  });

  /// The full set of searchable items.
  final List<T> items;

  /// Converts an item to its display string for filtering and rendering.
  final String Function(T) displayString;

  /// Called when the user taps a result item. Search text is cleared
  /// and the dropdown dismissed before this fires.
  final ValueChanged<T> onSelected;

  /// Placeholder text in the search field.
  final String? hint;

  /// Custom filter predicate. Defaults to case-insensitive substring match.
  final bool Function(T item, String query)? filter;

  /// When `false` the search field is read-only.
  final bool enabled;

  @override
  State<DievasSearchWithDropdown<T>> createState() => _DievasSearchWithDropdownState<T>();
}

class _DievasSearchWithDropdownState<T> extends State<DievasSearchWithDropdown<T>> {
  final _controller = TextEditingController();
  final _link = LayerLink();
  OverlayEntry? _dropdown;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onQueryChange);
  }

  @override
  void dispose() {
    _removeDropdown();
    _controller.removeListener(_onQueryChange);
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChange() {
    final query = _controller.text;
    if (query.isEmpty) {
      _removeDropdown();
      setState(() {});
      return;
    }

    final filter = widget.filter ?? _defaultFilter;
    final results = widget.items.where((item) => filter(item, query)).toList();

    setState(() {});
    if (results.isNotEmpty) {
      _showOverlay(results);
    } else {
      _removeDropdown();
    }
  }

  bool _defaultFilter(T item, String query) => widget.displayString(item).toLowerCase().contains(query.toLowerCase());

  void _showOverlay(List<T> results) {
    _removeDropdown();

    _dropdown = OverlayEntry(
      builder: (context) => _DropdownResults<T>(
        link: _link,
        results: results,
        displayString: widget.displayString,
        onItemTap: _onItemTap,
        onDismiss: _removeDropdown,
      ),
    );

    Overlay.of(context).insert(_dropdown!);
  }

  void _removeDropdown() {
    _dropdown?.remove();
    _dropdown = null;
  }

  void _onItemTap(T item) {
    _removeDropdown();
    _controller.clear();
    widget.onSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).search;

    return CompositedTransformTarget(
      link: _link,
      child: SizedBox(
        height: theme.height,
        child: TextField(
          controller: _controller,
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
                child: const Icon(Icons.search),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),
            suffixIcon: _controller.text.isNotEmpty
                ? Padding(
                    padding: EdgeInsetsDirectional.only(end: theme.iconSize / 4, start: theme.iconSize / 4),
                    child: IconTheme(
                      data: IconThemeData(color: theme.iconColor, size: theme.iconSize * 0.8),
                      child: GestureDetector(
                        onTap: () {
                          _controller.clear();
                          _removeDropdown();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 0),
            border: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.borderColorFocused),
            ),
            isDense: true,
          ),
        ),
      ),
    );
  }
}

class _DropdownResults<T> extends StatelessWidget {
  const _DropdownResults({
    required this.link,
    required this.results,
    required this.displayString,
    required this.onItemTap,
    required this.onDismiss,
  });

  final LayerLink link;
  final List<T> results;
  final String Function(T) displayString;
  final ValueChanged<T> onItemTap;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).search;

    final rowHeight = theme.height * 0.8;
    final maxHeight = (results.length * rowHeight).clamp(0.0, rowHeight * 7);

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(onTap: onDismiss, behavior: .opaque, child: const SizedBox.expand()),
        ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: .bottomLeft,
          followerAnchor: .topLeft,
          child: Material(
            elevation: 0,
            color: theme.bgColor,
            borderRadius: BorderRadius.vertical(bottom: theme.borderRadius.topLeft),
            child: Container(
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: BoxDecoration(
                color: theme.bgColor,
                borderRadius: BorderRadius.vertical(bottom: theme.borderRadius.topLeft),
                border: Border.all(color: theme.borderColorFocused),
                boxShadow: [
                  BoxShadow(
                    color: theme.borderColorFocused.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
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
            ),
          ),
        ),
      ],
    );
  }
}
