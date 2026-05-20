import 'package:equatable/equatable.dart';

import 'alert/dievas_alert_theme_data.dart';
import 'avatar/dievas_avatar_theme_data.dart';
import 'badge/dievas_badge_theme_data.dart';
import 'bottom_sheet/dievas_bottom_sheet_theme_data.dart';
import 'button/dievas_filled_button_theme_data.dart';
import 'button/dievas_icon_button_theme_data.dart';
import 'button/dievas_outlined_button_theme_data.dart';
import 'button/dievas_text_button_theme_data.dart';
import 'checkbox/dievas_checkbox_theme_data.dart';
import 'circular_progress/dievas_circular_progress_theme_data.dart';
import 'empty_state/dievas_empty_state_theme_data.dart';
import 'linear_progress/dievas_linear_progress_theme_data.dart';
import 'loader/dievas_loader_theme_data.dart';
import 'modal/dievas_modal_theme_data.dart';
import 'radio/dievas_radio_theme_data.dart';
import 'snackbar/dievas_snackbar_theme_data.dart';
import 'switch/dievas_switch_theme_data.dart';
import 'tag/dievas_tag_theme_data.dart';
import 'text_input/dievas_text_input_theme_data.dart';
import 'tooltip/dievas_tooltip_theme_data.dart';

/// The component-level theme sub-system for a Dievas theme.
///
/// Each component family has a typed group field here. The component mapper
/// (`themes.component.mapper.dart`) derives all values from the token sub-systems.
///
/// Adding a new component in M4+:
/// 1. Create `Dievas[Component]ThemeData` in `theme/component/[name]/`
/// 2. Add a field + `copyWith` parameter here
/// 3. Wire the factory call in `themes.component.mapper.dart`
final class DievasComponentThemeData extends Equatable {
  const DievasComponentThemeData({
    required this.filledButton,
    required this.outlinedButton,
    required this.textButton,
    required this.iconButton,
    required this.badge,
    required this.avatar,
    required this.tag,
    required this.linearProgress,
    required this.circularProgress,
    required this.checkbox,
    required this.toggle,
    required this.radio,
    required this.textInput,
    required this.alert,
    required this.snackbar,
    required this.bottomSheet,
    required this.modal,
    required this.tooltip,
    required this.loader,
    required this.emptyState,
  });

  /// Theme data for [DievasFilledButton] — primary, secondary, destructive variants.
  final DievasFilledButtonGroupThemeData filledButton;

  /// Theme data for [DievasOutlinedButton] — primary, destructive variants.
  final DievasOutlinedButtonGroupThemeData outlinedButton;

  /// Theme data for [DievasTextButton] — primary, destructive variants.
  final DievasTextButtonGroupThemeData textButton;

  /// Theme data for [DievasIconButton] — ghost, tinted variants.
  final DievasIconButtonGroupThemeData iconButton;

  /// Theme data for [DievasBadge] — layout and typography only (colour is dynamic).
  final DievasBadgeThemeData badge;

  /// Theme data for [DievasAvatar] — sizes, radii, fallback colours.
  final DievasAvatarThemeData avatar;

  /// Theme data for [DievasTag] — layout and typography only (colour is dynamic).
  final DievasTagThemeData tag;

  /// Theme data for [DievasLinearProgress].
  final DievasLinearProgressThemeData linearProgress;

  /// Theme data for [DievasCircularProgress].
  final DievasCircularProgressThemeData circularProgress;

  /// Theme data for [DievasCheckbox].
  final DievasCheckboxThemeData checkbox;

  /// Theme data for [DievasSwitch].
  ///
  /// Named `toggle` to avoid conflict with the Dart keyword `switch`.
  final DievasSwitchThemeData toggle;

  /// Theme data for [DievasRadio].
  final DievasRadioThemeData radio;

  /// Theme data for [DievasTextInput] and [DievasTextArea].
  final DievasTextInputThemeData textInput;

  /// Theme data for [DievasAlert].
  final DievasAlertThemeData alert;

  /// Theme data for [DievasSnackbar].
  final DievasSnackbarThemeData snackbar;

  /// Theme data for [DievasBottomSheet] and [showDievasBottomSheet].
  final DievasBottomSheetThemeData bottomSheet;

  /// Theme data for [DievasModal] and [showDievasModal].
  final DievasModalThemeData modal;

  /// Theme data for [DievasTooltip].
  final DievasTooltipThemeData tooltip;

  /// Theme data for [DievasLoader].
  final DievasLoaderThemeData loader;

  /// Theme data for [DievasEmptyState].
  final DievasEmptyStateThemeData emptyState;

  DievasComponentThemeData copyWith({
    DievasFilledButtonGroupThemeData? filledButton,
    DievasOutlinedButtonGroupThemeData? outlinedButton,
    DievasTextButtonGroupThemeData? textButton,
    DievasIconButtonGroupThemeData? iconButton,
    DievasBadgeThemeData? badge,
    DievasAvatarThemeData? avatar,
    DievasTagThemeData? tag,
    DievasLinearProgressThemeData? linearProgress,
    DievasCircularProgressThemeData? circularProgress,
    DievasCheckboxThemeData? checkbox,
    DievasSwitchThemeData? toggle,
    DievasRadioThemeData? radio,
    DievasTextInputThemeData? textInput,
    DievasAlertThemeData? alert,
    DievasSnackbarThemeData? snackbar,
    DievasBottomSheetThemeData? bottomSheet,
    DievasModalThemeData? modal,
    DievasTooltipThemeData? tooltip,
    DievasLoaderThemeData? loader,
    DievasEmptyStateThemeData? emptyState,
  }) => DievasComponentThemeData(
    filledButton: filledButton ?? this.filledButton,
    outlinedButton: outlinedButton ?? this.outlinedButton,
    textButton: textButton ?? this.textButton,
    iconButton: iconButton ?? this.iconButton,
    badge: badge ?? this.badge,
    avatar: avatar ?? this.avatar,
    tag: tag ?? this.tag,
    linearProgress: linearProgress ?? this.linearProgress,
    circularProgress: circularProgress ?? this.circularProgress,
    checkbox: checkbox ?? this.checkbox,
    toggle: toggle ?? this.toggle,
    radio: radio ?? this.radio,
    textInput: textInput ?? this.textInput,
    alert: alert ?? this.alert,
    snackbar: snackbar ?? this.snackbar,
    bottomSheet: bottomSheet ?? this.bottomSheet,
    modal: modal ?? this.modal,
    tooltip: tooltip ?? this.tooltip,
    loader: loader ?? this.loader,
    emptyState: emptyState ?? this.emptyState,
  );

  @override
  List<Object?> get props => [
    filledButton,
    outlinedButton,
    textButton,
    iconButton,
    badge,
    avatar,
    tag,
    linearProgress,
    circularProgress,
    checkbox,
    toggle,
    radio,
    textInput,
    alert,
    snackbar,
    bottomSheet,
    modal,
    tooltip,
    loader,
    emptyState,
  ];
}
