import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final emptyStateComponent = WidgetbookComponent(
  name: 'EmptyState',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => _Playground()),
    WidgetbookUseCase(name: 'With CTA', builder: (ctx) => const _WithCta()),
    WidgetbookUseCase(name: 'No Icon', builder: (ctx) => const _NoIcon()),
    WidgetbookUseCase(name: 'Defaults (l10n)', builder: (ctx) => const _Defaults()),
  ],
);

class _Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(label: 'Title', initialValue: 'No results found');
    final description = context.knobs.string(
      label: 'Description',
      initialValue: 'Try adjusting your filters or search terms.',
    );
    final showIcon = context.knobs.boolean(label: 'Show icon', initialValue: true);
    final showCta = context.knobs.boolean(label: 'Show CTA');

    return Center(
      child: ComponentBoundary(
        child: DievasEmptyState(
          icon: showIcon ? const _InboxIcon() : null,
          title: title.isEmpty ? null : title,
          description: description.isEmpty ? null : description,
          action: showCta ? DievasFilledButton(label: 'Try again', onPressed: () {}) : null,
        ),
      ),
    );
  }
}

class _WithCta extends StatelessWidget {
  const _WithCta();

  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(
      child: DievasEmptyState(
        icon: const _InboxIcon(),
        title: 'No messages yet',
        description: 'Messages from your team will appear here.',
        action: DievasFilledButton(label: 'Invite teammates', onPressed: () {}),
      ),
    ),
  );
}

class _NoIcon extends StatelessWidget {
  const _NoIcon();

  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(
      child: DievasEmptyState(
        title: 'Nothing here yet',
        description: 'Start by creating your first item.',
        action: DievasFilledButton(label: 'Get started', onPressed: () {}),
      ),
    ),
  );
}

class _Defaults extends StatelessWidget {
  const _Defaults();

  @override
  Widget build(BuildContext context) => Center(
    child: ComponentBoundary(child: DievasEmptyState(icon: const _InboxIcon())),
  );
}

class _InboxIcon extends StatelessWidget {
  const _InboxIcon();

  @override
  Widget build(BuildContext context) => Text(
    String.fromCharCode(0xe156), // inbox MaterialIcons
    style: TextStyle(
      fontFamily: 'MaterialIcons',
      fontSize: DievasTheme.componentsOf(context).emptyState.iconSize,
      color: DievasTheme.componentsOf(context).emptyState.iconColor,
    ),
  );
}
