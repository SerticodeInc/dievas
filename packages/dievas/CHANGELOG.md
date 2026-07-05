# Change Log

## 0.0.5

- **New:** `DievasTag` — pill/rounded shape via `DievasTagBorderRadius` sealed class, per instance colour overrides (`backgroundColor`, `foregroundColor`, `borderColor`), and border width stable sizing across all styles.
- **Change:** All American "Color" naming renamed to British "Colour" — `DievasTheme.coloursOf()`, `context.colours`, `DievasThemeAspect.colours`, `DievasColourThemeData`.
- **API:** `DievasTagBorderRadius.pill` now uses `DievasRadiusSemantic.full` (9999.0) via `resolve()` instead of `containerHeight / 2`.
- **Fix:** `DievasTag` stable-width test targets Container descendants of DievasTag instead of global `find.byType(Container)`.
- **Internal:** Downgraded `widgetbook` to ^3.21.0, `meta` to `>=1.17.0 <2.0.0`, `test` to ^1.30.0 for Flutter SDK 3.41.9 compatibility.

## 0.0.4

- **New:** `DievasGlobalThemeData` now accepts an optional `DievasTypographyThemeData? typography` parameter for custom type scales (instead of hardcoded `DievasTypographySemantic` defaults).
- **Change:** `DievasGlobalThemeData` relaxed from `sealed` to `base` to allow consumer app extension.
- **New:** Private `_raw` constructor added — bypasses all derivation (typography, elevation, components, material) for use by `copyWith`.
- **Optimization:** `copyWith` now returns `this` immediately when nothing changed, and reuses pre computed `_material`, `_elevation`, and `_typography` when only components change. Only component derivation is re-run.
- **API:** `copyWith` now also accepts `DievasTypographyThemeData? typography` for dynamic type scale overrides.
- **Internal:** `DievasLightThemeData.copyWith` and `DievasDarkThemeData.copyWith` pass `typography` through to match the updated method signature.

## 0.0.3

- **Surface colours:** Added `SurfaceColours` value object with canvas, code, sidebar, and table striped tokens; wired into light/dark themes.
- **Breakpoints:** `DievasGridBreakpoint` now references `DievasBreakpointSemantic.*` instead of hardcoded pixel values.
- **Elevation:** `_buildDefaultElevation` uses `offsetY` from each `DievasElevationShadowLayer` rather than `Offset.zero`.
- **Easing curves:** Added 4 `Curve` fields to `DievasAnimationThemeData` (`easingStandard`, `easingEnter`, `easingExit`, `easingEmphasize`) resolved from `DievasEasingPrimitives`; replaced hardcoded `Curves.easeOutCubic`/`Curves.easeInOut` across 6 components.
- **Component quality:**
- Replaced all `AnimatedBuilder` usages with `AnimatedWidget` subclasses (switch, auth_code, loader).
- Removed bang (`!`) operators from component code.
- Replaced `_DigitBox._buildContent` builder function with a switch expression dispatching to private widget classes.
- Replaced hardcoded `Colors.black` in auth_code obscured dot with token aware fallback.
- **DievasTheme integration:** `animationOf()` accessor returning typed `DievasAnimationThemeData` for curve lookups in components.

## 0.0.2

- Added `repository:` and `homepage:` to pubspec.
- Added `example/` directory.
- Improved dart doc coverage.

## 0.0.1

- Initial release.
- Theme infrastructure: InheritedModel based theming with static sub system accessors, brand theme contract, and default light/dark themes.
- Components: buttons, form inputs, display components, feedback/overlay components, navigation/disclosure widgets.
- Semantic colour schemes, typography roles, spacing/sizing scale, elevation layers, and animation presets.
