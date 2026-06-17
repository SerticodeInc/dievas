import 'package:equatable/equatable.dart';

import 'accordion/dievas_accordion_theme_data.dart';
import 'auth_code/dievas_auth_code_theme_data.dart';
import 'alert/dievas_alert_theme_data.dart';
import 'avatar/dievas_avatar_theme_data.dart';
import 'badge/dievas_badge_theme_data.dart';
import 'breadcrumb/dievas_breadcrumb_theme_data.dart';
import 'bottom_sheet/dievas_bottom_sheet_theme_data.dart';
import 'button/dievas_filled_button_theme_data.dart';
import 'button/dievas_icon_button_theme_data.dart';
import 'button/dievas_outlined_button_theme_data.dart';
import 'button/dievas_text_button_theme_data.dart';
import 'checkbox/dievas_checkbox_theme_data.dart';
import 'circular_progress/dievas_circular_progress_theme_data.dart';
import 'dot_indicator/dievas_dot_indicator_theme_data.dart';
import 'drawer/dievas_drawer_theme_data.dart';
import 'dropdown/dievas_dropdown_theme_data.dart';
import 'empty_state/dievas_empty_state_theme_data.dart';
import 'linear_progress/dievas_linear_progress_theme_data.dart';
import 'loader/dievas_loader_theme_data.dart';
import 'menu_item/dievas_menu_item_theme_data.dart';
import 'modal/dievas_modal_theme_data.dart';
import 'popover/dievas_popover_theme_data.dart';
import 'radio/dievas_radio_theme_data.dart';
import 'search/dievas_search_theme_data.dart';
import 'segmented_control/dievas_segmented_control_theme_data.dart';
import 'snackbar/dievas_snackbar_theme_data.dart';
import 'switch/dievas_switch_theme_data.dart';
import 'tab_bar/dievas_tab_bar_theme_data.dart';
import 'tag/dievas_tag_theme_data.dart';
import 'text_input/dievas_text_input_theme_data.dart';
import 'text_input_group/dievas_text_input_group_theme_data.dart';
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
    required this.breadcrumb,
    required this.avatar,
    required this.tag,
    required this.linearProgress,
    required this.circularProgress,
    required this.checkbox,
    required this.toggle,
    required this.radio,
    required this.textInput,
    required this.textInputGroup,
    required this.alert,
    required this.snackbar,
    required this.bottomSheet,
    required this.modal,
    required this.tooltip,
    required this.loader,
    required this.menuItem,
    required this.emptyState,
    required this.authCode,
    required this.accordion,
    required this.dotIndicator,
    required this.drawer,
    required this.dropdown,
    required this.search,
    required this.segmentedControl,
    required this.tabBar,
    required this.popover,
  });

  /// Theme data for [DievasAuthCode].
  final DievasAuthCodeThemeData authCode;

  /// Theme data for [DievasSearchWithList] and [DievasSearchWithDropdown].
  final DievasSearchThemeData search;

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

  /// Theme data for [DievasBreadcrumb].
  final DievasBreadcrumbThemeData breadcrumb;

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

  /// Theme data for [DievasTextInputGroup].
  final DievasTextInputGroupThemeData textInputGroup;

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

  /// Theme data for [DievasMenuItem].
  final DievasMenuItemThemeData menuItem;

  /// Theme data for [DievasEmptyState].
  final DievasEmptyStateThemeData emptyState;

  /// Theme data for [DievasAccordion].
  final DievasAccordionThemeData accordion;

  /// Theme data for [DievasDotIndicator].
  final DievasDotIndicatorThemeData dotIndicator;

  /// Theme data for [DievasDrawer].
  final DievasDrawerThemeData drawer;

  /// Theme data for [DievasDropdown].
  final DievasDropdownThemeData dropdown;

  /// Theme data for [DievasSegmentedControl].
  final DievasSegmentedControlThemeData segmentedControl;

  /// Theme data for [DievasTabBar].
  final DievasTabBarThemeData tabBar;

  /// Theme data for [DievasPopover].
  final DievasPopoverThemeData popover;

  DievasComponentThemeData copyWith({
    DievasFilledButtonGroupThemeData? filledButton,
    DievasOutlinedButtonGroupThemeData? outlinedButton,
    DievasTextButtonGroupThemeData? textButton,
    DievasIconButtonGroupThemeData? iconButton,
    DievasBadgeThemeData? badge,
    DievasBreadcrumbThemeData? breadcrumb,
    DievasAvatarThemeData? avatar,
    DievasTagThemeData? tag,
    DievasLinearProgressThemeData? linearProgress,
    DievasCircularProgressThemeData? circularProgress,
    DievasCheckboxThemeData? checkbox,
    DievasSwitchThemeData? toggle,
    DievasRadioThemeData? radio,
    DievasTextInputThemeData? textInput,
    DievasTextInputGroupThemeData? textInputGroup,
    DievasAlertThemeData? alert,
    DievasSnackbarThemeData? snackbar,
    DievasBottomSheetThemeData? bottomSheet,
    DievasModalThemeData? modal,
    DievasTooltipThemeData? tooltip,
    DievasLoaderThemeData? loader,
    DievasMenuItemThemeData? menuItem,
    DievasEmptyStateThemeData? emptyState,
    DievasAuthCodeThemeData? authCode,
    DievasAccordionThemeData? accordion,
    DievasDotIndicatorThemeData? dotIndicator,
    DievasDrawerThemeData? drawer,
    DievasDropdownThemeData? dropdown,
    DievasSearchThemeData? search,
    DievasSegmentedControlThemeData? segmentedControl,
    DievasTabBarThemeData? tabBar,
    DievasPopoverThemeData? popover,
  }) => DievasComponentThemeData(
    filledButton: filledButton ?? this.filledButton,
    outlinedButton: outlinedButton ?? this.outlinedButton,
    textButton: textButton ?? this.textButton,
    iconButton: iconButton ?? this.iconButton,
    badge: badge ?? this.badge,
    breadcrumb: breadcrumb ?? this.breadcrumb,
    avatar: avatar ?? this.avatar,
    tag: tag ?? this.tag,
    linearProgress: linearProgress ?? this.linearProgress,
    circularProgress: circularProgress ?? this.circularProgress,
    checkbox: checkbox ?? this.checkbox,
    toggle: toggle ?? this.toggle,
    radio: radio ?? this.radio,
    textInput: textInput ?? this.textInput,
    textInputGroup: textInputGroup ?? this.textInputGroup,
    alert: alert ?? this.alert,
    snackbar: snackbar ?? this.snackbar,
    bottomSheet: bottomSheet ?? this.bottomSheet,
    modal: modal ?? this.modal,
    tooltip: tooltip ?? this.tooltip,
    loader: loader ?? this.loader,
    menuItem: menuItem ?? this.menuItem,
    emptyState: emptyState ?? this.emptyState,
    authCode: authCode ?? this.authCode,
    accordion: accordion ?? this.accordion,
    dotIndicator: dotIndicator ?? this.dotIndicator,
    drawer: drawer ?? this.drawer,
    dropdown: dropdown ?? this.dropdown,
    search: search ?? this.search,
    segmentedControl: segmentedControl ?? this.segmentedControl,
    tabBar: tabBar ?? this.tabBar,
    popover: popover ?? this.popover,
  );

  @override
  List<Object?> get props => [
    filledButton,
    outlinedButton,
    textButton,
    iconButton,
    badge,
    breadcrumb,
    avatar,
    tag,
    linearProgress,
    circularProgress,
    checkbox,
    toggle,
    radio,
    textInput,
    textInputGroup,
    alert,
    snackbar,
    bottomSheet,
    modal,
    tooltip,
    loader,
    menuItem,
    emptyState,
    authCode,
    accordion,
    dotIndicator,
    drawer,
    dropdown,
    search,
    segmentedControl,
    tabBar,
    popover,
  ];
}
