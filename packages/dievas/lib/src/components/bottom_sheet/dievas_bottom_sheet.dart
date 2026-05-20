import 'package:flutter/material.dart' show RoundedRectangleBorder, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:dievas/l10n/dievas_localizations.dart';
import '../../theme/dievas_theme.dart';

/// Shows a Dievas-styled modal bottom sheet.
///
/// Use this function instead of [showModalBottomSheet] directly — it reads
/// [DievasBottomSheetThemeData] from the tree and applies Dievas tokens.
///
/// ```dart
/// showDievasBottomSheet(
///   context: context,
///   builder: (context) => DievasBottomSheet(
///     child: YourContent(),
///   ),
/// );
/// ```
Future<T?> showDievasBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollControlled = false,
  RouteSettings? routeSettings,
}) {
  final theme = DievasTheme.componentsOf(context).bottomSheet;

  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    barrierColor: theme.barrierColor,
    backgroundColor: theme.backgroundColor,
    elevation: theme.elevation,
    shape: RoundedRectangleBorder(borderRadius: theme.borderRadius),
    routeSettings: routeSettings,
    builder: builder,
  );
}

/// The surface widget placed inside [showDievasBottomSheet].
///
/// Renders the drag handle and wraps [child] in the correct sheet padding.
///
/// ```dart
/// DievasBottomSheet(
///   child: Padding(
///     padding: const EdgeInsets.all(24),
///     child: YourContent(),
///   ),
/// )
/// ```
class DievasBottomSheet extends StatelessWidget {
  const DievasBottomSheet({super.key, required this.child, this.showDragHandle = true});

  /// The sheet body content.
  final Widget child;

  /// Whether to render the drag handle at the top of the sheet.
  final bool showDragHandle;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).bottomSheet;

    return Column(
      mainAxisSize: .min,
      children: [
        if (showDragHandle) ...[
          SizedBox(height: theme.handleTopInset),
          Semantics(
            label: DievasLocalizations.of(context).bottomSheetDragHandleLabel,
            child: Container(
              width: theme.handleWidth,
              height: theme.handleHeight,
              decoration: BoxDecoration(
                color: DievasTheme.colorsOf(context).border.borderDefault,
                borderRadius: theme.handleRadius,
              ),
            ),
          ),
        ],
        child,
      ],
    );
  }
}
