import 'package:equatable/equatable.dart';

import 'button/dievas_filled_button_theme_data.dart';
import 'button/dievas_icon_button_theme_data.dart';
import 'button/dievas_outlined_button_theme_data.dart';
import 'button/dievas_text_button_theme_data.dart';

/// The component-level theme sub-system for a Dievas theme.
///
/// Each component family has a typed group field here. The component mapper
/// (`themes.component.mapper.dart`) derives all values from the token sub-systems.
///
/// Adding a new component in M3/M4:
/// 1. Create `Dievas[Component]ThemeData` in `theme/component/[name]/`
/// 2. Add a field + `copyWith` parameter here
/// 3. Wire the factory call in `themes.component.mapper.dart`
final class DievasComponentThemeData extends Equatable {
  const DievasComponentThemeData({
    required this.filledButton,
    required this.outlinedButton,
    required this.textButton,
    required this.iconButton,
  });

  /// Theme data for [DievasFilledButton] — primary, secondary, destructive variants.
  final DievasFilledButtonGroupThemeData filledButton;

  /// Theme data for [DievasOutlinedButton] — primary, destructive variants.
  final DievasOutlinedButtonGroupThemeData outlinedButton;

  /// Theme data for [DievasTextButton] — primary, destructive variants.
  final DievasTextButtonGroupThemeData textButton;

  /// Theme data for [DievasIconButton] — ghost, tinted variants.
  final DievasIconButtonGroupThemeData iconButton;

  DievasComponentThemeData copyWith({
    DievasFilledButtonGroupThemeData? filledButton,
    DievasOutlinedButtonGroupThemeData? outlinedButton,
    DievasTextButtonGroupThemeData? textButton,
    DievasIconButtonGroupThemeData? iconButton,
  }) => DievasComponentThemeData(
    filledButton: filledButton ?? this.filledButton,
    outlinedButton: outlinedButton ?? this.outlinedButton,
    textButton: textButton ?? this.textButton,
    iconButton: iconButton ?? this.iconButton,
  );

  @override
  List<Object?> get props => [filledButton, outlinedButton, textButton, iconButton];
}
