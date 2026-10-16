# Change Log

## Unreleased

### Breaking — component elevation fields are now shadow stacks

Every component that painted elevation through Flutter's `Material` / `Drawer` / `showModalBottomSheet` numeric `elevation` now paints the Dievas token shadow list directly, so overlays read as the same soft halo as the rest of the system and no longer pick up the M3 `surfaceTintColor` wash.

- Renamed and retyped `double elevation` → `List<BoxShadow> shadow` on `DievasModalThemeData`, `DievasDrawerThemeData`, `DievasBottomSheetThemeData`, and `DievasPopoverThemeData`.
- Renamed `DievasDropdownThemeData.overlayElevation` → `shadow`.
- Renamed `DievasAccordionThemeData.shadows` → `shadow`.
- Added `DievasSearchThemeData.shadow`; the search field's coloured focus glow is now the standard token shadow.
- `DievasPopoverThemeData.elevation` was previously ignored by the widget; the popover now reads `shadow` from its theme data.
- `DievasDrawerThemeData.borderRadius` is now applied to the drawer's `shape` (it was previously unused).

### Elevation

- Default shadows now use the soft `DievasElevationSemantic.shadowColour` (`0xFF171717`) ink instead of pure `staticBlack`, and render centred (no vertical offset) so depth reads as a soft halo rather than a drop shadow underneath. Reverses the `offsetY` behaviour introduced in 0.0.3 — the offset tokens have since been removed entirely.
- Shadow layers are built from the new ordered per-tier `DievasElevationShadowLayer` lists (`SM`, `MD`, `LG`, `XL`), replacing the `upper` / `lower` records and the separate `SHADOW_TINT_*` constants. See `dievas_tokens` for the breaking token details.

## 1.0.0

The naming unification release. Every size-axis token, enum value, and theme-value field now follows one law — `<base><UPPERCASE SIZE>` — and brand expression is driven by a single selectable palette.

### Breaking — size-token naming

All size-axis identifiers were renamed to `<base><SIZE>` (lowercase base, **UPPERCASE** size suffix, multiplier trailing):

- Suffixes: `XS`, `SM`, `MD`, `LG`, `XL`, `XL2`…`XL8`; half-steps `SMPlus`, `MDPlus`, `LGPlus`, `XLPlus`.
- Examples: `spacingMD`, `radiusLG`, `fontSizeXL`, `sizeXL2`, `breakpointSM`, `shadowLayer.upperMD`.
- Enum values follow the same law (`DievasButtonSize.MD`, `DievasGridBreakpoint.XL`).
- Component theme-value record fields follow the same law (`heightLG`, `paddingMD`).
- **Not** renamed (not size axes): opacity roles, z-index, easing, animation intents, `touchMin`.

### Breaking — removed duplicate easing

- `DievasAnimationThemeData.easingEmphasize` was an exact duplicate of `easingStandard` and has been removed.

### Breaking — shadow opacities moved to the elevation domain

The six shadow-opacity aliases leaked into the opacity API. They are removed from `DievasOpacityThemeData`:

- Removed: `shadow1`, `shadow1Light`, `shadow2`, `shadow2Upper`, `shadow2Lower`, `shadow2Heavy`.
- Added to `DievasElevationSemantic`: `SHADOW_TINT_SUBTLE` (`o8`), `SHADOW_TINT_SOFT` (`o13`), `SHADOW_TINT_MEDIUM` (`o20`), `SHADOW_TINT_STRONG` (`o25`).
- Default shadow layers now read their tint from the elevation domain.

### New — brand palette selection

- **New:** `applyBrandPalette(DievasColourThemeData, DievasBrandPalette)` re-resolves every brand-derived colour role (brand, brand-subtle, on-brand text/icon, primary and secondary actions, brand/focus borders, focus input border, switch-on track) while leaving neutral, text, surface, and feedback roles fixed.
- **New:** `DievasGlobalThemeData` accepts an optional `brandPalette` — the single brand selection point for consumer apps.
- The default `DievasBrandPalettes.indigo` reproduces the built-in light and dark reference themes exactly (guarded by a parity test).

### Docs

- Documented the size-token naming law and the 4pt / 8pt grid law.
- Corrected the colour taxonomy (`switchThumbOn` / `switchThumbOff`, added `SurfaceColours`).
- Documented brand palettes.

## 0.0.5

- **New:** `DievasTag` — pill/rounded shape via `DievasTagBorderRadius` sealed class, per instance colour overrides (`backgroundColor`, `foregroundColor`, `borderColor`), and border width stable sizing across all styles.
- **Change:** All American "Color" naming renamed to British "Colour": `DievasTheme.coloursOf()`, `context.colours`, `DievasThemeAspect.colours`, `DievasColourThemeData`.
- **API:** `DievasTagBorderRadius.pill` now uses `DievasRadiusSemantic.full` (9999.0) via `resolve()` instead of `containerHeight / 2`.
- **Fix:** `DievasTag` stable width test targets Container descendants of DievasTag instead of global `find.byType(Container)`.
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
