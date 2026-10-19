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
    search: override?.search ?? _createSearchTheme(colours, typography, sizing, spacing, border, elevation),
    segmentedControl:
        override?.segmentedControl ??
        _createSegmentedControlTheme(colours, typography, spacing, sizing, border, animation),
    alert: override?.alert ?? _createAlertTheme(typography, spacing, border),
    snackbar: override?.snackbar ?? _createSnackbarTheme(colours, typography, spacing, border),
    bottomSheet: override?.bottomSheet ?? _createBottomSheetTheme(colours, border),
    modal: override?.modal ?? _createModalTheme(colours, typography, spacing, border, elevation),
    tooltip: override?.tooltip ?? _createTooltipTheme(colours, typography, spacing, border, animation),
    loader: override?.loader ?? _createLoaderTheme(colours, typography, spacing, animation),
    menuItem: override?.menuItem ?? _createMenuItemTheme(colours, typography, spacing, sizing, border),
    emptyState: override?.emptyState ?? _createEmptyStateTheme(colours, typography, spacing),
    accordion: override?.accordion ?? _createAccordionTheme(typography, spacing, border, animation),
    drawer: override?.drawer ?? _createDrawerTheme(colours, border, animation, elevation),
    dropdown:
        override?.dropdown ?? _createDropdownTheme(colours, typography, spacing, sizing, border, elevation, animation),
    tabBar: override?.tabBar ?? _createTabBarTheme(colours, typography, spacing, sizing, border, animation),
    popover: override?.popover ?? _createPopoverTheme(colours, typography, spacing, border, animation, elevation),
    divider: override?.divider ?? _createDividerTheme(colours, border),
  );
}

// Component-level constants — layout extents (minWidth/maxWidth) are overlay-sizing constraints.
const double _kStrokeProgress = 2.5; // circular progress arc
const double _kStrokeLoader = 3.0; // loader spinner
const double _kSwitchThumbPadding = 3.0; // inset between thumb and track edge
const DievasInputThemeValue<double> _kCursorWidth = (SM: 1.5, MD: 2.0, LG: 2.5);
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
    textStyle: (SM: typography.labelSm, MD: typography.labelMd, LG: typography.labelLg),
    height: (SM: sizing.buttonHeightSm, MD: sizing.buttonHeightMd, LG: sizing.buttonHeightLg),
    iconSize: (SM: sizing.iconSm, MD: sizing.iconMd, LG: sizing.iconLg),
    iconSpacing: (SM: spacing.xs, MD: spacing.xs, LG: spacing.sm),
    radius: (
      SM: (square: _extractRadius(border.sm), pill: .circular(DievasRadiusSemantic.full)),
      MD: (square: _extractRadius(border.md), pill: .circular(DievasRadiusSemantic.full)),
      LG: (square: _extractRadius(border.md), pill: .circular(DievasRadiusSemantic.full)),
    ),
    padding: (
      SM: .symmetric(horizontal: spacing.smPlus),
      MD: .symmetric(horizontal: spacing.md),
      LG: .symmetric(horizontal: spacing.md),
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
  final buttonPrimaryText = colours.text.buttonPrimaryText;

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
      idle: DievasFilledButtonThemeStyle(
        foreground: buttonPrimaryText,
        icon: buttonPrimaryText,
        background: c.buttonPrimaryBackground,
      ),
      focused: DievasFilledButtonThemeStyle(
        foreground: buttonPrimaryText,
        icon: buttonPrimaryText,
        background: c.buttonPrimaryPressedBackground,
      ),
    )),
    secondary: makeThemeData((
      idle: DievasFilledButtonThemeStyle(
        foreground: colours.text.textPrimary,
        icon: colours.icon.iconPrimary,
        background: c.buttonSecondaryBackground,
      ),
      focused: DievasFilledButtonThemeStyle(
        foreground: colours.text.textPrimary,
        icon: colours.icon.iconPrimary,
        background: c.buttonSecondaryHoveredBackground,
      ),
    )),
    destructive: makeThemeData((
      idle: DievasFilledButtonThemeStyle(
        foreground: buttonPrimaryText,
        icon: buttonPrimaryText,
        background: c.buttonDestructiveBackground,
      ),
      focused: DievasFilledButtonThemeStyle(
        foreground: buttonPrimaryText,
        icon: buttonPrimaryText,
        background: c.buttonDestructiveHoveredBackground,
      ),
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
        foreground: colours.text.textPrimary,
        icon: colours.icon.iconPrimary,
        borderSide: BorderSide(color: colours.icon.iconSecondary),
      ),
      focused: DievasOutlinedButtonThemeStyle(
        foreground: colours.text.textPrimary,
        icon: colours.icon.iconPrimary,
        borderSide: BorderSide(color: colours.icon.iconSecondary),
      ),
    )),
    destructive: makeThemeData((
      idle: DievasOutlinedButtonThemeStyle(
        foreground: c.buttonDestructiveBackground,
        icon: c.buttonDestructiveBackground,
        borderSide: BorderSide(color: c.buttonDestructiveBackground),
      ),
      focused: DievasOutlinedButtonThemeStyle(
        foreground: c.buttonDestructiveHoveredBackground,
        icon: c.buttonDestructiveHoveredBackground,
        borderSide: BorderSide(color: c.buttonDestructiveHoveredBackground),
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
    textStyle: (SM: typography.labelSm, MD: typography.labelMd, LG: typography.labelLg),
    iconSize: (SM: DievasSizingPrimitives.s14, MD: DievasSizingPrimitives.s16, LG: DievasSizingPrimitives.s18),
    iconSpacing: (SM: DievasSpacingPrimitives.s1, MD: DievasSpacingPrimitives.s1, LG: DievasSpacingPrimitives.s2),
    disabledOpacity: DievasOpacitySemantic.disabled,
    pressOpacity: 0.7,
    style: style,
  );

  return DievasTextButtonGroupThemeData(
    primary: makeThemeData((
      idle: DievasTextButtonThemeStyle(foreground: colours.text.textSecondary, icon: colours.icon.iconSecondary),
      focused: DievasTextButtonThemeStyle(foreground: colours.text.textPrimary, icon: colours.icon.iconPrimary),
    )),
    destructive: makeThemeData((
      idle: DievasTextButtonThemeStyle(foreground: c.buttonDestructiveBackground, icon: c.buttonDestructiveBackground),
      focused: DievasTextButtonThemeStyle(
        foreground: c.buttonDestructiveHoveredBackground,
        icon: c.buttonDestructiveHoveredBackground,
      ),
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
  final transparent = colours.staticColours.staticTransparent;

  DievasIconButtonThemeData makeThemeData(DievasIconButtonThemeStateStyle style) => DievasIconButtonThemeData(
    size: (SM: sizing.buttonHeightSm, MD: sizing.buttonHeightMd, LG: sizing.buttonHeightLg),
    iconSize: (SM: sizing.iconSm, MD: sizing.iconMd, LG: sizing.iconLg),
    radius: (SM: _extractRadius(border.sm), MD: _extractRadius(border.md), LG: _extractRadius(border.md)),
    disabledOpacity: DievasOpacitySemantic.disabled,
    pressOpacity: 0.7,
    style: style,
  );

  // The variants differ only by container — transparent versus a surface fill —
  // and share one icon colour, so the names describe the background and nothing
  // else. State feedback is the opacity dim, never a hue flip: the brand colour
  // on a bare sheet falls under the 3:1 icon-contrast floor.
  return DievasIconButtonGroupThemeData(
    ghost: makeThemeData((
      idle: DievasIconButtonThemeStyle(icon: iconColour, background: transparent),
      focused: DievasIconButtonThemeStyle(icon: iconColour, background: transparent),
    )),
    tinted: makeThemeData((
      idle: DievasIconButtonThemeStyle(icon: iconColour, background: colours.background.iconButtonBackground),
      focused: DievasIconButtonThemeStyle(icon: iconColour, background: colours.background.iconButtonFocusedBackground),
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
  colourActive: colours.action.sliderActiveTrack,
  colourInactive: colours.border.dividerColour,
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
    padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
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
    sizeXS: sizing.avatarXs,
    sizeSM: sizing.avatarSm,
    sizeMD: sizing.avatarMd,
    sizeLG: sizing.avatarLg,
    sizeXL: sizing.avatarXl,
    sizeXL2: sizing.height80,
    borderRadiusSquare: border.md,
    initialsStyleXS: typography.labelXs,
    initialsStyleSM: typography.labelSm,
    initialsStyleMD: typography.labelMd,
    initialsStyleLG: typography.labelLg,
    initialsStyleXL: typography.titleSm,
    initialsStyleXL2: typography.titleMd,
    badgeColour: colours.feedback.feedbackSuccess.icon,
    backgroundColour: colours.background.pageBackground,
    initialsColour: colours.text.textPrimary,
    placeholderColour: colours.icon.iconPrimary,
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
    trackColour: colours.background.progressTrack,
    colourPrimary: colours.action.progressIndicator,
    colourSuccess: colours.feedback.feedbackSuccess.icon,
    colourError: colours.feedback.feedbackError.icon,
  );
}

// CircularProgress
DievasCircularProgressThemeData _createCircularProgressTheme(DievasColourThemeData colours) {
  return DievasCircularProgressThemeData(
    sizeSM: DievasSizingPrimitives.s16,
    sizeMD: DievasSizingPrimitives.s24,
    sizeLG: DievasSizingPrimitives.s32,
    strokeWidth: _kStrokeProgress,
    colourPrimary: colours.action.progressIndicator,
    colourOnBrand: colours.action.progressOnPrimaryIndicator,
    trackColour: colours.background.progressTrack,
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
    colourChecked: colours.action.checkboxCheckedBackground,
    colourUnchecked: colours.staticColours.staticTransparent,
    colourDisabled: colours.action.checkboxDisabledBackground,
    borderColourUnchecked: colours.border.dividerColour,
    borderColourDisabled: colours.border.inputDisabledBorder,
    checkColour: colours.action.checkboxCheckmark,
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
    trackColourOn: colours.switchColours.switchOnTrack,
    trackColourOff: colours.switchColours.switchOffTrack,
    thumbColourOn: colours.switchColours.switchOnThumb,
    thumbColourOff: colours.switchColours.switchOffThumb,
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
  colourSelected: colours.action.radioSelectedBackground,
  colourUnselected: colours.staticColours.staticTransparent,
  colourDisabled: colours.action.radioDisabledBackground,
  borderColourUnselected: colours.border.dividerColour,
  borderColourDisabled: colours.border.inputDisabledBorder,
  dotColour: colours.action.radioDot,
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
  inputStyle: (SM: typography.bodySm, MD: typography.bodyMd, LG: typography.bodyLg),
  labelStyle: typography.labelSm.copyWith(color: colours.text.textSecondary),
  helperStyle: typography.bodySm.copyWith(color: colours.text.textSecondary),
  errorStyle: typography.bodySm,
  placeholderStyle: (
    SM: typography.bodySm.copyWith(color: colours.input.inputPlaceholderText),
    MD: typography.bodyMd.copyWith(color: colours.input.inputPlaceholderText),
    LG: typography.bodyLg.copyWith(color: colours.input.inputPlaceholderText),
  ),
  height: (SM: sizing.inputHeightSm, MD: sizing.inputHeightMd, LG: sizing.inputHeightLg),
  contentPadding: (
    SM: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    MD: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
    LG: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  ),
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBackground,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.input.inputFocusedBorder,
  borderColourError: colours.input.inputErrorBorder,
  borderColourWarning: colours.input.inputWarningBorder,
  iconColour: colours.icon.iconSecondary,
  iconSize: DievasSizingPrimitives.s20,
  iconSpacing: spacing.sm,
  cursorWidth: _kCursorWidth,
  cursorHeight: (SM: typography.bodySm.fontSize!, MD: typography.bodyMd.fontSize!, LG: typography.bodyLg.fontSize!),
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
  height: (SM: sizing.inputHeightSm, MD: sizing.inputHeightMd, LG: sizing.inputHeightLg),
  contentPadding: (
    SM: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    MD: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
    LG: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  ),
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBackground,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.input.inputFocusedBorder,
  dividerColour: colours.border.dividerColour,
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
  bgColour: colours.input.inputBackground,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.action.buttonPrimaryBackground,
  borderColourError: colours.input.inputErrorBorder,
  cursorColour: colours.action.inputCursor,
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
  DievasElevationThemeData elevation,
) => DievasSearchThemeData(
  inputStyle: typography.bodyMd,
  placeholderStyle: typography.bodyMd.copyWith(color: colours.input.inputPlaceholderText),
  height: sizing.inputHeightMd,
  borderRadius: border.md,
  strokeWidth: border.strokeThin,
  strokeWidthFocused: border.strokeDefault,
  bgColour: colours.input.inputBackground,
  borderColour: colours.input.inputBorder,
  borderColourFocused: colours.input.inputFocusedBorder,
  iconColour: colours.icon.iconSecondary,
  iconSize: DievasSizingPrimitives.s20,
  contentPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
  resultItemStyle: typography.bodyMd,
  resultItemPadding: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  resultMaxHeight: 240.0,
  dividerColour: colours.border.dividerColour,
  dividerIndent: spacing.md,
  disabledOpacity: DievasOpacitySemantic.disabled,
  shadow: elevation.md,
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
    backgroundColour: colours.background.bottomSheetBackground,
    barrierColour: colours.background.modalBarrierBackground,
  );
}

// Modal
DievasModalThemeData _createModalTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
  DievasElevationThemeData elevation,
) {
  return DievasModalThemeData(
    titleStyle: typography.titleMd,
    bodyStyle: typography.bodyMd,
    backgroundColour: colours.background.dialogBackground,
    barrierColour: colours.background.modalBarrierBackground,
    borderRadius: border.lg,
    padding: .all(spacing.lg),
    minWidth: _kModalMinWidth,
    maxWidth: _kModalMaxWidth,
    closeIconSize: DievasSizingPrimitives.s20,
    shadow: elevation.lg,
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
    backgroundColour: colours.background.tooltipBackground,
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
    spinnerSizeSM: DievasSizingPrimitives.s20,
    spinnerSizeMD: DievasSizingPrimitives.s32,
    spinnerSizeLG: DievasSizingPrimitives.s48,
    strokeWidth: _kStrokeLoader,
    color: colours.action.progressIndicator,
    trackColour: const Color(0x00000000),
    labelStyle: typography.bodySm.copyWith(color: colours.text.textSecondary),
    labelSpacing: spacing.sm,
    animationDuration: animation.loader,
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
    padding: .symmetric(horizontal: spacing.xl, vertical: spacing.xl2),
  );
}

// Accordion
DievasAccordionThemeData _createAccordionTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
) {
  return DievasAccordionThemeData(
    headerStyle: typography.titleXs,
    contentStyle: typography.bodySm,
    padding: .symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
    contentPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
    borderRadius: border.md,
    borderWidth: border.strokeThin,
    iconSize: DievasSizingPrimitives.s20,
    iconSpacing: spacing.sm,
    dividerIndent: spacing.md,
    animationDuration: animation.standard,
  );
}

// Drawer
DievasDrawerThemeData _createDrawerTheme(
  DievasColourThemeData colours,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
  DievasElevationThemeData elevation,
) {
  return DievasDrawerThemeData(
    backgroundColour: colours.background.drawerBackground,
    width: DievasSizingPrimitives.s64 * 4,
    borderRadius: .only(topRight: _extractRadius(border.xl), bottomRight: _extractRadius(border.xl)),
    barrierColour: colours.background.modalBarrierBackground,
    animationDuration: animation.moderate,
    shadow: elevation.lg,
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
  labelStyle: typography.labelSm.copyWith(color: colours.text.textPrimary),
  selectedLabelStyle: typography.labelSm.copyWith(
    fontWeight: .w700,
    color: colours.action.segmentedControlSelectedText,
  ),
  borderRadius: border.md,
  padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.sm),
  bgColour: colours.background.segmentedControlBackground,
  selectedBgColour: colours.action.segmentedControlSelectedBackground,
  borderColour: colours.border.dividerColour,
  textColour: colours.text.textPrimary,
  selectedTextColour: colours.action.segmentedControlSelectedText,
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
  textStyle: typography.titleXs.copyWith(color: colours.text.textPrimary),
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
  hintStyle: typography.bodyMd.copyWith(color: colours.input.inputPlaceholderText),
  labelStyle: typography.labelSm.copyWith(color: colours.text.textSecondary),
  labelSpacing: spacing.sm,
  triggerBgColour: colours.input.inputBackground,
  triggerBorderColour: colours.border.dividerColour,
  triggerBorderColourFocused: colours.action.buttonPrimaryBackground,
  borderRadius: border.md,
  triggerPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
  iconSize: sizing.iconSm,
  iconColour: colours.icon.iconSecondary,
  overlayBgColour: colours.background.menuBackground,
  overlayBorderColour: colours.border.dividerColour,
  overlayBorderRadius: border.md,
  shadow: elevation.md,
  optionStyle: typography.bodyMd,
  optionSelectedColour: colours.background.listItemSelectedBackground,
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
  selectedLabelStyle: typography.titleXs.copyWith(color: colours.text.textPrimary),
  indicatorColour: colours.action.tabSelectedIndicator,
  indicatorHeight: border.strokeThick,
  dividerColour: colours.border.dividerColour,
  tabPadding: .symmetric(horizontal: spacing.md, vertical: spacing.sm),
  animationDuration: animation.standard,
  disabledOpacity: DievasOpacitySemantic.disabled,
  minTabWidth: DievasSizingPrimitives.s64,
  height: sizing.inputHeightMd,
);

// Divider
DievasDividerThemeData _createDividerTheme(DievasColourThemeData colours, DievasBorderThemeData border) =>
    DievasDividerThemeData(colour: colours.border.dividerColour, thickness: border.strokeThick);

// Popover
DievasPopoverThemeData _createPopoverTheme(
  DievasColourThemeData colours,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
  DievasAnimationThemeData animation,
  DievasElevationThemeData elevation,
) {
  return DievasPopoverThemeData(
    backgroundColour: colours.background.popoverBackground,
    textStyle: typography.bodyMd.copyWith(color: colours.text.textPrimary),
    borderRadius: border.md,
    padding: .all(spacing.smPlus),
    verticalOffset: DievasSizingPrimitives.s8,
    horizontalOffset: DievasSizingPrimitives.s8,
    arrowSize: DievasSizingPrimitives.s8,
    barrierColour: colours.background.modalBarrierBackground,
    animationDuration: animation.standard,
    shadow: elevation.md,
    maxWidth: 280.0,
  );
}
