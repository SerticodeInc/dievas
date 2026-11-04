import 'package:flutter/material.dart' show Icons, MaterialLocalizations;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dievas_tokens/dievas_tokens.dart';

import 'package:dievas/src/theme/component/tag/dievas_tag_border_radius.dart';
import 'package:dievas/src/theme/component/tag/dievas_tag_theme_data.dart';
import 'package:dievas/src/theme/dievas_theme.dart';

/// Dievas appearance conveniences retained alongside the Moon-style slots.
enum DievasTagStyle { filled, tinted, outlined }

/// Moon-compatible tag heights: 16, 24, and 32 logical pixels.
enum DievasTagSize { xxs, xs, sm }

/// A compact display tag with optional tap, long press, and remove actions.
/// [labelWidget] overrides [label]; [leading] overrides [leadingIcon].
/// An [onRemove] action takes precedence over a decorative [trailing] slot.
class DievasTag extends StatefulWidget {
  const DievasTag({
    super.key,
    this.label = '',
    this.labelWidget,
    this.style = .filled,
    this.leadingIcon,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onLongPress,
    this.onRemove,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.textColour,
    this.iconColour,
    this.borderRadius,
    this.tagSize,
    this.height,
    this.width,
    this.gap,
    this.padding,
    this.textStyle,
    this.decoration,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.removeSemanticLabel,
  }) : assert(height == null || height > 0),
       assert(width == null || width > 0),
       assert(gap == null || gap >= 0);

  /// String-label convenience. Empty strings omit the label slot.
  final String label;
  final Widget? labelWidget;
  final DievasTagStyle style;
  final Widget? leadingIcon;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onRemove;

  /// Existing colour names remain supported for source compatibility.
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  /// Independent text/icon overrides take precedence over shared foregrounds.
  final Color? textColour;
  final Color? iconColour;
  final DievasTagBorderRadius? borderRadius;
  final DievasTagSize? tagSize;
  final double? height;
  final double? width;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  /// Replaces the default surface decoration; foreground styling is retained.
  final Decoration? decoration;
  final bool enabled;

  /// Caller-owned; never disposed by the tag.
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;
  final String? removeSemanticLabel;

  @override
  State<DievasTag> createState() => _DievasTagState();
}

class _DievasTagState extends State<DievasTag> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final theme = DievasTheme.componentsOf(context).tag;
    final colours = DievasTheme.coloursOf(context);
    final size = _resolveSize(context, theme);
    final height = widget.height ?? size.height;
    final gap = widget.gap ?? size.gap;
    final leading = widget.leading ?? widget.leadingIcon;
    final label = switch ((widget.labelWidget, widget.label)) {
      (final label?, _) => label,
      (_, '') => null,
      (_, final label) => Text(label, maxLines: 1, overflow: .ellipsis),
    };
    final hasTrailing = widget.onRemove != null || widget.trailing != null;
    final resolvedPadding = size.padding.resolve(Directionality.of(context));
    final padding =
        widget.padding ??
        EdgeInsetsDirectional.fromSTEB(
          leading == null && label != null ? resolvedPadding.left : 0,
          resolvedPadding.top,
          hasTrailing || label == null ? 0 : resolvedPadding.right,
          resolvedPadding.bottom,
        );
    final radius = (widget.borderRadius ?? size.borderRadius).resolve(Directionality.of(context));
    final defaults = switch (widget.style) {
      .filled => (background: colours.background.tagBackground, foreground: colours.text.textPrimary),
      .tinted => (background: colours.background.cardBackground, foreground: colours.text.textSecondary),
      .outlined => (background: colours.staticColours.staticTransparent, foreground: colours.text.textSecondary),
    };
    final textColour = switch ((widget.textColour, widget.foregroundColor, theme.textColour, theme.foregroundColor)) {
      (final colour?, _, _, _) ||
      (_, final colour?, _, _) ||
      (_, _, final colour?, _) ||
      (_, _, _, final colour?) => colour,
      _ => defaults.foreground,
    };
    final iconColour = switch ((widget.iconColour, widget.foregroundColor, theme.iconColour, theme.foregroundColor)) {
      (final colour?, _, _, _) ||
      (_, final colour?, _, _) ||
      (_, _, final colour?, _) ||
      (_, _, _, final colour?) => colour,
      _ => defaults.foreground,
    };
    final borderColour = switch ((widget.borderColor, theme.borderColor, widget.style)) {
      (final colour?, _, _) || (_, final colour?, _) => colour,
      (_, _, .outlined) => colours.border.dividerColour,
      _ => colours.staticColours.staticTransparent,
    };
    final background = switch ((widget.backgroundColor, theme.backgroundColor)) {
      (final colour?, _) || (_, final colour?) => colour,
      _ => defaults.background,
    };
    final interactive = widget.enabled && (widget.onPressed != null || widget.onLongPress != null);

    return FocusableActionDetector(
      enabled: interactive,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      mouseCursor: interactive ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            _activate();
            return null;
          },
        ),
      },
      child: Semantics(
        container: true,
        label: widget.semanticLabel,
        button: interactive,
        enabled: widget.enabled,
        onTap: widget.enabled ? widget.onPressed : null,
        onLongPress: widget.enabled ? widget.onLongPress : null,
        child: GestureDetector(
          excludeFromSemantics: true,
          behavior: .opaque,
          onTap: widget.enabled ? widget.onPressed : null,
          onLongPress: widget.enabled ? widget.onLongPress : null,
          child: Opacity(
            opacity: widget.enabled ? DievasTheme.opacityOf(context).opaque : theme.disabledOpacity,
            child: IgnorePointer(
              ignoring: !widget.enabled,
              child: ExcludeFocus(
                excluding: !widget.enabled,
                child: Container(
                  width: widget.width,
                  height: height,
                  constraints: BoxConstraints(minWidth: height),
                  padding: padding,
                  decoration:
                      widget.decoration ??
                      BoxDecoration(
                        color: background,
                        borderRadius: radius,
                        border: Border.all(color: borderColour, width: theme.borderWidth),
                      ),
                  foregroundDecoration: switch ((_focused, interactive)) {
                    (true, true) => BoxDecoration(
                      borderRadius: radius,
                      border: Border.all(
                        color: colours.border.focusIndicatorColour,
                        width: DievasTheme.borderOf(context).strokeThick,
                      ),
                    ),
                    _ => null,
                  },
                  child: IconTheme(
                    data: IconThemeData(size: size.iconSize, color: iconColour),
                    child: DefaultTextStyle(
                      style: size.textStyle.merge(widget.textStyle).copyWith(color: textColour),
                      child: Row(
                        mainAxisSize: .min,
                        mainAxisAlignment: .center,
                        children: [
                          if (leading case final child?)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: gap),
                              child: child,
                            ),
                          if (label case final child?)
                            Flexible(
                              child: ExcludeSemantics(excluding: widget.semanticLabel != null, child: child),
                            ),
                          if (widget.onRemove case final remove?)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: widget.gap ?? theme.removeIconSpacing),
                              child: _RemoveAction(
                                onRemove: widget.enabled ? remove : null,
                                size: widget.tagSize == null ? theme.removeIconSize : size.iconSize,
                                colour: iconColour,
                                semanticLabel:
                                    widget.removeSemanticLabel ??
                                    '${MaterialLocalizations.of(context).deleteButtonTooltip} ${widget.label}',
                              ),
                            )
                          else if (widget.trailing case final child?)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: gap),
                              child: child,
                            ),
                        ],
                      ),
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

  DievasTagSizeData _resolveSize(BuildContext context, DievasTagThemeData theme) {
    final sizing = DievasTheme.sizingOf(context);
    final spacing = DievasTheme.spacingOf(context);
    final border = DievasTheme.borderOf(context);
    final typography = DievasTheme.typographyOf(context);
    return switch (widget.tagSize) {
      .xxs =>
        theme.xxs ??
            DievasTagSizeData(
              height: sizing.height16,
              iconSize: sizing.height12,
              gap: spacing.xs / 2,
              padding: EdgeInsets.symmetric(horizontal: spacing.sm),
              borderRadius: DievasTagBorderRadius.rounded(border.sm),
              textStyle: typography.bodyXs.copyWith(fontSize: DievasFontSizePrimitives.smPlus, height: 4 / 3),
            ),
      .xs =>
        theme.xs ??
            DievasTagSizeData(
              height: sizing.height24,
              iconSize: sizing.iconXs,
              gap: spacing.xs / 2,
              padding: EdgeInsets.symmetric(horizontal: spacing.sm),
              borderRadius: DievasTagBorderRadius.rounded(border.sm),
              textStyle: typography.bodyXs.copyWith(height: 4 / 3),
            ),
      .sm =>
        theme.sm ??
            DievasTagSizeData(
              height: sizing.height32,
              iconSize: sizing.iconXs,
              gap: spacing.sm,
              padding: EdgeInsets.symmetric(horizontal: spacing.md),
              borderRadius: DievasTagBorderRadius.rounded(border.md),
              textStyle: typography.bodyXs.copyWith(height: 4 / 3),
            ),
      null => DievasTagSizeData(
        height: theme.minHeight,
        iconSize: theme.iconSize,
        gap: theme.iconSpacing,
        padding: theme.padding,
        borderRadius: theme.borderRadius,
        textStyle: theme.textStyle,
      ),
    };
  }

  void _activate() {
    if (widget.enabled) (widget.onPressed ?? widget.onLongPress)?.call();
  }
}

class _RemoveAction extends StatefulWidget {
  const _RemoveAction({required this.onRemove, required this.size, required this.colour, required this.semanticLabel});
  final VoidCallback? onRemove;
  final double size;
  final Color colour;
  final String semanticLabel;

  @override
  State<_RemoveAction> createState() => _RemoveActionState();
}

class _RemoveActionState extends State<_RemoveAction> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
    enabled: widget.onRemove != null,
    mouseCursor: widget.onRemove != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
    onShowFocusHighlight: (value) => setState(() => _focused = value),
    shortcuts: const {
      SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
    },
    actions: {
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (_) {
          widget.onRemove?.call();
          return null;
        },
      ),
    },
    child: Semantics(
      label: widget.semanticLabel,
      button: true,
      enabled: widget.onRemove != null,
      onTap: widget.onRemove,
      excludeSemantics: true,
      child: GestureDetector(
        excludeFromSemantics: true,
        behavior: .opaque,
        onTap: widget.onRemove,
        child: SizedBox.square(
          dimension: widget.size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: DievasTheme.borderOf(context).xs,
              border: _focused
                  ? Border.all(
                      color: DievasTheme.coloursOf(context).border.focusIndicatorColour,
                      width: DievasTheme.borderOf(context).strokeThin,
                    )
                  : null,
            ),
            child: Icon(Icons.close, size: widget.size, color: widget.colour),
          ),
        ),
      ),
    ),
  );
}
