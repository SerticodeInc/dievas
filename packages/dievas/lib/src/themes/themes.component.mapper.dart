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
  alert: override?.alert ?? _createAlertTheme(typography, spacing, border),
  snackbar: override?.snackbar ?? _createSnackbarTheme(colors, typography, spacing, border),
  bottomSheet: override?.bottomSheet ?? _createBottomSheetTheme(colors, border),
  modal: override?.modal ?? _createModalTheme(colors, typography, spacing, border),
  tooltip: override?.tooltip ?? _createTooltipTheme(colors, typography, spacing, border),
  loader: override?.loader ?? _createLoaderTheme(colors, typography, spacing),
  emptyState: override?.emptyState ?? _createEmptyStateTheme(colors, typography, spacing),
);

// Component-level constants — values with no general-purpose token family.
// Stroke widths, thumb padding, and scrim colour are component-specific;
// layout extents (minWidth/maxWidth) are overlay-sizing constraints.
const double _kStrokeThin = 1.0; // input/alert border default
const double _kStrokeFocused = 1.5; // input border focused
const double _kStrokeControl = 2.0; // checkbox / radio ring
const double _kStrokeProgress = 2.5; // circular progress arc
const double _kStrokeLoader = 3.0; // loader spinner
const double _kSwitchThumbPadding = 3.0; // inset between thumb and track edge
const double _kSnackbarMinWidth = 280.0;
const double _kSnackbarMaxWidth = 480.0;
const double _kModalMinWidth = 320.0;
const double _kModalMaxWidth = 520.0;
// 50% opaque black — standard Material scrim for bottom sheet and modal.
const Color _kBarrierColor = Color(0x80000000);

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
    sm: (square: _r(border.sm), pill: .circular(DievasRadiusSemantic.full)),
    md: (square: _r(border.md), pill: .circular(DievasRadiusSemantic.full)),
    lg: (square: _r(border.md), pill: .circular(DievasRadiusSemantic.full)),
  ),
  padding: (
    sm: .symmetric(horizontal: spacing.smPlus),
    md: .symmetric(horizontal: spacing.md),
    lg: .symmetric(horizontal: spacing.md),
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
    iconSize: (sm: DievasSizingPrimitives.s14, md: DievasSizingPrimitives.s16, lg: DievasSizingPrimitives.s18),
    iconSpacing: (sm: DievasSpacingPrimitives.s1, md: DievasSpacingPrimitives.s1, lg: 6.0),
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
  final transparent = colors.staticColours.staticTransparent;

  DievasIconButtonThemeData make(DievasIconButtonThemeStateStyle style) => DievasIconButtonThemeData(
    size: (sm: sizing.buttonHeightSm, md: sizing.buttonHeightMd, lg: sizing.buttonHeightLg),
    iconSize: (sm: sizing.iconSm, md: sizing.iconMd, lg: sizing.iconLg),
    radius: (sm: _r(border.sm), md: _r(border.md), lg: _r(border.md)),
    disabledOpacity: DievasOpacitySemantic.disabled,
    style: style,
  );

  return DievasIconButtonGroupThemeData(
    ghost: make((
      idle: DievasIconButtonThemeStyle(icon: iconColor, foreground: iconColor, background: transparent),
      focused: DievasIconButtonThemeStyle(icon: actionPrimary, foreground: actionPrimary, background: transparent),
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
  padding: .symmetric(horizontal: spacing.sm, vertical: spacing.xs / 2),
  iconSize: DievasSizingPrimitives.s10,
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
  padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
  iconSize: DievasSizingPrimitives.s14,
  iconSpacing: spacing.xs,
  removeIconSize: DievasSizingPrimitives.s14,
  removeIconSpacing: spacing.xs,
  minHeight: DievasSizingPrimitives.s28,
);

// LinearProgress
DievasLinearProgressThemeData _createLinearProgressTheme(DievasColourThemeData colors, DievasBorderThemeData border) =>
    DievasLinearProgressThemeData(
      height: DievasSizingPrimitives.s4,
      borderRadius: border.full,
      trackColor: colors.background.bgSubtle,
      colorPrimary: colors.action.actionPrimary,
      colorSuccess: colors.feedback.feedbackSuccess.icon,
      colorError: colors.feedback.feedbackError.icon,
    );

// CircularProgress
DievasCircularProgressThemeData _createCircularProgressTheme(DievasColourThemeData colors) =>
    DievasCircularProgressThemeData(
      sizeSm: DievasSizingPrimitives.s16,
      sizeMd: DievasSizingPrimitives.s24,
      sizeLg: DievasSizingPrimitives.s32,
      strokeWidth: _kStrokeProgress,
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
  size: DievasSizingPrimitives.s20,
  borderRadius: border.xs,
  strokeWidth: _kStrokeControl,
  colorChecked: colors.action.actionPrimary,
  colorUnchecked: colors.staticColours.staticTransparent,
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
  trackWidth: DievasSizingPrimitives.s44,
  trackHeight: DievasSizingPrimitives.s24,
  trackRadius: .circular(DievasRadiusSemantic.full),
  thumbSize: DievasSizingPrimitives.s18,
  thumbRadius: .circular(DievasRadiusSemantic.full),
  thumbPadding: _kSwitchThumbPadding,
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
  size: DievasSizingPrimitives.s20,
  strokeWidth: _kStrokeControl,
  dotSize: DievasSizingPrimitives.s8,
  colorSelected: colors.action.actionPrimary,
  colorUnselected: colors.staticColours.staticTransparent,
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
  strokeWidth: _kStrokeThin,
  strokeWidthFocused: _kStrokeFocused,
  bgColor: colors.input.inputBg,
  borderColor: colors.input.inputBorder,
  borderColorFocused: colors.input.inputBorderFocus,
  borderColorError: colors.input.inputBorderError,
  iconColor: colors.icon.iconSecondary,
  iconSize: DievasSizingPrimitives.s20,
  iconSpacing: spacing.xs,
  labelSpacing: spacing.xs,
  helperSpacing: spacing.xs,
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
  borderWidth: _kStrokeThin,
  dismissIconSize: DievasSizingPrimitives.s18,
);

// Snackbar
DievasSnackbarThemeData _createSnackbarTheme(
  DievasColourThemeData colors,
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
DievasBottomSheetThemeData _createBottomSheetTheme(DievasColourThemeData colors, DievasBorderThemeData border) =>
    DievasBottomSheetThemeData(
      borderRadius: .only(topLeft: _r(border.xl), topRight: _r(border.xl)),
      handleWidth: DievasSizingPrimitives.s40,
      handleHeight: DievasSizingPrimitives.s4,
      handleRadius: border.full,
      handleTopInset: DievasSpacingPrimitives.s3,
      backgroundColor: colors.background.bgElevated,
      barrierColor: _kBarrierColor,
      elevation: 8.0,
    );

// Modal
DievasModalThemeData _createModalTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasModalThemeData(
  titleStyle: typography.titleMd,
  bodyStyle: typography.bodyMd,
  backgroundColor: colors.background.bgElevated,
  barrierColor: _kBarrierColor,
  borderRadius: border.lg,
  padding: .all(spacing.lg),
  minWidth: _kModalMinWidth,
  maxWidth: _kModalMaxWidth,
  closeIconSize: DievasSizingPrimitives.s20,
  elevation: 16.0,
);

// Tooltip
DievasTooltipThemeData _createTooltipTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
  DievasBorderThemeData border,
) => DievasTooltipThemeData(
  textStyle: typography.labelXs.copyWith(color: colors.text.textInverse),
  backgroundColor: colors.background.bgOverlay,
  borderRadius: border.sm,
  padding: .symmetric(horizontal: spacing.smPlus, vertical: spacing.xs),
  verticalOffset: DievasSizingPrimitives.s20,
  waitDuration: const Duration(milliseconds: 500),
  showDuration: const Duration(seconds: 2),
);

// Loader
DievasLoaderThemeData _createLoaderTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
) => DievasLoaderThemeData(
  spinnerSizeSm: DievasSizingPrimitives.s20,
  spinnerSizeMd: DievasSizingPrimitives.s32,
  spinnerSizeLg: DievasSizingPrimitives.s48,
  strokeWidth: _kStrokeLoader,
  color: colors.action.actionPrimary,
  trackColor: colors.background.bgSubtle,
  labelStyle: typography.bodySm.copyWith(color: colors.text.textSecondary),
  labelSpacing: spacing.sm,
);

// EmptyState
DievasEmptyStateThemeData _createEmptyStateTheme(
  DievasColourThemeData colors,
  DievasTypographyThemeData typography,
  DievasSpacingThemeData spacing,
) => DievasEmptyStateThemeData(
  titleStyle: typography.headingSm,
  descriptionStyle: typography.bodyMd,
  iconSize: DievasSizingPrimitives.s48,
  iconColor: colors.icon.iconSecondary,
  titleSpacing: spacing.md,
  descriptionSpacing: spacing.sm,
  actionSpacing: spacing.lg,
  padding: .symmetric(horizontal: spacing.xl, vertical: spacing.x2l),
);
