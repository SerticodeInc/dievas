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
