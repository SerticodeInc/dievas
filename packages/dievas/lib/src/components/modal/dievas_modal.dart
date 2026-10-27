import 'package:dievas/src/components/buttons/dievas_text_button.dart';
import 'package:dievas/src/extensions/dievas_theme_context_extension.dart';
import 'package:dievas/src/theme/dievas_theme.dart';
import 'package:flutter/material.dart';

/// Opens a modal, preserving caller local Dievas and inherited themes.
///
/// The default route traps focus, respects reduced motion, and allows barrier
/// and Escape dismissal. Set [useRootNavigator] to false for nested previews.
/// The returned future contains the value passed to [closeDievasModal].
Future<T?> showDievasModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  bool useSafeArea = true,
  Color? barrierColour,
  String? barrierLabel,
  Duration? transitionDuration,
  Curve? transitionCurve,
  Offset? anchorPoint,
  RouteSettings? routeSettings,
  bool? requestFocus,
}) {
  final data = DievasTheme.of(context);
  final theme = data.components.modal;
  final navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  final themes = InheritedTheme.capture(from: context, to: navigator.context);
  final curve = switch ((transitionCurve, theme.transitionCurve)) {
    (final value?, _) || (_, final value?) => value,
    _ => data.animation.easingEnter,
  };

  return navigator.push<T>(
    RawDialogRoute<T>(
      settings: routeSettings,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColour ?? theme.barrierColour,
      barrierLabel: barrierLabel ?? MaterialLocalizations.of(context).modalBarrierDismissLabel,
      requestFocus: requestFocus,
      traversalEdgeBehavior: .closedLoop,
      transitionDuration: switch ((
        MediaQuery.disableAnimationsOf(context),
        (transitionDuration, theme.transitionDuration),
      )) {
        (true, _) => .zero,
        (_, (final value?, _)) || (_, (_, final value?)) => value,
        _ => data.animation.emphasized,
      },
      pageBuilder: (context, animation, secondaryAnimation) => themes.wrap(
        DievasTheme(
          data: data,
          child: DisplayFeatureSubScreen(
            anchorPoint: anchorPoint,
            child: SafeArea(
              top: useSafeArea,
              bottom: useSafeArea,
              left: useSafeArea,
              right: useSafeArea,
              child: Builder(builder: builder),
            ),
          ),
        ),
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
        opacity: animation.drive(CurveTween(curve: curve)),
        child: ScaleTransition(
          scale: animation.drive(Tween<double>(begin: 0.95, end: 1).chain(CurveTween(curve: curve))),
          child: child,
        ),
      ),
    ),
  );
}

/// Closes the nearest modal route with an optional result.
void closeDievasModal<T>(BuildContext context, [T? result]) => Navigator.of(context).pop<T>(result);

/// A modal surface with optional header, body, custom content, and actions.
///
/// [child] replaces the complete standard composition. [content] replaces
/// [body] only. Without a title, custom header or actions, content stands alone.
/// Custom [decoration] owns the painted surface; [borderRadius] controls clipping.
/// Long content scrolls inside the viewport and actions wrap on narrow screens.
class DievasModal extends StatelessWidget {
  const DievasModal({
    super.key,
    this.title,
    this.body,
    this.content,
    this.child,
    this.header,
    this.trailing,
    this.actions = const [],
    this.showCloseButton = true,
    this.onClose,
    this.backgroundColour,
    this.textColour,
    this.titleColour,
    this.contentColour,
    this.iconColour,
    this.borderRadius,
    this.decoration,
    this.shadow,
    this.padding,
    this.insetPadding,
    this.constraints,
    this.semanticLabel,
    this.closeButtonLabel,
  }) : assert(
         child == null || (title == null && header == null && body == null && content == null),
         'child replaces the complete modal composition',
       );

  /// Optional heading; [header] takes precedence.
  final String? title;

  /// Plain body text, replaced by [content] when supplied.
  final String? body;

  /// Custom body between the header and actions.
  final Widget? content;

  /// Complete content replacing the standard header/body/actions composition.
  final Widget? child;

  /// Custom heading widget replacing [title].
  final Widget? header;

  /// Header action replacing the built-in close button.
  final Widget? trailing;

  /// End-aligned actions that wrap when space is limited.
  final List<Widget> actions;

  /// Whether a standard header displays its close button.
  final bool showCloseButton;

  /// Close action; defaults to closing the nearest route.
  final VoidCallback? onClose;

  /// Surface fill; ignored when [decoration] supplies the painted surface.
  final Color? backgroundColour;

  /// Shared foreground fallback for title and content.
  final Color? textColour;

  /// Heading foreground, taking precedence over [textColour].
  final Color? titleColour;

  /// Body and custom content foreground, taking precedence over [textColour].
  final Color? contentColour;

  /// Default content icon and close-button foreground.
  final Color? iconColour;

  /// Surface and clipping radius, resolved in the current text direction.
  final BorderRadiusGeometry? borderRadius;

  /// Complete surface decoration, replacing background, radius and shadow paint.
  final Decoration? decoration;

  /// Surface shadows; an empty list disables them.
  final List<BoxShadow>? shadow;

  /// Inner content padding; defaults to the modal theme.
  final EdgeInsetsGeometry? padding;

  /// Outer viewport inset, in addition to the keyboard and route safe area.
  final EdgeInsetsGeometry? insetPadding;

  /// Content bounds, further constrained by the available viewport.
  final BoxConstraints? constraints;

  /// Accessible route name; defaults to [title].
  final String? semanticLabel;

  /// Accessible close label; defaults to the Dievas localization.
  final String? closeButtonLabel;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).modal;
    final spacing = context.spacing;
    final radius = (borderRadius ?? theme.borderRadius).resolve(Directionality.of(context));
    final foreground = switch ((contentColour, textColour, theme.contentColour, theme.textColour)) {
      (final colour?, _, _, _) ||
      (_, final colour?, _, _) ||
      (_, _, final colour?, _) ||
      (_, _, _, final colour?) => colour,
      _ => context.colours.text.textPrimary,
    };
    final headingColour = switch ((titleColour, textColour, theme.titleColour, theme.textColour)) {
      (final colour?, _, _, _) ||
      (_, final colour?, _, _) ||
      (_, _, final colour?, _) ||
      (_, _, _, final colour?) => colour,
      _ => context.colours.text.textPrimary,
    };
    final icons = switch ((iconColour, theme.iconColour)) {
      (final colour?, _) || (_, final colour?) => colour,
      _ => context.colours.icon.iconPrimary,
    };

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: semanticLabel ?? title,
      child: AnimatedPadding(
        duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : context.animation.quick,
        curve: context.animation.easingStandard,
        padding:
            (insetPadding ?? .all(spacing.lg)).resolve(Directionality.of(context)) + MediaQuery.viewInsetsOf(context),
        child: Center(
          child: ConstrainedBox(
            constraints: constraints ?? BoxConstraints(minWidth: theme.minWidth, maxWidth: theme.maxWidth),
            child: DecoratedBox(
              decoration: switch (decoration) {
                final decor? => decor,
                _ => BoxDecoration(
                  color: backgroundColour ?? theme.backgroundColour,
                  borderRadius: radius,
                  boxShadow: shadow ?? theme.shadow,
                ),
              },
              child: ClipRRect(
                borderRadius: radius,
                child: DefaultTextStyle(
                  style: theme.bodyStyle.copyWith(color: foreground),
                  child: IconTheme(
                    data: IconThemeData(color: icons),
                    child: SingleChildScrollView(
                      primary: false,
                      padding: padding ?? theme.padding,
                      child: switch (child) {
                        final child? => child,
                        _ => _ModalContent(
                          header: header,
                          title: title,
                          trailing: trailing,
                          showCloseButton: showCloseButton,
                          onClose: onClose,
                          closeButtonLabel: closeButtonLabel,
                          iconColour: icons,
                          titleStyle: theme.titleStyle.copyWith(color: headingColour),
                          content: content,
                          body: body,
                          actions: actions,
                        ),
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalContent extends StatelessWidget {
  const _ModalContent({
    required this.header,
    required this.title,
    required this.trailing,
    required this.showCloseButton,
    required this.onClose,
    required this.closeButtonLabel,
    required this.iconColour,
    required this.titleStyle,
    required this.content,
    required this.body,
    required this.actions,
  });

  final Widget? header;
  final String? title;
  final Widget? trailing;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final String? closeButtonLabel;
  final Color iconColour;
  final TextStyle titleStyle;
  final Widget? content;
  final String? body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final heading = switch ((header, title)) {
      (final header?, _) => header,
      (_, final title?) => Text(title, style: titleStyle),
      _ => null,
    };
    final action = switch ((trailing, showCloseButton)) {
      (final trailing?, _) => trailing,
      (_, true) => DievasTextButton(
        size: .sm,
        semanticLabel: closeButtonLabel ?? context.dievasL10n.modalCloseLabel,
        foregroundColor: iconColour,
        onPressed: onClose ?? () => closeDievasModal(context),
        child: Icon(Icons.close, size: DievasTheme.componentsOf(context).modal.closeIconSize, color: iconColour),
      ),
      _ => null,
    };
    final bodyContent = switch ((content, body)) {
      (final content?, _) => content,
      (_, final body?) => Text(body),
      _ => null,
    };
    final hasHeader = heading != null || action != null;
    final spacing = context.spacing;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (hasHeader) _ModalHeader(heading: heading, action: action, titleStyle: titleStyle),
        if (bodyContent case final body?) ...[if (hasHeader) SizedBox(height: spacing.smPlus), body],
        if (actions.isNotEmpty) ...[
          SizedBox(height: spacing.lg),
          Align(
            alignment: .centerEnd,
            child: Wrap(spacing: spacing.sm, runSpacing: spacing.sm, alignment: .end, children: actions),
          ),
        ],
      ],
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader({required this.heading, required this.action, required this.titleStyle});

  final Widget? heading;
  final Widget? action;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: switch (heading) {
          final heading? => DefaultTextStyle(style: titleStyle, child: heading),
          _ => const SizedBox.shrink(),
        },
      ),
      ?action,
    ],
  );
}
