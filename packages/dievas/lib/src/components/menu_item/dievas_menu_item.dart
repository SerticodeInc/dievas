import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:dievas/src/components/divider/dievas_divider.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// A menu row with text conveniences and caller owned widget slots.
///
/// [labelWidget], [leading] and [content] take precedence over their text/icon
/// conveniences. A row without callbacks leaves embedded controls interactive.
class DievasMenuItem extends StatefulWidget {
  const DievasMenuItem({
    super.key,
    required this.label,
    this.leadingIcon,
    this.leading,
    this.labelWidget,
    this.content,
    this.trailing,
    this.subtitle,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.dense = false,
    this.absorbGestures = false,
    this.autofocus = false,
    this.focusNode,
    this.semanticLabel,
    this.leadingColour,
    this.labelColour,
    this.contentColour,
    this.trailingColour,
    this.backgroundColour,
    this.hoverEffectColour,
    this.borderRadius,
    this.decoration,
    this.width,
    this.height,
    this.padding,
    this.horizontalGap,
    this.verticalGap,
    this.menuItemCrossAxisAlignment,
    this.labelAndContentCrossAxisAlignment,
    this.hoverEffectDuration,
    this.hoverEffectCurve,
  });

  final String label;
  final Widget? leadingIcon;
  final Widget? leading;
  final Widget? labelWidget;
  final Widget? content;
  final Widget? trailing;
  final String? subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final bool dense;

  /// Route child gestures to the row instead of embedded controls.
  final bool absorbGestures;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? semanticLabel;
  final Color? leadingColour;
  final Color? labelColour;
  final Color? contentColour;
  final Color? trailingColour;
  final Color? backgroundColour;
  final Color? hoverEffectColour;
  final BorderRadiusGeometry? borderRadius;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? horizontalGap;
  final double? verticalGap;
  final CrossAxisAlignment? menuItemCrossAxisAlignment;
  final CrossAxisAlignment? labelAndContentCrossAxisAlignment;
  final Duration? hoverEffectDuration;
  final Curve? hoverEffectCurve;

  /// Insert themed dividers between menu rows, without outer separators.
  static Iterable<Widget> divideMenuItems({required Iterable<Widget> menuItems}) sync* {
    bool first = true;
    for (final item in menuItems) {
      if (!first) yield const DievasDivider();
      yield item;
      first = false;
    }
  }

  @override
  State<DievasMenuItem> createState() => _DievasMenuItemState();
}

class _DievasMenuItemState extends State<DievasMenuItem> {
  bool _focused = false;
  bool _hovered = false;

  bool get _actionable => widget.enabled && (widget.onTap != null || widget.onLongPress != null);

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).menuItem;
    final leading = switch ((widget.leading, widget.leadingIcon)) {
      (final leading?, _) => leading,
      (_, final icon) => icon,
    };
    final labelColour = switch ((widget.labelColour, widget.enabled)) {
      (final colour?, _) => colour,
      (_, true) => theme.textColour,
      _ => theme.textColourDisabled,
    };
    final contentColour = switch ((widget.contentColour, widget.enabled)) {
      (final colour?, _) => colour,
      (_, true) => theme.subtitleColour,
      _ => theme.subtitleColourDisabled,
    };
    final content = switch ((widget.content, widget.subtitle)) {
      (final child?, _) => child,
      (_, final text?) => Text(text, style: theme.subtitleStyle.copyWith(color: contentColour)),
      _ => null,
    };
    final gap = switch (widget.horizontalGap) {
      final value? => value,
      _ => theme.iconSpacing,
    };
    final radius = switch (widget.borderRadius) {
      final value? => value,
      _ => theme.borderRadius,
    };

    return FocusableActionDetector(
      enabled: _actionable,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      mouseCursor: _actionable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            if (_actionable) {
              (switch ((widget.onTap, widget.onLongPress)) {
                (final onTap?, _) => onTap,
                (_, final onLongPress?) => onLongPress,
                _ => null,
              })?.call();
            }
            return null;
          },
        ),
      },
      child: Semantics(
        label: widget.semanticLabel,
        button: _actionable,
        enabled: widget.enabled,
        child: GestureDetector(
          behavior: .opaque,
          onTap: widget.enabled ? widget.onTap : null,
          onLongPress: widget.enabled ? widget.onLongPress : null,
          child: AnimatedContainer(
            duration: switch ((MediaQuery.disableAnimationsOf(context), widget.hoverEffectDuration)) {
              (true, _) => .zero,
              (_, final duration?) => duration,
              _ => theme.hoverEffectDuration,
            },
            curve: switch (widget.hoverEffectCurve) {
              final value? => value,
              _ => theme.hoverEffectCurve,
            },
            width: widget.width,
            height: widget.height,
            constraints: BoxConstraints(minHeight: theme.minHeight),
            padding: switch ((widget.padding, widget.dense)) {
              (final padding?, _) => padding,
              (_, true) => theme.densePadding,
              _ => theme.padding,
            },
            foregroundDecoration: switch (_actionable && _focused) {
              true => BoxDecoration(
                borderRadius: radius,
                border: .all(color: DievasTheme.coloursOf(context).action.buttonPrimaryBackground),
              ),
              _ => null,
            },
            decoration: switch (widget.decoration) {
              final decoration? => decoration,
              _ => BoxDecoration(
                color: switch ((
                  _actionable && (_focused || _hovered),
                  widget.hoverEffectColour,
                  widget.backgroundColour,
                )) {
                  (true, final colour?, _) => colour,
                  (true, _, _) => theme.hoverEffectColour,
                  (_, _, final colour?) => colour,
                  _ => theme.backgroundColour,
                },
                borderRadius: radius,
              ),
            },
            child: Opacity(
              opacity: switch (widget.enabled) {
                true => DievasTheme.opacityOf(context).opaque,
                false => theme.disabledOpacity,
              },
              child: AbsorbPointer(
                absorbing: widget.absorbGestures || !widget.enabled,
                child: Row(
                  crossAxisAlignment: switch (widget.menuItemCrossAxisAlignment) {
                    final alignment? => alignment,
                    _ => .center,
                  },
                  children: [
                    if (leading case final icon?) ...[
                      _MenuSlot(
                        colour: switch ((widget.leadingColour, widget.enabled)) {
                          (final colour?, _) => colour,
                          (_, true) => theme.iconColour,
                          _ => theme.iconColourDisabled,
                        },
                        style: theme.textStyle,
                        iconSize: theme.iconSize,
                        child: icon,
                      ),
                      SizedBox(width: gap),
                    ],
                    Expanded(
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: switch (widget.labelAndContentCrossAxisAlignment) {
                          final alignment? => alignment,
                          _ => .start,
                        },
                        children: [
                          _MenuSlot(
                            colour: labelColour,
                            style: theme.textStyle,
                            iconSize: theme.iconSize,
                            child: switch (widget.labelWidget) {
                              final label? => label,
                              _ => Text(widget.label, style: theme.textStyle.copyWith(color: labelColour)),
                            },
                          ),
                          if (content case final mainContent?) ...[
                            SizedBox(
                              height: switch (widget.verticalGap) {
                                final value? => value,
                                _ => theme.verticalGap,
                              },
                            ),
                            _MenuSlot(
                              colour: contentColour,
                              style: theme.subtitleStyle,
                              iconSize: theme.iconSize,
                              child: mainContent,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (widget.trailing case final trailing?) ...[
                      SizedBox(width: gap),
                      _MenuSlot(
                        colour: switch ((widget.trailingColour, widget.enabled)) {
                          (final colour?, _) => colour,
                          (_, true) => theme.iconColour,
                          _ => theme.iconColourDisabled,
                        },
                        style: theme.textStyle,
                        iconSize: theme.iconSize,
                        child: trailing,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuSlot extends StatelessWidget {
  const _MenuSlot({required this.colour, required this.style, required this.iconSize, required this.child});
  final Color colour;
  final TextStyle style;
  final double iconSize;
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
    style: style.copyWith(color: colour),
    child: IconTheme.merge(
      data: IconThemeData(color: colour, size: iconSize),
      child: child,
    ),
  );
}
