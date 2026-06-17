/// Dievas design system — Flutter theme and component layer.
///
/// Import this library to access the full Dievas public API:
/// - [DievasScope] — entry-point widget; wraps your app
/// - [DievasTheme] — InheritedModel with static sub-system accessors
/// - [DievasThemeData] — the theme contract (implement to create brand themes)
/// - [DievasGlobalThemeData] — sealed abstract base (extend to create brand themes)
/// - [DievasLightThemeData] / [DievasDarkThemeData] — default themes
/// - All ThemeData sub-systems (colours, typography, spacing, etc.)
/// - [DievasGrid] / [DievasGridBreakpoint] — responsive grid
/// - Context extensions (`context.colors`, `context.typography`, ...)
/// - [DievasLocalizations] — l10n delegate and context extension
/// - Button components: [DievasFilledButton], [DievasOutlinedButton],
///   [DievasTextButton], [DievasIconButton]
/// - Form components: [DievasTextInput], [DievasTextArea], [DievasCheckbox],
///   [DievasSwitch], [DievasRadio]
/// - Display components: [DievasAvatar], [DievasBadge], [DievasTag],
///   [DievasDivider], [DievasIcon], [DievasLinearProgress], [DievasCircularProgress]
/// - Feedback components: [DievasAlert], [DievasBanner], [DievasSnackbar]
/// - Overlay components: [DievasBottomSheet], [showDievasBottomSheet],
///   [DievasModal], [showDievasModal], [DievasTooltip]
/// - Utility components: [DievasLoader], [DievasEmptyState]
library;

//  Localizations
export 'l10n/dievas_localizations.dart';

//  Scope
export 'src/scope/dievas_scope.dart';

//  Theme barrels
export 'src/theme.dart';
export 'src/themes.dart';

//  Components — Buttons
export 'src/components/buttons/dievas_filled_button.dart';
export 'src/components/buttons/dievas_icon_button.dart';
export 'src/components/buttons/dievas_outlined_button.dart';
export 'src/components/buttons/dievas_text_button.dart';
export 'src/components/buttons/button_types/dievas_button_icon_style_behavior.dart';
export 'src/components/buttons/button_types/dievas_button_shape.dart';
export 'src/components/buttons/button_types/dievas_button_size.dart';
export 'src/components/buttons/button_types/dievas_button_state.dart';
export 'src/components/buttons/button_types/dievas_button_style.dart';

//  Components — Form
export 'src/components/dropdown/dievas_dropdown.dart';

//  Components — Nav / Disclosure
export 'src/components/tab_bar/dievas_tab_bar.dart';
export 'src/components/auth_code/dievas_auth_code.dart';
export 'src/components/checkbox/dievas_checkbox.dart';
export 'src/components/radio/dievas_radio.dart';
export 'src/components/segmented_control/dievas_segmented_control.dart';
export 'src/components/switch/dievas_switch.dart';
export 'src/components/text_area/dievas_text_area.dart';
export 'src/components/text_input/dievas_text_input.dart';
export 'src/components/text_input_group/dievas_text_input_group.dart';
export 'src/components/search/dievas_search_with_list.dart';
export 'src/components/search/dievas_search_with_dropdown.dart';

//  Components — Display
export 'src/components/avatar/dievas_avatar.dart';
export 'src/components/badge/dievas_badge.dart';
export 'src/components/divider/dievas_divider.dart';
export 'src/components/dot_indicator/dievas_dot_indicator.dart';
export 'src/components/icon/dievas_icon.dart';
export 'src/components/progress/dievas_circular_progress.dart';
export 'src/components/progress/dievas_linear_progress.dart';
export 'src/components/tag/dievas_tag.dart';

//  Components — Feedback
export 'src/components/alert/dievas_alert.dart';
export 'src/components/banner/dievas_banner.dart';
export 'src/components/snackbar/dievas_snackbar.dart';

//  Components — Overlays
export 'src/components/bottom_sheet/dievas_bottom_sheet.dart';
export 'src/components/modal/dievas_modal.dart';
export 'src/components/tooltip/dievas_tooltip.dart';

//  Components — Navigation / Disclosure
export 'src/components/accordion/dievas_accordion.dart';
export 'src/components/breadcrumb/dievas_breadcrumb.dart';
export 'src/components/drawer/dievas_drawer.dart';
export 'src/components/menu_item/dievas_menu_item.dart';
export 'src/components/popover/dievas_popover.dart';

//  Components — Utility
export 'src/components/loader/dievas_loader.dart';
export 'src/components/empty_state/dievas_empty_state.dart';
