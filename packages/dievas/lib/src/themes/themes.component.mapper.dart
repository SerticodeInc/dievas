part of '../themes.dart';

/// Derives [DievasComponentThemeData] from all token sub-systems.
///
/// As components land in M3 / M4, add their factory calls here.
/// The [override] parameter supports [DievasThemeData.copyWith].
DievasComponentThemeData _deriveDievasComponentThemeData(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
  DievasElevationThemeData elevation,
  DievasComponentThemeData? override,
) {
  return DievasComponentThemeData(
    filledButton: override?.filledButton ?? _createFilledButtonGroup(colours, typography, spacing, sizing, border),
    outlinedButton:
        override?.outlinedButton ?? _createOutlinedButtonGroup(colours, typography, spacing, sizing, border),
    textButton: override?.textButton ?? _createTextButtonGroup(colours, typography, spacing),
    iconButton: override?.iconButton ?? _createIconButtonGroup(colours, sizing, border),
    badge: override?.badge ?? _createBadgeTheme(typography, spacing, border),
    breadcrumb: override?.breadcrumb ?? _createBreadcrumbTheme(colours, typography, spacing, sizing),
    dotIndicator: override?.dotIndicator ?? _createDotIndicatorTheme(colours, animation),
    avatar: override?.avatar ?? _createAvatarTheme(colours, typography, sizing, border),
    tag: override?.tag ?? _createTagTheme(typography, spacing, border),
    linearProgress: override?.linearProgress ?? _createLinearProgressTheme(colours, border),
    circularProgress: override?.circularProgress ?? _createCircularProgressTheme(colours),
    checkbox: override?.checkbox ?? _createCheckboxTheme(colours, typography, spacing, border),
    toggle: override?.toggle ?? _createSwitchTheme(colours, typography, spacing, animation),
    radio: override?.radio ?? _createRadioTheme(colours, typography, spacing, border),
    textInput: override?.textInput ?? _createTextInputTheme(colours, typography, spacing, sizing, border),
    authCode: override?.authCode ?? _createAuthCodeTheme(colours, typography, sizing, spacing, border),
    textInputGroup: override?.textInputGroup ?? _createTextInputGroupTheme(colours, sizing, spacing, border),
    search: override?.search ?? _createSearchTheme(colours, typography, sizing, spacing, border),
    segmentedControl:
        override?.segmentedControl ??
        _createSegmentedControlTheme(colours, typography, spacing, sizing, border, animation),
    alert: override?.alert ?? _createAlertTheme(typography, spacing, border),
    snackbar: override?.snackbar ?? _createSnackbarTheme(colours, typography, spacing, border),
    bottomSheet: override?.bottomSheet ?? _createBottomSheetTheme(colours, border),
    modal: override?.modal ?? _createModalTheme(colours, typography, spacing, border),
    tooltip: override?.tooltip ?? _createTooltipTheme(colours, typography, spacing, border, animation),
    loader: override?.loader ?? _createLoaderTheme(colours, typography, spacing, animation),
    menuItem: override?.menuItem ?? _createMenuItemTheme(colours, typography, spacing, sizing, border),
    emptyState: override?.emptyState ?? _createEmptyStateTheme(colours, typography, spacing),
    accordion: override?.accordion ?? _createAccordionTheme(typography, spacing, border, animation, elevation),
    drawer: override?.drawer ?? _createDrawerTheme(colours, border, animation),
    dropdown:
        override?.dropdown ?? _createDropdownTheme(colours, typography, spacing, sizing, border, elevation, animation),
    tabBar: override?.tabBar ?? _createTabBarTheme(colours, typography, spacing, sizing, border, animation),
    popover: override?.popover ?? _createPopoverTheme(colours, typography, spacing, border, animation),
    divider: override?.divider ?? _createDividerTheme(colours, border),
  );
}

// Component-level constants — layout extents (minWidth/maxWidth) are overlay-sizing constraints.
const double _kStrokeProgress = 2.5; // circular progress arc
const double _kStrokeLoader = 3.0; // loader spinner
const double _kSwitchThumbPadding = 3.0; // inset between thumb and track edge
const double _kSnackbarMinWidth = 280.0;
const double _kSnackbarMaxWidth = 480.0;
const double _kModalMinWidth = 320.0;
const double _kModalMaxWidth = 520.0;

// Shared layout helper
/// Extracts a [Radius] from a [BorderRadius] (uses topLeft corner).
Radius _extractRadius(BorderRadius radius) => radius.topLeft;

typedef _SharedLayout = ({
  DievasButtonThemeValue<TextStyle> textStyle,
  DievasButtonThemeValue<double> height,
  DievasButtonThemeValue<double> iconSize,
  DievasButtonThemeValue<double> iconSpacing,
  DievasButtonThemeValue<({Radius square, Radius pill})> radius,
  DievasButtonThemeValue<EdgeInsets> padding,
  double disabledOpacity,
  double pressOpacity,
});

_SharedLayout _sharedButtonLayout(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  return (
    textStyle: (sm: typography.labelSm, md: typography.labelMd, lg: typography.labelLg),
    height: (sm: sizing.buttonHeightSm, md: sizing.buttonHeightMd, lg: sizing.buttonHeightLg),
    iconSize: (sm: sizing.iconSm, md: sizing.iconMd, lg: sizing.iconLg),
    iconSpacing: (sm: spacing.xs, md: spacing.xs, lg: spacing.sm),
    radius: (
      sm: (square: _extractRadius(border.sm), pill: .circular(DievasRadiusSemantic.full)),
      md: (square: _extractRadius(border.md), pill: .circular(DievasRadiusSemantic.full)),
      lg: (square: _extractRadius(border.md), pill: .circular(DievasRadiusSemantic.full)),
    ),
    padding: (
      sm: .symmetric(horizontal: spacing.smPlus),
      md: .symmetric(horizontal: spacing.md),
      lg: .symmetric(horizontal: spacing.md),
    ),
    disabledOpacity: DievasOpacitySemantic.disabled,
    pressOpacity: 0.7,
  );
}

// Filled button
DievasFilledButtonGroupThemeData _createFilledButtonGroup(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  final layout = _sharedButtonLayout(typography, spacing, sizing, border);
  final c = colours.action;
  final onBrand = colours.core.onBrand;

  DievasFilledButtonThemeData makeThemeData(DievasFilledButtonThemeStateStyle style) => DievasFilledButtonThemeData(
    textStyle: layout.textStyle,
    height: layout.height,
    iconSize: layout.iconSize,
    iconSpacing: layout.iconSpacing,
    radius: layout.radius,
    padding: layout.padding,
    disabledOpacity: layout.disabledOpacity,
    pressOpacity: layout.pressOpacity,
    style: style,
  );

  return DievasFilledButtonGroupThemeData(
    primary: makeThemeData((
      idle: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionPrimary),
      focused: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionPrimaryActive),
    )),
    secondary: makeThemeData((
      idle: DievasFilledButtonThemeStyle(
        foreground: colours.text.textPrimary,
        icon: colours.icon.iconPrimary,
        background: c.actionSecondary,
      ),
      focused: DievasFilledButtonThemeStyle(
        foreground: colours.text.textPrimary,
        icon: colours.icon.iconPrimary,
        background: c.actionSecondaryHover,
      ),
    )),
    destructive: makeThemeData((
      idle: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionError),
      focused: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionErrorHover),
    )),
  );
}

// Outlined button
DievasOutlinedButtonGroupThemeData _createOutlinedButtonGroup(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  final layout = _sharedButtonLayout(typography, spacing, sizing, border);
  final c = colours.action;

  DievasOutlinedButtonThemeData makeThemeData(DievasOutlinedButtonThemeStateStyle style) =>
      DievasOutlinedButtonThemeData(
        textStyle: layout.textStyle,
        height: layout.height,
        iconSize: layout.iconSize,
        iconSpacing: layout.iconSpacing,
        radius: layout.radius,
        padding: layout.padding,
        disabledOpacity: layout.disabledOpacity,
        pressOpacity: layout.pressOpacity,
        style: style,
      );

  return DievasOutlinedButtonGroupThemeData(
    primary: makeThemeData((
      idle: DievasOutlinedButtonThemeStyle(
        foreground: c.actionPrimary,
        icon: c.actionPrimary,
        borderSide: BorderSide(color: c.actionPrimary),
      ),
      focused: DievasOutlinedButtonThemeStyle(
        foreground: c.actionPrimaryActive,
        icon: c.actionPrimaryActive,
        borderSide: BorderSide(color: c.actionPrimaryActive),
      ),
    )),
    destructive: makeThemeData((
      idle: DievasOutlinedButtonThemeStyle(
        foreground: c.actionError,
        icon: c.actionError,
        borderSide: BorderSide(color: c.actionError),
      ),
      focused: DievasOutlinedButtonThemeStyle(
        foreground: c.actionErrorHover,
        icon: c.actionErrorHover,
        borderSide: BorderSide(color: c.actionErrorHover),
      ),
    )),
  );
}

// Text button
DievasTextButtonGroupThemeData _createTextButtonGroup(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
) {
  final c = colours.action;

  DievasTextButtonThemeData makeThemeData(DievasTextButtonThemeStateStyle style) => DievasTextButtonThemeData(
    textStyle: (sm: typography.labelSm, md: typography.labelMd, lg: typography.labelLg),
    iconSize: (sm: DievasSizingPrimitives.s14, md: DievasSizingPrimitives.s16, lg: DievasSizingPrimitives.s18),
    iconSpacing: (sm: DievasSpacingPrimitives.s1, md: DievasSpacingPrimitives.s1, lg: DievasSpacingPrimitives.s2),
    disabledOpacity: DievasOpacitySemantic.disabled,
    pressOpacity: 0.7,
    style: style,
  );

  return DievasTextButtonGroupThemeData(
    primary: makeThemeData((
      idle: DievasTextButtonThemeStyle(foreground: c.actionPrimary, icon: c.actionPrimary),
      focused: DievasTextButtonThemeStyle(foreground: c.actionPrimaryActive, icon: c.actionPrimaryActive),
    )),
    destructive: makeThemeData((
      idle: DievasTextButtonThemeStyle(foreground: c.actionError, icon: c.actionError),
      focused: DievasTextButtonThemeStyle(foreground: c.actionErrorHover, icon: c.actionErrorHover),
    )),
  );
}

// Icon button
DievasIconButtonGroupThemeData _createIconButtonGroup(
  DievasColourThemeData colours,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  final iconColour = colours.icon.iconPrimary;
  final actionPrimary = colours.action.actionPrimary;
  final transparent = colours.staticColours.staticTransparent;

  DievasIconButtonThemeData makeThemeData(DievasIconButtonThemeStateStyle style) => DievasIconButtonThemeData(
    size: (sm: sizing.buttonHeightSm, md: sizing.buttonHeightMd, lg: sizing.buttonHeightLg),
    iconSize: (sm: sizing.iconSm, md: sizing.iconMd, lg: sizing.iconLg),
    radius: (sm: _extractRadius(border.sm), md: _extractRadius(border.md), lg: _extractRadius(border.md)),
    disabledOpacity: DievasOpacitySemantic.disabled,
    pressOpacity: 0.7,
    style: style,
  );

  return DievasIconButtonGroupThemeData(
    ghost: makeThemeData((
      idle: DievasIconButtonThemeStyle(icon: iconColour, foreground: iconColour, background: transparent),
      focused: DievasIconButtonThemeStyle(icon: actionPrimary, foreground: actionPrimary, background: transparent),
    )),
    tinted: makeThemeData((
      idle: DievasIconButtonThemeStyle(
        icon: actionPrimary,
        foreground: actionPrimary,
        background: colours.background.bgSubtle,
      ),
      focused: DievasIconButtonThemeStyle(
        icon: actionPrimary,
        foreground: actionPrimary,
        background: colours.background.bgElevated,
      ),
    )),
  );
}

// DotIndicator
DievasDotIndicatorThemeData _createDotIndicatorTheme(
  DievasColourThemeData colours,
  DievasAnimationThemeData animation,
) => DievasDotIndicatorThemeData(
  dotSize: DievasSizingPrimitives.s8,
  activeDotSize: DievasSizingPrimitives.s10,
  dotSpacing: DievasSpacingPrimitives.s2,
  colourActive: colours.action.actionPrimary,
  colourInactive: colours.border.borderDefault,
  animationDuration: animation.standard,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// Breadcrumb
DievasBreadcrumbThemeData _createBreadcrumbTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
) => DievasBreadcrumbThemeData(
  itemStyle: typography.bodySm.copyWith(color: colours.text.textSecondary),
  activeItemStyle: typography.bodySm.copyWith(color: colours.text.textPrimary),
  separatorStyle: typography.bodySm.copyWith(color: colours.icon.iconDisabled),
  separatorSpacing: spacing.sm,
  iconSize: sizing.iconSm,
  iconSpacing: spacing.sm,
  minHitHeight: DievasSizingPrimitives.s40,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// Badge
DievasBadgeThemeData _createBadgeTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) {
  return DievasBadgeThemeData(
    textStyle: typography.labelXs,
    borderRadius: border.full,
    padding: .symmetric(horizontal: spacing.sm, vertical: spacing.xs / 2),
    iconSize: DievasSizingPrimitives.s10,
    iconSpacing: spacing.xs,
  );
}

// Avatar
DievasAvatarThemeData _createAvatarTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  return DievasAvatarThemeData(
    sizeXs: sizing.avatarXs,
    sizeSm: sizing.avatarSm,
    sizeMd: sizing.avatarMd,
    sizeLg: sizing.avatarLg,
    sizeXl: sizing.avatarXl,
    borderRadiusSquare: border.md,
    initialsStyleXs: typography.labelXs,
    initialsStyleSm: typography.labelSm,
    initialsStyleMd: typography.labelMd,
    initialsStyleLg: typography.labelLg,
    initialsStyleXl: typography.titleSm,
    backgroundColour: colours.background.bgSubtle,
    initialsColour: colours.text.textSecondary,
    placeholderColour: colours.icon.iconSecondary,
  );
}

// Tag
DievasTagThemeData _createTagTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) {
  return DievasTagThemeData(
    textStyle: typography.labelSm,
    borderRadius: DievasTagBorderRadius.rounded(border.sm),
    padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    iconSize: DievasSizingPrimitives.s14,
    iconSpacing: spacing.xs,
    removeIconSize: DievasSizingPrimitives.s14,
    removeIconSpacing: spacing.xs,
    minHeight: DievasSizingPrimitives.s28,
    borderWidth: border.strokeDefault,
  );
}

// LinearProgress
DievasLinearProgressThemeData _createLinearProgressTheme(DievasColourThemeData colours, DievasBorderThemeData border) {
  return DievasLinearProgressThemeData(
    height: DievasSizingPrimitives.s4,
    borderRadius: border.full,
    trackColour: colours.background.bgSubtle,
    colourPrimary: colours.action.actionPrimary,
    colourSuccess: colours.feedback.feedbackSuccess.icon,
    colourError: colours.feedback.feedbackError.icon,
  );
}

// CircularProgress
DievasCircularProgressThemeData _createCircularProgressTheme(DievasColourThemeData colours) {
  return DievasCircularProgressThemeData(
    sizeSm: DievasSizingPrimitives.s16,
    sizeMd: DievasSizingPrimitives.s24,
    sizeLg: DievasSizingPrimitives.s32,
    strokeWidth: _kStrokeProgress,
    colourPrimary: colours.action.actionPrimary,
    colourOnBrand: colours.core.onBrand,
    trackColour: colours.background.bgSubtle,
  );
}

// Checkbox
DievasCheckboxThemeData _createCheckboxTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) {
  return DievasCheckboxThemeData(
    size: DievasSizingPrimitives.s20,
    borderRadius: border.xs,
    strokeWidth: border.strokeThick,
    colourChecked: colours.action.actionPrimary,
    colourUnchecked: colours.staticColours.staticTransparent,
    colourDisabled: colours.action.actionPrimaryDisabled,
    borderColourUnchecked: colours.border.borderDefault,
    borderColourDisabled: colours.border.borderDisabled,
    checkColour: colours.core.onBrand,
    disabledOpacity: DievasOpacitySemantic.disabled,
    labelStyle: typography.bodyMd,
    labelSpacing: spacing.sm,
  );
}

// Switch
DievasSwitchThemeData _createSwitchTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasAnimationThemeData animation,
) {
  return DievasSwitchThemeData(
    trackWidth: DievasSizingPrimitives.s44,
    trackHeight: DievasSizingPrimitives.s24,
    trackRadius: .circular(DievasRadiusSemantic.full),
    thumbSize: DievasSizingPrimitives.s18,
    thumbRadius: .circular(DievasRadiusSemantic.full),
    thumbPadding: _kSwitchThumbPadding,
    trackColourOn: colours.switchColours.switchTrackOn,
    trackColourOff: colours.switchColours.switchTrackOff,
    thumbColour: colours.switchColours.switchThumb,
    borderColourOff: colours.switchColours.switchBorder,
    disabledOpacity: DievasOpacitySemantic.disabled,
    animationDuration: animation.standard,
    labelStyle: typography.bodyMd,
    labelSpacing: spacing.sm,
  );
}

// Radio
DievasRadioThemeData _createRadioTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasRadioThemeData(
  size: DievasSizingPrimitives.s20,
  strokeWidth: border.strokeThick,
  dotSize: DievasSizingPrimitives.s8,
  colourSelected: colours.action.actionPrimary,
  colourUnselected: colours.staticColours.staticTransparent,
  colourDisabled: colours.action.actionPrimaryDisabled,
  borderColourUnselected: colours.border.borderDefault,
  borderColourDisabled: colours.border.borderDisabled,
  dotColour: colours.core.onBrand,
  disabledOpacity: DievasOpacitySemantic.disabled,
  labelStyle: typography.bodyMd,
  labelSpacing: spacing.sm,
);

// TextInput (shared with TextArea)
DievasTextInputThemeData _createTextInputTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) => DievasTextInputThemeData(
  inputStyle: (sm: typography.bodySm, md: typography.bodyMd, lg: typography.bodyLg),
  labelStyle: typography.labelSm.copyWith(color: colours.text.textSecondary),
  helperStyle: typography.bodySm.copyWith(color: colours.text.textSecondary),
  errorStyle: typography.bodySm,
  placeholderStyle: (
    sm: typography.bodySm.copyWith(color: colours.input.inputPlaceholder),
    md: typography.bodyMd.copyWith(color: colours.input.inputPlaceholder),
    lg: typography.bodyLg.copyWith(color: colours.input.inputPlaceholder),
  ),
  height: (sm: sizing.inputHeightSm, md: sizing.inputHeightMd, lg: sizing.inputHeightLg),
  contentPadding: (
    sm: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    md: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
    lg: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  ),
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBg,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.input.inputBorderFocus,
  borderColourError: colours.input.inputBorderError,
  iconColour: colours.icon.iconSecondary,
  iconSize: DievasSizingPrimitives.s20,
  iconSpacing: spacing.sm,
  labelSpacing: spacing.sm,
  helperSpacing: spacing.sm,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// TextInputGroup
DievasTextInputGroupThemeData _createTextInputGroupTheme(
  DievasColourThemeData colours,
  DievasSizingThemeData sizing,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasTextInputGroupThemeData(
  height: (sm: sizing.inputHeightSm, md: sizing.inputHeightMd, lg: sizing.inputHeightLg),
  contentPadding: (
    sm: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    md: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
    lg: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  ),
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBg,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.input.inputBorderFocus,
  dividerColour: colours.border.borderDefault,
  dividerWidth: border.strokeThin,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// AuthCode
DievasAuthCodeThemeData _createAuthCodeTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSizingThemeData sizing,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasAuthCodeThemeData(
  digitStyle: typography.titleLg,
  height: sizing.inputHeightLg,
  width: sizing.inputHeightLg,
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBg,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.action.actionPrimary,
  borderColourError: colours.input.inputBorderError,
  cursorColour: colours.action.actionPrimary,
  cursorWidth: 2.0,
  cursorHeight: DievasSizingPrimitives.s24,
  gap: spacing.sm,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// Search (shared by DievasSearchWithList and DievasSearchWithDropdown)
DievasSearchThemeData _createSearchTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSizingThemeData sizing,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasSearchThemeData(
  inputStyle: typography.bodyMd,
  placeholderStyle: typography.bodyMd.copyWith(color: colours.input.inputPlaceholder),
  height: sizing.inputHeightMd,
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBg,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.input.inputBorderFocus,
  iconColour: colours.icon.iconSecondary,
  iconSize: DievasSizingPrimitives.s20,
  contentPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
  resultItemStyle: typography.bodyMd,
  resultItemPadding: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  resultMaxHeight: 240.0,
  dividerColour: colours.border.borderDefault,
  dividerIndent: spacing.md,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// Alert
DievasAlertThemeData _createAlertTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasAlertThemeData(
  titleStyle: typography.labelMd,
  bodyStyle: typography.bodySm,
  iconSize: DievasSizingPrimitives.s20,
  iconSpacing: spacing.sm,
  padding: .all(spacing.smPlus),
  borderRadius: border.md,
  borderWidth: border.strokeThin,
  dismissIconSize: DievasSizingPrimitives.s18,
);

// Snackbar
DievasSnackbarThemeData _createSnackbarTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasSnackbarThemeData(
  messageStyle: typography.bodySm,
  actionStyle: typography.labelSm,
  iconSize: DievasSizingPrimitives.s18,
  iconSpacing: spacing.xs,
  padding: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  borderRadius: border.md,
  minWidth: _kSnackbarMinWidth,
  maxWidth: _kSnackbarMaxWidth,
  bottomInset: spacing.lg,
);

// BottomSheet
DievasBottomSheetThemeData _createBottomSheetTheme(DievasColourThemeData colours, DievasBorderThemeData border) {
  return DievasBottomSheetThemeData(
    borderRadius: .only(topLeft: _extractRadius(border.xl), topRight: _extractRadius(border.xl)),
    handleWidth: DievasSizingPrimitives.s40,
    handleHeight: DievasSizingPrimitives.s4,
    handleRadius: border.full,
    handleTopInset: DievasSpacingPrimitives.s3,
    backgroundColour: colours.background.bgElevated,
    barrierColour: colours.background.bgOverlay,
    elevation: DievasElevationSemantic.md,
  );
}

// Modal
DievasModalThemeData _createModalTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) {
  return DievasModalThemeData(
    titleStyle: typography.titleMd,
    bodyStyle: typography.bodyMd,
    backgroundColour: colours.background.bgElevated,
    barrierColour: colours.background.bgOverlay,
    borderRadius: border.lg,
    padding: .all(spacing.lg),
    minWidth: _kModalMinWidth,
    maxWidth: _kModalMaxWidth,
    closeIconSize: DievasSizingPrimitives.s20,
    elevation: DievasElevationSemantic.lg,
  );
}

// Tooltip
DievasTooltipThemeData _createTooltipTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
) {
  return DievasTooltipThemeData(
    textStyle: typography.labelXs.copyWith(color: colours.text.textInverse),
    backgroundColour: colours.background.bgElevated,
    borderRadius: border.sm,
    padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    verticalOffset: DievasSizingPrimitives.s20,
    waitDuration: animation.xSlow,
    showDuration: animation.tooltipShow,
  );
}

// Loader
DievasLoaderThemeData _createLoaderTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasAnimationThemeData animation,
) {
  return DievasLoaderThemeData(
    spinnerSizeSm: DievasSizingPrimitives.s20,
    spinnerSizeMd: DievasSizingPrimitives.s32,
    spinnerSizeLg: DievasSizingPrimitives.s48,
    strokeWidth: _kStrokeLoader,
    color: colours.action.actionPrimary,
    trackColour: colours.background.bgSubtle,
    labelStyle: typography.bodySm.copyWith(color: colours.text.textSecondary),
    labelSpacing: spacing.sm,
    animationDuration: animation.standard,
  );
}

// EmptyState
DievasEmptyStateThemeData _createEmptyStateTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
) {
  return DievasEmptyStateThemeData(
    titleStyle: typography.headingSm,
    descriptionStyle: typography.bodyMd,
    iconSize: DievasSizingPrimitives.s48,
    iconColour: colours.icon.iconSecondary,
    titleSpacing: spacing.md,
    descriptionSpacing: spacing.sm,
    actionSpacing: spacing.lg,
    padding: .symmetric(horizontal: spacing.xl, vertical: spacing.x2l),
  );
}

// Accordion
DievasAccordionThemeData _createAccordionTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
  DievasElevationThemeData elevation,
) {
  return DievasAccordionThemeData(
    headerStyle: typography.titleXsm,
    contentStyle: typography.bodySm,
    padding: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
    contentPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
    borderRadius: border.md,
    borderWidth: border.strokeThin,
    iconSize: DievasSizingPrimitives.s20,
    iconSpacing: spacing.sm,
    dividerIndent: spacing.md,
    animationDuration: animation.standard,
    shadows: elevation.xs,
  );
}

// Drawer
DievasDrawerThemeData _createDrawerTheme(
  DievasColourThemeData colours,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
) {
  return DievasDrawerThemeData(
    backgroundColour: colours.background.bgElevated,
    width: DievasSizingPrimitives.s64 * 4,
    borderRadius: .only(topRight: _extractRadius(border.xl), bottomRight: _extractRadius(border.xl)),
    barrierColour: colours.background.bgOverlay,
    animationDuration: animation.moderate,
    elevation: DievasElevationSemantic.lg,
  );
}

// SegmentedControl
DievasSegmentedControlThemeData _createSegmentedControlTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
) => DievasSegmentedControlThemeData(
  labelStyle: typography.bodyMd.copyWith(color: colours.text.textPrimary),
  selectedLabelStyle: typography.labelSm.copyWith(color: colours.core.onBrand),
  borderRadius: border.md,
  padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.sm),
  bgColour: colours.background.bgSubtle,
  selectedBgColour: colours.action.actionPrimary,
  borderColour: colours.border.borderDefault,
  textColour: colours.text.textPrimary,
  selectedTextColour: colours.core.onBrand,
  disabledOpacity: DievasOpacitySemantic.disabled,
  animationDuration: animation.standard,
  minSegmentWidth: DievasSizingPrimitives.s64,
  minHeight: DievasSizingPrimitives.s32,
);

// MenuItem
DievasMenuItemThemeData _createMenuItemTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) => DievasMenuItemThemeData(
  textStyle: typography.titleXsm.copyWith(color: colours.text.textPrimary),
  subtitleStyle: typography.bodyXs.copyWith(color: colours.text.textSecondary),
  iconSize: sizing.iconSm,
  iconSpacing: spacing.sm,
  padding: .symmetric(horizontal: spacing.sm, vertical: spacing.sm),
  densePadding: .symmetric(horizontal: spacing.sm, vertical: spacing.xs),
  borderRadius: border.sm,
  textColour: colours.text.textPrimary,
  textColourDisabled: colours.text.textDisabled,
  subtitleColour: colours.text.textSecondary,
  subtitleColourDisabled: colours.text.textDisabled,
  iconColour: colours.icon.iconPrimary,
  iconColourDisabled: colours.icon.iconDisabled,
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// Dropdown
DievasDropdownThemeData _createDropdownTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
  DievasElevationThemeData elevation,
  DievasAnimationThemeData animation,
) => DievasDropdownThemeData(
  triggerStyle: typography.bodyMd.copyWith(color: colours.text.textPrimary),
  hintStyle: typography.bodyMd.copyWith(color: colours.input.inputPlaceholder),
  labelStyle: typography.labelSm.copyWith(color: colours.text.textSecondary),
  labelSpacing: spacing.sm,
  triggerBgColour: colours.input.inputBg,
  triggerBorderColour: colours.border.borderDefault,
  triggerBorderColourFocused: colours.action.actionPrimary,
  borderRadius: border.md,
  triggerPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
  iconSize: sizing.iconSm,
  iconColour: colours.icon.iconSecondary,
  overlayBgColour: colours.background.bgElevated,
  overlayBorderColour: colours.border.borderDefault,
  overlayBorderRadius: border.md,
  overlayElevation: elevation.md,
  optionStyle: typography.bodyMd,
  optionSelectedColour: colours.background.bgSubtle,
  optionTextColour: colours.text.textPrimary,
  optionTextColourDisabled: colours.text.textDisabled,
  optionPadding: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  disabledOpacity: DievasOpacitySemantic.disabled,
  animationDuration: animation.standard,
  minHeight: sizing.inputHeightMd,
);

// TabBar
DievasTabBarThemeData _createTabBarTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
) => DievasTabBarThemeData(
  labelStyle: typography.bodySm.copyWith(color: colours.text.textSecondary),
  selectedLabelStyle: typography.titleXsm.copyWith(color: colours.text.textPrimary),
  indicatorColour: colours.action.actionPrimary,
  indicatorHeight: border.strokeThick,
  dividerColour: colours.border.borderDefault,
  tabPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
  animationDuration: animation.standard,
  disabledOpacity: DievasOpacitySemantic.disabled,
  minTabWidth: DievasSizingPrimitives.s64,
  height: sizing.inputHeightMd,
);

// Divider
DievasDividerThemeData _createDividerTheme(DievasColourThemeData colours, DievasBorderThemeData border) =>
    DievasDividerThemeData(colour: colours.border.borderDefault, thickness: border.strokeThick);

// Popover
DievasPopoverThemeData _createPopoverTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
) {
  return DievasPopoverThemeData(
    backgroundColour: colours.background.bgElevated,
    textStyle: typography.bodyMd.copyWith(color: colours.text.textPrimary),
    borderRadius: border.md,
    padding: .all(spacing.smPlus),
    verticalOffset: DievasSizingPrimitives.s8,
    horizontalOffset: DievasSizingPrimitives.s8,
    arrowSize: DievasSizingPrimitives.s8,
    barrierColour: colours.background.bgOverlay,
    animationDuration: animation.standard,
    elevation: DievasElevationSemantic.md,
    maxWidth: 280.0,
  );
}
