import 'package:dievas/src/extensions/dievas_theme_context_extension.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:flutter/widgets.dart';

/// A brief, non-blocking message shown at the bottom of the viewport.
///
/// [DievasSnackbar] is not mounted directly — it is passed as a builder to
/// [DievasScopeController.showSnackbar]:
///
/// ```dart
/// DievasScope.of(context).showSnackbar(
///   (context, animation) => DievasSnackbar(
///     message: 'Changes saved',
///     action: DievasSnackbarAction(label: 'Undo', onPressed: undo),
///   ),
/// );
/// ```
///
/// Moon reference: Toast
class DievasSnackbar extends StatelessWidget {
  const DievasSnackbar({super.key, required this.message, this.leadingIcon, this.action, this.backgroundColor});

  /// The message to display.
  final String message;

  /// Optional leading icon widget.
  final Widget? leadingIcon;

  /// Optional trailing action (label + callback).
  final DievasSnackbarAction? action;

  /// Override for the snackbar surface colour. Defaults to theme bg.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = DievasTheme.colorsOf(context);
    final theme = DievasTheme.componentsOf(context).snackbar;

    final bg = backgroundColor ?? colors.background.bgElevated;
    final fgColor = colors.text.textPrimary;
    final spacing = context.spacing;

    return Padding(
      padding: .only(bottom: theme.bottomInset, left: spacing.md, right: spacing.md),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: theme.minWidth, maxWidth: theme.maxWidth),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: theme.borderRadius,
            boxShadow: [BoxShadow(color: const Color(0x1A000000), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Padding(
            padding: theme.padding,
            child: Row(
              mainAxisSize: .min,
              children: [
                if (leadingIcon case final icon?) ...[
                  SizedBox.square(
                    dimension: theme.iconSize,
                    child: Center(
                      child: IconTheme(
                        data: IconThemeData(color: fgColor, size: theme.iconSize),
                        child: icon,
                      ),
                    ),
                  ),
                  SizedBox(width: theme.iconSpacing),
                ],
                Expanded(
                  child: Text(
                    message,
                    style: theme.messageStyle.copyWith(color: fgColor),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                ),
                if (action case final action?) ...[
                  SizedBox(width: spacing.md),
                  GestureDetector(
                    onTap: action.onPressed,
                    child: Text(action.label, style: theme.actionStyle.copyWith(color: colors.action.actionPrimary)),
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

/// An optional action shown inside a [DievasSnackbar].
class DievasSnackbarAction {
  const DievasSnackbarAction({required this.label, required this.onPressed});

  /// The action label.
  final String label;

  /// Called when the action label is tapped.
  final VoidCallback onPressed;
}
