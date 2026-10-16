<!-- meta.contentType: Reference -->

# Changelog

Changes to the Dievas token package, newest first.

## 1.0.1

### Breaking colour role names

- Name colours by element, variant or state, and property: `pageBackground`, `buttonPrimaryHoveredBackground`, and `inputFocusedBorder`.
- Replace ambiguous brand, background, surface, and action names; separate dialog, menu, tooltip, and other component backgrounds.
- Preserve existing colour values and extend palette application to the new component roles.
- Migrate Flutter themes, component consumers, examples, gallery labels, and tests together.
- See the token package’s README colour naming migration section for the replacement table and custom-theme migration requirements.

### Changed

- Add exact Moon colour primitives and hexadecimal alpha variants, backed by the recorded `moon_tokens` 0.0.6 reference.
- Map neutral light/dark semantics to the Moon reference: primary and secondary text and icons, base and subtle backgrounds, default borders, and overlay. Input text follows primary text; inverse text follows the opposite theme’s primary foreground.
- Change overlay alpha from `0x80` to `0x8F`. These semantic value changes alter rendered output.
- Keep existing brand palette, feedback, and component state mappings pending their own semantic migration. Full Moon parity is not yet established.
- Retune the size primitives to the 4pt / 8pt grid: font size follows the Moon type scale (`xs` through `fs72`), radius uses lowercase role names with `r<px>` for larger stops, opacity uses `o<percent>` on 4% and 8% steps, and sizing extends to 256px.

### Added

- Expose the full sizing primitive scale as `DievasSizingSemantic.height<px>` and `width<px>` from 4px through 256px, for boxes, constraints, and arbitrary dimensions.
- Expose the large radius stops `R28` through `R64` on `DievasRadiusSemantic`.
- Expose the full opacity percentage scale `O0` through `O100` on `DievasOpacitySemantic`.

### Documentation and checks

- Expand the README with token value shapes, palette selection, naming rules, and migration limits.
- Repair historical changelog formatting and clarify class-scoped size names, role suffixes, and the `XL2Plus` half step.
- Demonstrate semantic spacing and palette resolution in the example.
- Correct elevation dependency comments and remove misleading Moon cross references from none migrated colour roles.
- Resolve naming test paths independently of the working directory and check constant declarations.
- Add fixture tests for all 43 primitive colour references per theme and migrated neutral semantic roles.
- Add pixel value comments to the font weight, letter spacing, line height, and opacity primitives, and trim primitive docs to their shortest useful form.
- Compress every semantic token comment to a three line maximum and remove em dashes and compound word hyphens.
- Extend the naming convention check for the numeric `height`, `width`, and `R` size names.

## 1.0.0

This release unifies size names, adds brand palettes, and paints elevation shadows from ordered layer lists.

### Breaking size token naming

Size scales use uppercase class-scoped names or lowercase role names with uppercase size suffixes:

- Use `XS`, `SM`, `MD`, `LG`, `XL`, and `XL2` through `XL8` where supported. Half steps are `SMPlus`, `MDPlus`, `LGPlus`, `XLPlus`, and `XL2Plus`.
- Radius and font size primitives, plus spacing, radius, sizing, breakpoint, elevation, and typography semantics follow this convention.
- Class-scoped examples include `DievasSpacingSemantic.MD` and `DievasRadiusSemantic.SM`.
- Role examples include `buttonHeightMD` and `titleXS`; `titleXsm` becomes `titleXS`.
- Opacity roles (`oN`), z-index, easing, and animation intents are not size axes and retain their names.

### Breaking elevation shadow layers

Shadow layers become ordered lists per tier. Shadows are centred, so the former `upper` and `lower` names and their vertical offsets no longer apply:

- `DievasElevationShadow` becomes `({double blur, double tint})`. Each layer carries its own tint instead of `offsetY`.
- Remove `upperSM`, `lowerSM`, `upperMD`, `lowerMD`, `upperLG`, `lowerLG`, `upperXL`, and `lowerXL` from `DievasElevationShadowLayer`. Replace them with lists `SM`, `MD`, `LG`, and `XL`; `XS` also becomes a single-layer list.
- Add `DievasElevationSemantic.shadowColour` (`0xFF171717`), an alias for `DievasColourPrimitives.neutral900` used by every shadow layer.

### Breaking offset token removal

Remove `DievasOffsetSemantic`, `DievasOffsetPrimitives`, and their exports. Centred shadows no longer need offsets, and elevation was their only consumer.

### Breaking duplicate easing removal

Remove `DievasEasingPrimitives.emphasize` and `DievasEasingSemantic.emphasize`. Both duplicated `standard`.

### Breaking shadow opacity migration

Remove six aliases from `DievasOpacitySemantic`: `shadow1`, `shadow1Light`, `shadow2`, `shadow2Upper`, `shadow2Lower`, and `shadow2Heavy`. Shadow tints now live in elevation layer records beside their blurs; no `SHADOW_TINT_*` constants are exposed.

### New brand palettes

Add palette selection to the token layer:

- `DievasBrandPalette` holds an 11-tint ramp (`50` through `950`) and an `onBrand` contrast colour. `rolesForLight()` and `rolesForDark()` resolve the brand roles.
- `DievasBrandRoleColours` describes the resolved record.
- `DievasBrandPalettes` includes default `indigo`, plus `sky`, `green`, `violet`, `red`, `amber`, `ocean`, `forest`, `berry`, `dusk`, and `terracotta`. Parity tests verify that indigo reproduces the built-in brand semantics.

### Documentation

Document the size naming convention and the 4pt / 8pt grid rules.

## 0.0.3

- Add light and dark surface variants: `surfaceCanvas`, `surfaceCode`, `surfaceSidebar`, and `surfaceTableStriped`.
- Add `DievasElevationShadow` for shadow layer records.
- Fix the animation comment typo (`organiZed` to `organized`).
- Rename `touchTargetMin` to `touchMin` in sizing semantics.
- Correct the `titleXsm` comment from small to extra small.
- Add `DievasBreakpointPrimitives` and `DievasBreakpointSemantic`.
- Add `DievasZIndexSemantic`.
- Add `DievasEasingCurve`, `DievasEasingPrimitives`, and `DievasEasingSemantic`.

## 0.0.2

- Add `repository` and `homepage` package metadata.
- Add the `example/` directory.
- Add Dart documentation comments to uncovered API symbols.

## 0.0.1

Initial release:

- Primitive tokens: colours, typography, spacing, sizing, radius, elevation, opacity, duration, and offset
- Semantic tokens: light/dark colour schemes, typography roles, spacing/sizing scale, elevation layers, opacity levels, radius scale, offset patterns, and animation presets
