import 'package:flutter/widgets.dart';

/// The Moon-compatible 32px and 40px tab heights.
enum DievasTabBarSize { sm, md }

/// Underline navigation, filled pill tabs, or caller-painted content.
enum DievasTabBarVariant { underline, pill, custom }

/// Content and interaction options for one tab.
@immutable
class DievasTab {
  const DievasTab({
    this.leading,
    this.label,
    this.trailing,
    this.builder,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.semanticLabel,
    this.style,
  });

  final Widget? leading;
  final Widget? label;
  final Widget? trailing;

  /// Overrides the standard slots. Receives the controlled selection state.
  final Widget Function(BuildContext context, bool selected)? builder;
  final bool enabled;

  /// Caller-owned; never disposed by the tab bar.
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isFocusable;
  final bool showFocusEffect;
  final String? semanticLabel;
  final DievasTabStyle? style;
}

/// Shared tab styling, with optional per-tab overrides through [DievasTab.style].
/// Explicit state colours take precedence over [textStyle]'s colour.
@immutable
class DievasTabStyle {
  const DievasTabStyle({
    this.textColour,
    this.selectedTextColour,
    this.iconColour,
    this.selectedIconColour,
    this.indicatorColour,
    this.indicatorHeight,
    this.selectedBackgroundColour,
    this.focusColour,
    this.borderRadius,
    this.padding,
    this.gap,
    this.textStyle,
    this.decoration,
  });

  final Color? textColour;
  final Color? selectedTextColour;
  final Color? iconColour;
  final Color? selectedIconColour;
  final Color? indicatorColour;
  final double? indicatorHeight;
  final Color? selectedBackgroundColour;
  final Color? focusColour;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? gap;
  final TextStyle? textStyle;

  /// Paints above the default surface without suppressing its selected fill.
  final Decoration? decoration;

  /// Applies non-null fields from [other] over this style.
  DievasTabStyle merge(DievasTabStyle? other) => DievasTabStyle(
    textColour: other?.textColour ?? textColour,
    selectedTextColour: other?.selectedTextColour ?? selectedTextColour,
    iconColour: other?.iconColour ?? iconColour,
    selectedIconColour: other?.selectedIconColour ?? selectedIconColour,
    indicatorColour: other?.indicatorColour ?? indicatorColour,
    indicatorHeight: other?.indicatorHeight ?? indicatorHeight,
    selectedBackgroundColour: other?.selectedBackgroundColour ?? selectedBackgroundColour,
    focusColour: other?.focusColour ?? focusColour,
    borderRadius: other?.borderRadius ?? borderRadius,
    padding: other?.padding ?? padding,
    gap: other?.gap ?? gap,
    textStyle: textStyle?.merge(other?.textStyle) ?? other?.textStyle,
    decoration: other?.decoration ?? decoration,
  );
}
