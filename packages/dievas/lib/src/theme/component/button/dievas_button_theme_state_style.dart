import 'package:meta/meta.dart';

import 'dievas_button_theme_style.dart';

/// Maps interaction states to their corresponding style value.
///
/// `idle` — the default resting appearance.
/// `focused` — the pressed / active appearance.
@internal
typedef DievasButtonThemeStateStyle<T> = ({T idle, T focused});

/// State style for a [DievasFilledButtonThemeData].
@internal
typedef DievasFilledButtonThemeStateStyle
    = DievasButtonThemeStateStyle<DievasFilledButtonThemeStyle>;

/// State style for a [DievasOutlinedButtonThemeData].
@internal
typedef DievasOutlinedButtonThemeStateStyle
    = DievasButtonThemeStateStyle<DievasOutlinedButtonThemeStyle>;

/// State style for a [DievasTextButtonThemeData] — carries only a foreground [Color].
@internal
typedef DievasTextButtonThemeStateStyle
    = DievasButtonThemeStateStyle<DievasTextButtonThemeStyle>;

/// State style for a [DievasIconButtonThemeData].
@internal
typedef DievasIconButtonThemeStateStyle
    = DievasButtonThemeStateStyle<DievasIconButtonThemeStyle>;
