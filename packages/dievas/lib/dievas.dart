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
library;

//  Scope
export 'src/scope/dievas_scope.dart';

//  Theme row barrels
export 'src/theme.dart';
export 'src/themes.dart';
