import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

/// Controls whether expanded content shares the header card surface.
enum DievasAccordionLayout {
  /// The header and content share a rounded card with a divider.
  grouped,

  /// The content appears below the rounded header card.
  ungrouped,
}

enum DievasAccordionSize { sm, md, lg }

class DievasAccordionItem {
  const DievasAccordionItem({
    required this.title,
    required this.content,
    this.leading,
    this.trailing,
    this.initiallyExpanded = false,
    this.disabled = false,
    this.showTrailingArrow = true,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  });

  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget title;
  final Widget content;
  final Widget? leading;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool disabled;
  final bool showTrailingArrow;
}

class DievasAccordion extends StatefulWidget {
  const DievasAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
    this.layout = .grouped,
    this.size = .md,
    this.showBorder = false,
    this.showDivider = true,
    this.showShadows = false,
    this.maintainState = false,
    this.textColour,
    this.expandedTextColour,
    this.contentTextColour,
    this.iconColour,
    this.expandedIconColour,
    this.backgroundColour,
    this.expandedBackgroundColour,
    this.borderColour,
    this.dividerColour,
    this.borderRadius,
    this.headerPadding,
    this.contentPadding,
    this.headerHeight,
    this.gap,
    this.transitionDuration,
    this.transitionCurve,
    this.expandedAlignment = .topLeft,
    this.expandedCrossAxisAlignment = .stretch,
    this.onExpansionChanged,
    this.expandedIndices,
  });

  final bool allowMultiple;
  final DievasAccordionLayout layout;
  final List<DievasAccordionItem> items;
  final DievasAccordionSize size;
  final bool showBorder;
  final bool showDivider;
  final bool showShadows;
  final bool maintainState;
  final Color? textColour;
  final Color? expandedTextColour;
  final Color? contentTextColour;
  final Color? iconColour;
  final Color? expandedIconColour;
  final Color? backgroundColour;
  final Color? expandedBackgroundColour;
  final Color? borderColour;
  final Color? dividerColour;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? headerPadding;
  final EdgeInsetsGeometry? contentPadding;
  final double? headerHeight;
  final double? gap;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final AlignmentGeometry expandedAlignment;
  final CrossAxisAlignment expandedCrossAxisAlignment;

  /// Reports user expansion changes, including automatic group collapses.
  final void Function(int index, bool expanded)? onExpansionChanged;

  /// When provided, the parent owns expansion and updates this set in response
  /// to [onExpansionChanged]. With [allowMultiple] false, at most one item opens.
  final Set<int>? expandedIndices;

  @override
  State<DievasAccordion> createState() => _DievasAccordionState();
}

class _DievasAccordionState extends State<DievasAccordion> {
  final _expandedNotifier = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      if (widget.items[i].initiallyExpanded) {
        if (widget.allowMultiple) {
          continue;
        }
        _expandedNotifier.value = i;
        break;
      }
    }
  }

  @override
  void dispose() {
    _expandedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = DievasTheme.spacingOf(context);

    return ListView.separated(
      shrinkWrap: true,
      clipBehavior: .none,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      separatorBuilder: (_, _) => SizedBox(height: spacing.SM),
      itemBuilder: (context, index) => _AccordionCard(
        item: widget.items[index],
        index: index,
        notifier: _expandedNotifier,
        allowMultiple: widget.allowMultiple,
        options: widget,
      ),
    );
  }
}

class _AccordionCard extends StatefulWidget {
  const _AccordionCard({
    required this.item,
    required this.index,
    required this.notifier,
    required this.allowMultiple,
    required this.options,
  });

  final int index;
  final bool allowMultiple;
  final DievasAccordionItem item;
  final ValueNotifier<int?> notifier;
  final DievasAccordion options;

  @override
  State<_AccordionCard> createState() => _AccordionCardState();
}

class _AccordionCardState extends State<_AccordionCard> with SingleTickerProviderStateMixin {
  late bool _expanded;
  late final AnimationController _chevronController;
  late final Animation<double> _chevronTurns;

  @override
  void initState() {
    super.initState();
    _expanded = switch (widget.options.expandedIndices) {
      final indices? => indices.contains(widget.index) && (widget.allowMultiple || indices.first == widget.index),
      null => widget.allowMultiple ? widget.item.initiallyExpanded : widget.notifier.value == widget.index,
    };
    _chevronController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    if (_expanded) _chevronController.value = 1;
    _chevronTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_chevronController);
    widget.notifier.addListener(_onNotifierChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chevronController.duration =
        widget.options.transitionDuration ?? DievasTheme.componentsOf(context).accordion.animationDuration;
  }

  @override
  void didUpdateWidget(covariant _AccordionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final expanded = switch (widget.options.expandedIndices) {
      final indices? => indices.contains(widget.index) && (widget.allowMultiple || indices.first == widget.index),
      null => switch ((oldWidget.allowMultiple, widget.allowMultiple)) {
        (true, false) => widget.notifier.value == widget.index,
        _ => _expanded,
      },
    };
    _expanded = expanded;
    _chevronController.duration =
        widget.options.transitionDuration ?? DievasTheme.componentsOf(context).accordion.animationDuration;
    expanded ? _chevronController.forward() : _chevronController.reverse();
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    _chevronController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).accordion;
    final colours = DievasTheme.coloursOf(context);
    final options = widget.options;
    final spacing = DievasTheme.spacingOf(context);
    final typography = DievasTheme.typographyOf(context);
    final headerStyle = switch (options.size) {
      .sm => typography.bodySM,
      .md => theme.headerStyle,
      .lg => typography.titleSM,
    };
    final iconColour = switch ((widget.item.disabled, _expanded)) {
      (true, _) => colours.icon.iconDisabled,
      (false, true) => options.expandedIconColour ?? options.iconColour ?? colours.icon.iconSecondary,
      (false, false) => options.iconColour ?? colours.icon.iconSecondary,
    };
    final textColour = switch ((widget.item.disabled, _expanded)) {
      (true, _) => colours.text.textDisabled,
      (false, true) => options.expandedTextColour ?? options.textColour ?? colours.text.textPrimary,
      (false, false) => options.textColour ?? colours.text.textPrimary,
    };
    final duration = options.transitionDuration ?? theme.animationDuration;
    final curve = options.transitionCurve ?? DievasTheme.animationOf(context).easingStandard;

    final header = Semantics(
      label: widget.item.semanticLabel,
      expanded: _expanded,
      enabled: !widget.item.disabled,
      child: InkWell(
        focusNode: widget.item.focusNode,
        autofocus: widget.item.autofocus,
        onTap: widget.item.disabled ? null : _toggle,
        child: Padding(
          padding:
              options.headerPadding ??
              switch (options.size) {
                .sm => .symmetric(horizontal: spacing.SM, vertical: spacing.SM),
                .md => theme.padding,
                .lg => .symmetric(horizontal: spacing.LG, vertical: spacing.MD),
              },
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: options.headerHeight ?? 0),
            child: IconTheme(
              data: IconThemeData(color: iconColour, size: theme.iconSize),
              child: Row(
                children: [
                  ...switch (widget.item.leading) {
                    final leading? => [leading, SizedBox(width: options.gap ?? theme.iconSpacing)],
                    null => <Widget>[],
                  },
                  Expanded(
                    child: DefaultTextStyle(
                      style: headerStyle.copyWith(color: textColour),
                      child: widget.item.title,
                    ),
                  ),
                  ...switch ((widget.item.trailing, widget.item.showTrailingArrow)) {
                    (final trailing?, _) => [SizedBox(width: options.gap ?? theme.iconSpacing), trailing],
                    (null, true) => [
                      SizedBox(width: options.gap ?? theme.iconSpacing),
                      RotationTransition(
                        turns: _chevronTurns,
                        child: Icon(Icons.expand_more, size: theme.iconSize, color: iconColour),
                      ),
                    ],
                    (null, false) => <Widget>[],
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final content = AnimatedSize(
      alignment: .topCenter,
      duration: duration,
      curve: curve,
      child: ExcludeFocus(
        excluding: !_expanded,
        child: Offstage(
          offstage: !_expanded,
          child: TickerMode(
            enabled: _expanded,
            child: switch (_expanded || options.maintainState) {
              true => Column(
                crossAxisAlignment: options.expandedCrossAxisAlignment,
                mainAxisSize: .min,
                children: [
                  ...switch ((options.layout, options.showDivider)) {
                    (.grouped, true) => [
                      Divider(
                        height: 1,
                        thickness: theme.borderWidth,
                        color: options.dividerColour ?? colours.border.dividerColour,
                      ),
                    ],
                    _ => <Widget>[],
                  },
                  Padding(
                    padding: options.contentPadding ?? theme.contentPadding,
                    child: Align(
                      alignment: options.expandedAlignment,
                      child: DefaultTextStyle(
                        style: theme.contentStyle.copyWith(
                          color: options.contentTextColour ?? colours.text.textPrimary,
                        ),
                        child: widget.item.content,
                      ),
                    ),
                  ),
                ],
              ),
              false => const SizedBox.shrink(),
            },
          ),
        ),
      ),
    );

    return switch (options.layout) {
      .grouped => _AccordionSurface(
        options: options,
        expanded: _expanded,
        child: Column(crossAxisAlignment: .stretch, mainAxisSize: .min, children: [header, content]),
      ),
      .ungrouped => Column(
        crossAxisAlignment: .stretch,
        mainAxisSize: .min,
        children: [
          _AccordionSurface(options: options, expanded: _expanded, child: header),
          content,
        ],
      ),
    };
  }

  void _onNotifierChanged() {
    if (widget.options.expandedIndices == null &&
        !widget.allowMultiple &&
        widget.notifier.value != widget.index &&
        _expanded) {
      _collapse();
    }
  }

  void _toggle() => switch ((widget.item.disabled, widget.options.expandedIndices, _expanded)) {
    (true, _, _) => null,
    (false, Set<int>(), _) => widget.options.onExpansionChanged?.call(widget.index, !_expanded),
    (false, null, true) => _collapse(),
    (false, null, false) => _expand(),
  };

  void _expand() {
    if (!widget.allowMultiple) widget.notifier.value = widget.index;
    setState(() => _expanded = true);
    _chevronController.duration =
        widget.options.transitionDuration ?? DievasTheme.componentsOf(context).accordion.animationDuration;
    _chevronController.forward();
    widget.options.onExpansionChanged?.call(widget.index, true);
  }

  void _collapse() {
    setState(() => _expanded = false);
    _chevronController.duration =
        widget.options.transitionDuration ?? DievasTheme.componentsOf(context).accordion.animationDuration;
    _chevronController.reverse();
    widget.options.onExpansionChanged?.call(widget.index, false);
  }
}

class _AccordionSurface extends StatelessWidget {
  const _AccordionSurface({required this.options, required this.expanded, required this.child});

  final DievasAccordion options;
  final bool expanded;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).accordion;

    final colours = DievasTheme.coloursOf(context);
    final radius = options.borderRadius ?? theme.borderRadius;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: options.showShadows ? DievasTheme.elevationOf(context).SM : null,
      ),
      child: Material(
        clipBehavior: .antiAlias,
        color: switch (expanded) {
          true => options.expandedBackgroundColour ?? options.backgroundColour ?? colours.background.cardBackground,
          false => options.backgroundColour ?? colours.background.cardBackground,
        },
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: options.showBorder
              ? BorderSide(color: options.borderColour ?? colours.border.dividerColour, width: theme.borderWidth)
              : BorderSide.none,
        ),
        child: child,
      ),
    );
  }
}
