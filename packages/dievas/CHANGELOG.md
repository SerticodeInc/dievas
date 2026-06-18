# Change Log

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
