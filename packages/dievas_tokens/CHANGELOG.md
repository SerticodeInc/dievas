# Change Log

## 1.0.0

The naming unification release. Every size-axis token now follows one law — `<base><UPPERCASE SIZE>` — and brand palettes ship in the token layer.

### Breaking — size-token naming

All size-axis tokens were renamed to `<base><SIZE>` (lowercase base, **UPPERCASE** size suffix, multiplier trailing):

- Suffixes: `XS`, `SM`, `MD`, `LG`, `XL`, `XL2`…`XL8`; half-steps `SMPlus`, `MDPlus`, `LGPlus`, `XLPlus`.
- Radius and font-size primitives, and the spacing, radius, sizing, offset, breakpoint, elevation, and typography semantics all follow the law.
- Elevation shadow layers: `XS`, `upperSM`, `lowerSM`, `upperMD`, `lowerMD`, `upperLG`, `lowerLG`, `upperXL`, `lowerXL`.
- `titleXsm` → `titleXS`.
- **Not** renamed (not size axes): opacity roles (`oN`), z-index, easing, animation intents.

### Breaking — removed duplicate easing

- `DievasEasingPrimitives.emphasize` / `DievasEasingSemantic.emphasize` were exact duplicates of `standard` and have been removed.

### Breaking — shadow opacities moved to the elevation domain

- Removed the six shadow-opacity aliases from `DievasOpacitySemantic`: `shadow1`, `shadow1Light`, `shadow2`, `shadow2Upper`, `shadow2Lower`, `shadow2Heavy`.
- Added `SHADOW_TINT_SUBTLE` (`o8`), `SHADOW_TINT_SOFT` (`o13`), `SHADOW_TINT_MEDIUM` (`o20`), `SHADOW_TINT_STRONG` (`o25`) to `DievasElevationSemantic`.

### New — brand palettes

- **New:** `DievasBrandPalette` — a full 11-tint colour-family ramp (`50`→`950`) plus an `onBrand` contrast colour, with `rolesForLight()` / `rolesForDark()` resolving the brand-derived role set.
- **New:** `DievasBrandRoleColours` record type.
- **New:** `DievasBrandPalettes` — the default `indigo` plus `sky`, `green`, `violet`, `red`, `amber`, `ocean`, `forest`, `berry`, `dusk`, and `terracotta`. The default `indigo` reproduces the built-in reference semantics exactly (guarded by a parity test).

### Docs

- Documented the size-token naming law and the 4pt / 8pt grid law.

## 0.0.3

- Added surface variant colour tokens: `surfaceCanvas`, `surfaceCode`, `surfaceSidebar`, `surfaceTableStriped` (light + dark).
- Added `DievasElevationShadow` typedef for shadow layer records.
- Fixed typo in animation_semantic.dart (`organiZed` → `organized`).
- Renamed `touchTargetMin` → `touchMin` in sizing semantic.
- Fixed `titleXsm` doc comment (small → extra small).
- Added breakpoint primitives and semantic tokens (`DievasBreakpointPrimitives`, `DievasBreakpointSemantic`).
- Added z-index semantic tokens (`DievasZIndexSemantic`).
- Added easing primitives and semantic tokens (`DievasEasingCurve`, `DievasEasingPrimitives`, `DievasEasingSemantic`).

## 0.0.2

- Added `repository:` and `homepage:` to pubspec.
- Added `example/` directory.
- Added dart doc comments to uncovered API symbols.

## 0.0.1

- Initial release.
- Primitive tokens: colours, typography, spacing, sizing, radius, elevation, opacity, duration, offset.
- Semantic tokens: light/dark colour schemes, typography roles, spacing/sizing scale, elevation layers, opacity levels, radius scale, offset patterns, animation presets.
