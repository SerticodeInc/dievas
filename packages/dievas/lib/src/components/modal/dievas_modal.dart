import 'package:dievas/src/extensions/dievas_theme_context_extension.dart';
import 'package:flutter/material.dart' show Material, showDialog;
import 'package:flutter/widgets.dart';
import 'package:dievas/l10n/dievas_localizations.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Shows a Dievas-styled modal dialog.
///
/// ```dart
/// showDievasModal(
///   context: context,
///   builder: (context) => DievasModal(
///     title: 'Confirm delete',
///     body: 'This action cannot be undone.',
///     actions: [
///       DievasTextButton(label: 'Cancel', onPressed: () => Navigator.pop(context)),
///       DievasFilledButton(label: 'Delete', style: .destructive, ...),
///     ],
///   ),
/// );
/// ```
Future<T?> showDievasModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
}) {
  final theme = DievasTheme.componentsOf(context).modal;

  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: theme.barrierColor,
    routeSettings: routeSettings,
    builder: builder,
  );
}

/// The card widget rendered inside [showDievasModal].
///
/// Provides title, optional body text, optional close button, and an actions row.
class DievasModal extends StatelessWidget {
  const DievasModal({
    super.key,
    required this.title,
    this.body,
    this.content,
    this.actions = const [],
    this.showCloseButton = true,
    this.onClose,
  });

  /// The modal title shown in the header row.
  final String title;

  /// Optional body text shown between the header and actions.
  final String? body;

  /// Optional arbitrary widget shown between the header and actions.
  /// Takes precedence over [body] when both are provided.
  final Widget? content;

  /// Action widgets (typically buttons) shown at the bottom of the modal.
  final List<Widget> actions;

  /// Whether to show the × close button in the header.
  final bool showCloseButton;

  /// Called when the close button is tapped. Defaults to [Navigator.pop].
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).modal;
    final spacing = context.spacing;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: theme.minWidth, maxWidth: theme.maxWidth),
        child: Material(
          color: theme.backgroundColor,
          elevation: theme.elevation,
          borderRadius: theme.borderRadius,
          child: Padding(
            padding: theme.padding,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                // Header row
                Row(
                  children: [
                    Expanded(child: Text(title, style: theme.titleStyle)),
                    if (showCloseButton)
                      Semantics(
                        label: DievasLocalizations.of(context).modalCloseLabel,
                        button: true,
                        child: GestureDetector(
                          onTap: onClose ?? () => Navigator.of(context).pop(),
                          child: SizedBox.square(
                            dimension: theme.closeIconSize,
                            child: IconTheme(
                              data: IconThemeData(
                                color: DievasTheme.colorsOf(context).icon.iconSecondary,
                                size: theme.closeIconSize,
                              ),
                              child: const _CloseIcon(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // Body
                if (content case final content?) ...[
                  SizedBox(height: spacing.smPlus),
                  content,
                ] else if (body case final body?) ...[
                  SizedBox(height: spacing.smPlus),
                  Text(body, style: theme.bodyStyle),
                ],

                // Actions
                if (actions.isNotEmpty) ...[
                  SizedBox(height: spacing.lg),
                  Row(
                    mainAxisAlignment: .end,
                    children: [
                      for (int i = 0; i < actions.length; i++) ...[if (i > 0) SizedBox(width: spacing.sm), actions[i]],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CloseIcon extends StatelessWidget {
  const _CloseIcon();

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return Text(
      .fromCharCode(0xe5cd),
      style: TextStyle(fontFamily: 'MaterialIcons', fontSize: iconTheme.size, color: iconTheme.color),
    );
  }
}
