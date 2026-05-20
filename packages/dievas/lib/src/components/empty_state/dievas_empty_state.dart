import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:flutter/widgets.dart';
import '../../theme/dievas_theme.dart';

/// A structured empty state surface — icon, title, description, optional CTA.
///
/// Use when a list, feed, or view has no content to show.
///
/// ```dart
/// DievasEmptyState(
///   icon: Icon(Icons.inbox_outlined),
///   title: 'No messages yet',
///   description: 'Messages from your team will appear here.',
///   action: DievasFilledButton(label: 'Invite teammates', onPressed: invite),
/// )
/// ```
///
/// Moon reference: EmptyState / NoData
class DievasEmptyState extends StatelessWidget {
  const DievasEmptyState({super.key, this.icon, this.title, this.description, this.action});

  /// Optional illustration or icon widget.
  final Widget? icon;

  /// Short title. Defaults to [DievasLocalizations.emptyStateDefaultTitle].
  final String? title;

  /// Supporting description. Defaults to [DievasLocalizations.emptyStateDefaultDescription].
  final String? description;

  /// Optional CTA widget (typically a [DievasFilledButton] or [DievasTextButton]).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = DievasTheme.colorsOf(context);
    final theme = DievasTheme.componentsOf(context).emptyState;
    final l10n = DievasLocalizations.of(context);

    final resolvedTitle = title ?? l10n.emptyStateDefaultTitle;
    final resolvedDescription = description ?? l10n.emptyStateDefaultDescription;

    return Padding(
      padding: theme.padding,
      child: Column(
        mainAxisSize: .min,
        children: [
          if (icon case final widget?) ...[
            SizedBox.square(
              dimension: theme.iconSize,
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: theme.iconColor, size: theme.iconSize),
                  child: widget,
                ),
              ),
            ),
            SizedBox(height: theme.titleSpacing),
          ],
          Text(
            resolvedTitle,
            style: theme.titleStyle.copyWith(color: colors.text.textPrimary),
            textAlign: .center,
          ),
          SizedBox(height: theme.descriptionSpacing),
          Text(
            resolvedDescription,
            style: theme.descriptionStyle.copyWith(color: colors.text.textSecondary),
            textAlign: .center,
          ),
          if (action case final widget?) ...[SizedBox(height: theme.actionSpacing), widget],
        ],
      ),
    );
  }
}
