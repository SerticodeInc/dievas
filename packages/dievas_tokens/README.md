<!-- meta.contentType: Reference -->

# Dievas tokens

Use primitive values and semantic roles to build interfaces with the [Dievas design system](https://dievas.serticode.com). This package uses Dart only; Flutter adapters construct colours, text styles, and shadows from these tokens.

## Primitives and semantic roles

Primitives name fixed values. Semantic tokens name their purpose, such as primary text or card spacing. Prefer semantic roles when styling components.

Import the public library to access both layers:

```dart
import 'package:dievas_tokens/dievas_tokens.dart';

const purple = DievasColourPrimitives.royalPurple;
const foreground = DievasColourSemanticLight.textPrimary;
const background = DievasColourSemanticDark.pageBackground;
const padding = DievasSpacingSemantic.md;
const sectionGap = DievasSpacingSemantic.xl;
```

Colours are integers in `0xAARRGGBB` format: alpha, red, green, then blue. Spacing, sizing, radius, and breakpoints use logical pixels. Primitive alpha suffixes contain exact hexadecimal bytes: `blackAlpha8F` has alpha `0x8F`, not 60%.

## Colour role names

Name component colours as **element → variant or state → property**. Use `pageBackground`, `cardBackground`, `buttonPrimaryBackground`, `buttonPrimaryHoveredBackground`, `inputFocusedBorder`, and `switchOnTrack` to identify their use directly.

Dialogs, menus, bottom sheets, tooltips, drawers, and popovers have separate background tokens. Matching values do not make their purposes interchangeable. Each role can change independently through the Flutter theme.

`primary` identifies the selected palette. It is not a component background. A secondary button is a button variant using that same palette; it does not imply an independent secondary identity colour.

The [colour naming migration](#migrate-colour-names-to-explicit-component-roles) lists replacements for the former brand, background, surface, action, and feedback names. This is a breaking API change with unchanged colour values.

## Moon colour migration

The recorded reference is the published `moon_tokens` 0.0.6 package. The [reference fixture](test/fixtures/moon_colours_reference.json) contains its archive checksum, repository commit, and all 43 colour entries for each theme.

Primitives reproduce those recorded colours. The following semantic mappings now match the reference:

| Dievas role                               | Moon reference       | Light           | Dark             |
| ----------------------------------------- | -------------------- | --------------- | ---------------- |
| `textPrimary`, `iconPrimary`, `inputText` | Primary foreground   | `black`         | `white`          |
| `textSecondary`, `iconSecondary`          | Secondary foreground | `steelGrey`     | `steelGreyLight` |
| `pageBackground`                          | `goku`               | `white`         | `black`          |
| `cardBackground`                          | `gohan`              | `nearWhite`     | `charcoalDeep`   |
| `dividerColour`                           | `beerus`             | `coolGreyLight` | `charcoal`       |
| `modalBarrierBackground`                  | `zeno`               | `blackAlpha8F`  | `blackAlpha8F`   |
| `staticWhite`                             | `goten`              | `white`         | `white`          |
| `staticBlack`                             | `popo`               | `black`         | `black`          |

Inverse text uses the opposite theme’s primary foreground. Brand palettes, feedback colours, elevated surfaces, and interaction states retain their existing Dievas mappings. Full semantic parity, Flutter component rendering, and the deployed Moon playground remain unverified.

These neutral changes alter rendered colours compared with 1.0.0.

## Brand palettes

`DievasBrandPalette` contains an 11-tint ramp (`s50` through `s950`) and a `buttonPrimaryText` contrast colour. Its methods return `DievasBrandRoleColours` records for light or dark surfaces.

Select a palette and read its resolved roles:

```dart
final lightBrand = DievasBrandPalettes.sky.rolesForLight();
final darkBrand = DievasBrandPalettes.sky.rolesForDark();
final primaryAction = lightBrand.buttonPrimaryBackground;
final foregroundOnBrand = darkBrand.buttonPrimaryText;
```

The built in semantic classes use Moon Design’s Piccolo purple (`#5C33CF`) for primary brand roles in both themes, with translucent purple surfaces and derived hover and pressed shades. The optional `indigo` palette preserves the former colour family. Other palettes are `sky`, `green`, `violet`, `red`, `amber`, `ocean`, `forest`, `berry`, `dusk`, and `terracotta`. `DievasBrandPalettes.all` indexes them by name.

Resolving a palette returns values; it does not mutate the static semantic classes. Apply those values through your theme adapter. These ramps preserve Dievas behaviour and have not yet migrated to Moon’s brand roles.

## Typography and elevation

Semantic values include records and lists as well as scalar aliases. Typography records contain `fontSize`, `fontWeight`, `lineHeight`, `letterSpacing`, and `fontFamily`.

Read typography fields and ordered shadow layers:

```dart
const body = DievasTypographySemantic.bodyMd;
const fontSize = body.fontSize;
const lineHeight = body.lineHeight;
const shadowInk = DievasElevationSemantic.shadowColour;
const layers = DievasElevationShadowLayer.md;
```

Line height is a multiplier; letter spacing uses logical pixels. Each shadow layer contains `blur` and `tint`. Paint layers in list order, centred with no positional offset. Blur, colour, and opacity come from their respective primitive families.

## Motion and stacking order

Animation roles return `Duration` values. Easing returns cubic Bézier control-point records with `x1`, `y1`, `x2`, and `y2`. Z-index roles return integer stacking levels.

Use intent names for transitions and overlays:

```dart
const duration = DievasAnimationSemantic.standard;
const easing = DievasEasingSemantic.standard;
const modalLayer = DievasZIndexSemantic.modal;
```

## Naming contract

Size names depend on their scope:

- **Class-scoped scales**: `DievasSpacingSemantic.md`, `DievasRadiusSemantic.sm`, and `DievasElevationShadowLayer.xl`
- **Role names with size suffixes**: `buttonHeightMd`, `headingXl`, and `titleXs`
- **Size vocabulary**: `xs`, `sm`, `md`, `lg`, `xl`, and `xl2` through `xl5`, where supported
- **Half steps**: `smPlus`, `mdPlus`, `lgPlus`, `xlPlus`, and `xl2Plus`, where supported
- **Special scale names**: `none`, `full`, and `base`, where supported

Numeric primitives such as `s4`, opacity names such as `o13`, and intent names such as `touchMin`, `standard`, and `modal` are not size-axis names. Spacing uses a 4 logical pixel base grid; `md` is 16 and `xl` is 32.

## Migrate size token names

Size identifiers are lowercase as of the current release. Upgrade `dievas_tokens` and `dievas`, then either run the codemod or rename by hand.

```sh
dart run dievas_migrate            # preview
dart run dievas_migrate --write    # apply
```

[`dievas_migrate`](../dievas_migrate/README.md) reads analyzer errors, so it rewrites only the renamed token types and leaves unrelated enums such as `DievasButtonSize.MD` alone.

| Before | After |
| --- | --- |
| `DievasSpacingSemantic.MD`, `DievasRadiusSemantic.SM`, `DievasElevationSemantic.XL` | `DievasSpacingSemantic.md`, `DievasRadiusSemantic.sm`, `DievasElevationSemantic.xl` |
| `DievasRadiusSemantic.R28` through `.R64`, `.NONE`, `.FULL` | `DievasRadiusSemantic.r28` through `.r64`, `.none`, `.full` |
| `buttonHeightXS`, `displayLG`, `headingXL`, `titleXS`, `bodyMD`, `labelXS`, `codeMD` | `buttonHeightXs`, `displayLg`, `headingXl`, `titleXs`, `bodyMd`, `labelXs`, `codeMd` |
| `DievasBreakpointSemantic.XS`, the breakpoint primitives | `DievasBreakpointSemantic.xs`, the breakpoint primitives |
| Theme mirror fields such as `context.spacing.MD` and `DievasSpacingThemeData(MD: …)` | `context.spacing.md` and `DievasSpacingThemeData(md: …)` |

Colour roles, opacity, z-index, easing, animation intents, and `touchMin` are unchanged. Display strings are not rewritten; update any user-visible labels by hand.

## Verification

Run checks from the repository root:

```sh
dart analyze packages/dievas_tokens
dart test packages/dievas_tokens/test
dart run packages/dievas_tokens/example/dievas_tokens_example.dart
```

You can also run `dart test` inside the package. Tests cover primitive reference values, migrated neutral semantic roles, palette consistency, and size naming.

## Migrate colour names to explicit component roles

Colour roles now name the element, its variant or state, and the painted property. This API migration preserves the values from commit `94ea8cc`; it does not advance Moon colour parity or change sizing, spacing, radius, or opacity.

### Rename existing roles

Use these names in semantic classes, theme fields, and palette role records where exposed. `primary` remains palette identity; use component roles when painting controls.

| Previous name               | Replacement                          |
| --------------------------- | ------------------------------------ |
| `brand`                     | `primary`                            |
| `brandSubtle`               | `badgePrimaryTintedBackground`       |
| `onBrand`                   | `buttonPrimaryText`                  |
| `bgBase`                    | `pageBackground`                     |
| `bgSubtle`                  | `cardBackground`                     |
| `bgElevated`                | `dialogBackground`                   |
| `bgOverlay`                 | `modalBarrierBackground`             |
| `surfaceCanvas`             | `canvasBackground`                   |
| `surfaceCode`               | `codeBlockBackground`                |
| `surfaceSidebar`            | `sidebarBackground`                  |
| `surfaceTableStriped`       | `tableRowAlternateBackground`        |
| `actionPrimary`             | `buttonPrimaryBackground`            |
| `actionPrimaryHover`        | `buttonPrimaryHoveredBackground`     |
| `actionPrimaryActive`       | `buttonPrimaryPressedBackground`     |
| `actionPrimaryDisabled`     | `buttonPrimaryDisabledBackground`    |
| `actionSecondary`           | `buttonSecondaryBackground`          |
| `actionSecondaryHover`      | `buttonSecondaryHoveredBackground`   |
| `actionError`               | `buttonDestructiveBackground`        |
| `actionErrorHover`          | `buttonDestructiveHoveredBackground` |
| `actionSuccess`             | `buttonSuccessBackground`            |
| `inputBg`                   | `inputBackground`                    |
| `inputBorderFocus`          | `inputFocusedBorder`                 |
| `inputBorderError`          | `inputErrorBorder`                   |
| `inputBorderWarning`        | `inputWarningBorder`                 |
| `inputPlaceholder`          | `inputPlaceholderText`               |
| `switchTrackOn`             | `switchOnTrack`                      |
| `switchTrackOff`            | `switchOffTrack`                     |
| `switchThumbOn`             | `switchOnThumb`                      |
| `switchThumbOff`            | `switchOffThumb`                     |
| `borderDefault`             | `dividerColour`                      |
| `borderStrong`              | `inputActiveBorder`                  |
| `borderDisabled`            | `inputDisabledBorder`                |
| `borderFocus`               | `focusIndicatorColour`               |
| `borderBrand`               | `selectionBorder`                    |
| `iconOnBrand`               | `buttonPrimaryIcon`                  |
| `textOnBrand`               | `buttonPrimaryText`                  |
| `feedbackSuccessBackground` | `alertSuccessBackground`             |
| `feedbackSuccessBorder`     | `alertSuccessBorder`                 |
| `feedbackSuccessIcon`       | `alertSuccessIcon`                   |
| `feedbackSuccessText`       | `alertSuccessText`                   |
| `feedbackWarningBackground` | `alertWarningBackground`             |
| `feedbackWarningBorder`     | `alertWarningBorder`                 |
| `feedbackWarningIcon`       | `alertWarningIcon`                   |
| `feedbackWarningText`       | `alertWarningText`                   |
| `feedbackErrorBackground`   | `alertErrorBackground`               |
| `feedbackErrorBorder`       | `alertErrorBorder`                   |
| `feedbackErrorIcon`         | `alertErrorIcon`                     |
| `feedbackErrorText`         | `alertErrorText`                     |
| `feedbackInfoBackground`    | `alertInfoBackground`                |
| `feedbackInfoBorder`        | `alertInfoBorder`                    |
| `feedbackInfoIcon`          | `alertInfoIcon`                      |
| `feedbackInfoText`          | `alertInfoText`                      |

`onBrand` and `textOnBrand` become one semantic token, `buttonPrimaryText`. In Flutter, read `colours.text.buttonPrimaryText`; the old `colours.core.onBrand` field is removed. The palette constructor’s `onBrand` argument is now `buttonPrimaryText`.

### Split shared backgrounds by element

The old `bgElevated` value initializes `dialogBackground`, `bottomSheetBackground`, `tooltipBackground`, `drawerBackground`, `menuBackground`, `popoverBackground`, `snackbarBackground`, `tagBackground`, `badgeNeutralFilledBackground`, and `iconButtonFocusedBackground`.

The old `bgSubtle` value initializes `cardBackground`, `listItemSelectedBackground`, `badgeNeutralTintedBackground`, `iconButtonBackground`, `progressTrack`, and `segmentedControlBackground`.

If you construct `BackgroundColours` directly, supply each required field. If you previously overrode a shared colour through `copyWith`, override each affected element explicitly to retain that custom appearance. Changing a dialog background now leaves menus and tooltips unchanged.

### Split interactive colours by element

Checkboxes, radios, badges, progress indicators, sliders, input cursors, tab indicators, and segmented controls have explicit roles instead of reading a button background. Their initial values match the former shared action roles. Palette application updates the new palette-dependent roles together.

Custom `ActionColours` constructors must supply these additional component roles. The bundled example themes demonstrate complete constructors. `DievasCircularProgressStyle.onBrand` is renamed to `onPrimary` to describe its contrast against the selected palette.

### Migration Verification

The migration fixture freezes every semantic ARGB value from before the rename and assigns each split role its previous shared value. Tests check every declared colour token, independent dialog/menu overrides, and palette propagation to component fills and contrast colours.

## License

MIT
