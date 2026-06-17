import 'package:flutter/material.dart';

import 'package:dievas/src/theme/dievas_theme.dart';

class DievasAccordionItem {
  const DievasAccordionItem({
    required this.title,
    required this.content,
    this.leading,
    this.trailing,
    this.initiallyExpanded = false,
    this.disabled = false,
    this.showTrailingArrow = true,
  });

  final Widget title;
  final Widget content;
  final Widget? leading;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool disabled;
  final bool showTrailingArrow;
}

class DievasAccordion extends StatefulWidget {
  const DievasAccordion({super.key, required this.items, this.allowMultiple = false});

  final List<DievasAccordionItem> items;
  final bool allowMultiple;

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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      separatorBuilder: (_, _) => SizedBox(height: spacing.sm),
      itemBuilder: (context, index) => _AccordionCard(
        item: widget.items[index],
        index: index,
        notifier: _expandedNotifier,
        allowMultiple: widget.allowMultiple,
      ),
    );
  }
}

class _AccordionCard extends StatefulWidget {
  const _AccordionCard({required this.item, required this.index, required this.notifier, required this.allowMultiple});

  final DievasAccordionItem item;
  final int index;
  final ValueNotifier<int?> notifier;
  final bool allowMultiple;

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
    _expanded = widget.allowMultiple ? widget.item.initiallyExpanded : widget.notifier.value == widget.index;
    _chevronController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    if (_expanded) _chevronController.value = 0.5;
    _chevronTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_chevronController);
    widget.notifier.addListener(_onNotifierChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chevronController.duration = DievasTheme.componentsOf(context).accordion.animationDuration;
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierChanged);
    _chevronController.dispose();
    super.dispose();
  }

  void _onNotifierChanged() {
    if (!widget.allowMultiple && widget.notifier.value != widget.index && _expanded) {
      _collapse();
    }
  }

  void _toggle() => switch ((widget.item.disabled, _expanded)) {
    (true, _) => null,
    (_, true) => _collapse(),
    (_, false) => _expand(),
  };

  void _expand() {
    if (!widget.allowMultiple) widget.notifier.value = widget.index;
    setState(() => _expanded = true);
    _chevronController.forward();
  }

  void _collapse() {
    setState(() => _expanded = false);
    _chevronController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).accordion;
    final colours = DievasTheme.colorsOf(context);
    final iconColour = widget.item.disabled ? colours.icon.iconDisabled : colours.icon.iconSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colours.background.bgSubtle,
        borderRadius: theme.borderRadius,
        boxShadow: theme.shadows,
      ),
      child: ClipRRect(
        borderRadius: theme.borderRadius,
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            InkWell(
              onTap: _toggle,
              child: Padding(
                padding: theme.padding,
                child: Row(
                  children: [
                    if (widget.item.leading case final leading?) ...[leading, SizedBox(width: theme.iconSpacing)],
                    Expanded(
                      child: DefaultTextStyle(style: theme.headerStyle, child: widget.item.title),
                    ),
                    if (widget.item.trailing case final trailing?)
                      trailing
                    else if (widget.item.showTrailingArrow)
                      RotationTransition(
                        turns: _chevronTurns,
                        child: Icon(Icons.expand_more, size: theme.iconSize, color: iconColour),
                      ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: theme.animationDuration,
              curve: Curves.easeInOut,
              alignment: .topCenter,
              child: switch (_expanded) {
                true => Column(
                  mainAxisSize: .min,
                  children: [
                    Divider(height: 1, thickness: theme.borderWidth, color: colours.border.borderDefault),
                    Padding(
                      padding: theme.contentPadding,
                      child: DefaultTextStyle(style: theme.contentStyle, child: widget.item.content),
                    ),
                  ],
                ),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        ),
      ),
    );
  }
}
