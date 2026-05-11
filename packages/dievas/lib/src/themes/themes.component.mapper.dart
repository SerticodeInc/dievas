part of '../themes.dart';

/// Derives [DievasComponentThemeData] from all token sub-systems.
///
/// As components land in M3 / M4, add their factory calls here.
/// The [override] parameter supports [DievasThemeData.copyWith].
DievasComponentThemeData _deriveDievasComponentThemeData(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
  DievasComponentThemeData? override,
) => DievasComponentThemeData(
  filledButton: override?.filledButton ?? _createFilledButtonGroup(colors, typography, spacing, sizing, border),
  outlinedButton: override?.outlinedButton ?? _createOutlinedButtonGroup(colors, typography, spacing, sizing, border),
  textButton: override?.textButton ?? _createTextButtonGroup(colors, typography),
  iconButton: override?.iconButton ?? _createIconButtonGroup(colors, sizing, border),
  badge: override?.badge ?? _createBadgeTheme(typography, spacing, border),
  avatar: override?.avatar ?? _createAvatarTheme(colors, typography, sizing, border),
  tag: override?.tag ?? _createTagTheme(typography, spacing, border),
  linearProgress: override?.linearProgress ?? _createLinearProgressTheme(colors, border),
  circularProgress: override?.circularProgress ?? _createCircularProgressTheme(colors),
  checkbox: override?.checkbox ?? _createCheckboxTheme(colors, typography, spacing, border),
  toggle: override?.toggle ?? _createSwitchTheme(colors, typography, spacing),
  radio: override?.radio ?? _createRadioTheme(colors, typography, spacing),
  textInput: override?.textInput ?? _createTextInputTheme(colors, typography, spacing, sizing, border),
);

// Shared layout helper
/// Extracts a [Radius] from a [BorderRadius] (uses topLeft corner).
Radius _r(BorderRadius br) => br.topLeft;

typedef _SharedLayout = ({
  DievasButtonThemeValue<TextStyle> textStyle,
  DievasButtonThemeValue<double> height,
  DievasButtonThemeValue<double> iconSize,
  DievasButtonThemeValue<double> iconSpacing,
  DievasButtonThemeValue<({Radius square, Radius pill})> radius,
  DievasButtonThemeValue<EdgeInsets> padding,
  double disabledOpacity,
});

_SharedLayout _sharedButtonLayout(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) => (
  textStyle: (sm: typography.labelSm, md: typography.labelMd, lg: typography.labelLg),
  height: (sm: sizing.buttonHeightSm, md: sizing.buttonHeightMd, lg: sizing.buttonHeightLg),
  iconSize: (sm: sizing.iconSm, md: sizing.iconMd, lg: sizing.iconLg),
  iconSpacing: (sm: spacing.xs, md: spacing.xs, lg: spacing.sm),
  radius: (
    sm: (square: _r(border.sm), pill: Radius.circular(DievasRadiusSemantic.full)),
    md: (square: _r(border.md), pill: Radius.circular(DievasRadiusSemantic.full)),
    lg: (square: _r(border.md), pill: Radius.circular(DievasRadiusSemantic.full)),
  ),
  padding: (
    sm: EdgeInsets.symmetric(horizontal: spacing.smPlus),
    md: EdgeInsets.symmetric(horizontal: spacing.md),
    lg: EdgeInsets.symmetric(horizontal: spacing.md),
  ),
  disabledOpacity: DievasOpacitySemantic.disabled,
);

// Filled button
DievasFilledButtonGroupThemeData _createFilledButtonGroup(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  final layout = _sharedButtonLayout(typography, spacing, sizing, border);
  final c = colors.action;
  final onBrand = colors.core.onBrand;

  DievasFilledButtonThemeData make(DievasFilledButtonThemeStateStyle style) => DievasFilledButtonThemeData(
    textStyle: layout.textStyle,
    height: layout.height,
    iconSize: layout.iconSize,
    iconSpacing: layout.iconSpacing,
    radius: layout.radius,
    padding: layout.padding,
    disabledOpacity: layout.disabledOpacity,
    style: style,
  );

  return DievasFilledButtonGroupThemeData(
    primary: make((
      idle: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionPrimary),
      focused: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionPrimaryActive),
    )),
    secondary: make((
      idle: DievasFilledButtonThemeStyle(
        foreground: colors.text.textPrimary,
        icon: colors.icon.iconPrimary,
        background: c.actionSecondary,
      ),
      focused: DievasFilledButtonThemeStyle(
        foreground: colors.text.textPrimary,
        icon: colors.icon.iconPrimary,
        background: c.actionSecondaryHover,
      ),
    )),
    destructive: make((
      idle: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionError),
      focused: DievasFilledButtonThemeStyle(foreground: onBrand, icon: onBrand, background: c.actionErrorHover),
    )),
  );
}

// Outlined button
DievasOutlinedButtonGroupThemeData _createOutlinedButtonGroup(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  final layout = _sharedButtonLayout(typography, spacing, sizing, border);
  final c = colors.action;

  DievasOutlinedButtonThemeData make(DievasOutlinedButtonThemeStateStyle style) => DievasOutlinedButtonThemeData(
    textStyle: layout.textStyle,
    height: layout.height,
    iconSize: layout.iconSize,
    iconSpacing: layout.iconSpacing,
    radius: layout.radius,
    padding: layout.padding,
    disabledOpacity: layout.disabledOpacity,
    style: style,
  );

  return DievasOutlinedButtonGroupThemeData(
    primary: make((
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
    destructive: make((
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
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
) {
  final c = colors.action;

  DievasTextButtonThemeData make(DievasTextButtonThemeStateStyle style) => DievasTextButtonThemeData(
    textStyle: (sm: typography.labelSm, md: typography.labelMd, lg: typography.labelLg),
    iconSize: (sm: 14.0, md: 16.0, lg: 18.0),
    iconSpacing: (sm: 4.0, md: 4.0, lg: 6.0),
    disabledOpacity: DievasOpacitySemantic.disabled,
    style: style,
  );

  return DievasTextButtonGroupThemeData(
    primary: make((
      idle: DievasTextButtonThemeStyle(foreground: c.actionPrimary, icon: c.actionPrimary),
      focused: DievasTextButtonThemeStyle(foreground: c.actionPrimaryActive, icon: c.actionPrimaryActive),
    )),
    destructive: make((
      idle: DievasTextButtonThemeStyle(foreground: c.actionError, icon: c.actionError),
      focused: DievasTextButtonThemeStyle(foreground: c.actionErrorHover, icon: c.actionErrorHover),
    )),
  );
}

// Icon button
DievasIconButtonGroupThemeData _createIconButtonGroup(
  DievasColourThemeData colors,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) {
  final iconColor = colors.icon.iconPrimary;
  final actionPrimary = colors.action.actionPrimary;

  DievasIconButtonThemeData make(DievasIconButtonThemeStateStyle style) => DievasIconButtonThemeData(
    size: (sm: sizing.buttonHeightSm, md: sizing.buttonHeightMd, lg: sizing.buttonHeightLg),
    iconSize: (sm: sizing.iconSm, md: sizing.iconMd, lg: sizing.iconLg),
    radius: (sm: _r(border.sm), md: _r(border.md), lg: _r(border.md)),
    disabledOpacity: DievasOpacitySemantic.disabled,
    style: style,
  );

  return DievasIconButtonGroupThemeData(
    ghost: make((
      idle: DievasIconButtonThemeStyle(icon: iconColor, foreground: iconColor, background: Colors.transparent),
      focused: DievasIconButtonThemeStyle(
        icon: actionPrimary,
        foreground: actionPrimary,
        background: Colors.transparent,
      ),
    )),
    tinted: make((
      idle: DievasIconButtonThemeStyle(
        icon: actionPrimary,
        foreground: actionPrimary,
        background: colors.background.bgSubtle,
      ),
      focused: DievasIconButtonThemeStyle(
        icon: actionPrimary,
        foreground: actionPrimary,
        background: colors.background.bgElevated,
      ),
    )),
  );
}

// Badge
DievasBadgeThemeData _createBadgeTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasBadgeThemeData(
  textStyle: typography.labelXs,
  borderRadius: border.full,
  padding: EdgeInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs / 2),
  iconSize: 10.0,
  iconSpacing: spacing.xs,
);

// Avatar
DievasAvatarThemeData _createAvatarTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) => DievasAvatarThemeData(
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
  backgroundColor: colors.background.bgSubtle,
  initialsColor: colors.text.textSecondary,
  placeholderColor: colors.icon.iconSecondary,
);

// Tag
DievasTagThemeData _createTagTheme(
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasTagThemeData(
  textStyle: typography.labelSm,
  borderRadius: border.sm,
  padding: EdgeInsets.symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
  iconSize: 14.0,
  iconSpacing: spacing.xs,
  removeIconSize: 14.0,
  removeIconSpacing: spacing.xs,
  minHeight: 28.0,
);

// LinearProgress
DievasLinearProgressThemeData _createLinearProgressTheme(DievasColourThemeData colors, DievasBorderThemeData border) =>
    DievasLinearProgressThemeData(
      height: 4.0,
      borderRadius: border.full,
      trackColor: colors.background.bgSubtle,
      colorPrimary: colors.action.actionPrimary,
      colorSuccess: colors.feedback.feedbackSuccess.icon,
      colorError: colors.feedback.feedbackError.icon,
    );

// CircularProgress
DievasCircularProgressThemeData _createCircularProgressTheme(DievasColourThemeData colors) =>
    DievasCircularProgressThemeData(
      sizeSm: 16.0,
      sizeMd: 24.0,
      sizeLg: 32.0,
      strokeWidth: 2.5,
      colorPrimary: colors.action.actionPrimary,
      colorOnBrand: colors.core.onBrand,
      trackColor: colors.background.bgSubtle,
    );

// Checkbox
DievasCheckboxThemeData _createCheckboxTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasCheckboxThemeData(
  size: 20.0,
  borderRadius: border.xs,
  strokeWidth: 2.0,
  colorChecked: colors.action.actionPrimary,
  colorUnchecked: const Color(0x00000000),
  colorDisabled: colors.action.actionPrimaryDisabled,
  borderColorUnchecked: colors.border.borderDefault,
  borderColorDisabled: colors.border.borderDisabled,
  checkColor: colors.core.onBrand,
  disabledOpacity: DievasOpacitySemantic.disabled,
  labelStyle: typography.bodyMd,
  labelSpacing: spacing.sm,
);

// Switch
DievasSwitchThemeData _createSwitchTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
) => DievasSwitchThemeData(
  trackWidth: 44.0,
  trackHeight: 24.0,
  trackRadius: BorderRadius.circular(DievasRadiusSemantic.full),
  thumbSize: 18.0,
  thumbRadius: BorderRadius.circular(DievasRadiusSemantic.full),
  thumbPadding: 3.0,
  trackColorOn: colors.switchColours.switchTrackOn,
  trackColorOff: colors.switchColours.switchTrackOff,
  thumbColor: colors.switchColours.switchThumb,
  borderColorOff: colors.switchColours.switchBorder,
  disabledOpacity: DievasOpacitySemantic.disabled,
  animationDuration: const Duration(milliseconds: 200),
  labelStyle: typography.bodyMd,
  labelSpacing: spacing.sm,
);

// Radio
DievasRadioThemeData _createRadioTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
) => DievasRadioThemeData(
  size: 20.0,
  strokeWidth: 2.0,
  dotSize: 8.0,
  colorSelected: colors.action.actionPrimary,
  colorUnselected: const Color(0x00000000),
  colorDisabled: colors.action.actionPrimaryDisabled,
  borderColorUnselected: colors.border.borderDefault,
  borderColorDisabled: colors.border.borderDisabled,
  dotColor: colors.core.onBrand,
  disabledOpacity: DievasOpacitySemantic.disabled,
  labelStyle: typography.bodyMd,
  labelSpacing: spacing.sm,
);

// TextInput (shared with TextArea)
DievasTextInputThemeData _createTextInputTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasSizingThemeData sizing,
  DievasBorderThemeData border,
) => DievasTextInputThemeData(
  inputStyle: (sm: typography.bodySm, md: typography.bodyMd, lg: typography.bodyLg),
  labelStyle: typography.labelSm.copyWith(color: colors.text.textSecondary),
  helperStyle: typography.bodySm.copyWith(color: colors.text.textSecondary),
  errorStyle: typography.bodySm,
  placeholderStyle: (
    sm: typography.bodySm.copyWith(color: colors.input.inputPlaceholder),
    md: typography.bodyMd.copyWith(color: colors.input.inputPlaceholder),
    lg: typography.bodyLg.copyWith(color: colors.input.inputPlaceholder),
  ),
  height: (sm: sizing.inputHeightSm, md: sizing.inputHeightMd, lg: sizing.inputHeightLg),
  contentPadding: (
    sm: EdgeInsets.symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
    md: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
    lg: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.smPlus),
  ),
  borderRadius: border.md,
  strokeWidth: 1.0,
  strokeWidthFocused: 1.5,
  bgColor: colors.input.inputBg,
  borderColor: colors.input.inputBorder,
  borderColorFocused: colors.input.inputBorderFocus,
  borderColorError: colors.input.inputBorderError,
  iconColor: colors.icon.iconSecondary,
  iconSize: 20.0,
  iconSpacing: spacing.xs,
  labelSpacing: spacing.xs,
  helperSpacing: spacing.xs,
  disabledOpacity: DievasOpacitySemantic.disabled,
);
