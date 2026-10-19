# Change Log

## Unreleased

- Use Moon Design Piccolo purple (`#5C33CF`) for the default primary brand in both themes. Update focus, selection, active controls, cursors, and tinted brand surfaces together; derive hover and pressed shades from Piccolo. Explicit palette overrides remain available.

### Buttons

- Fade and scale between normal content and loading on all three standard variants. `animateLoading` defaults to true; false or reduced motion switches instantly. Preserve content size and semantics through both directions and rapid reversals. Widgetbook exposes an Animate loading transition toggle.
- Use the shared DievasLoader inside buttons. Replace the fixed rotating sweep with a rounded arc whose head grows and tail catches up while rotating, following MoonCircularLoader. Default the loader track to transparent and its timing to the loader motion token; add optional diameter, stroke width, and animation-duration overrides. Reduced motion displays a static arc.

- Consolidate button sizes, states, styles, and icon behaviour in one types file. Keep public package exports and variant style exports available. Move the icon-button colour resolver and state-controller lifecycle into the icon button; remove unused switcher and loader/press mixin files.

- Add border visibility, radius overrides, full width, long-press actions, semantic labels, and optional pulse/jiggle press effects to filled, outlined, and text buttons. Keep custom child and shape APIs; the gallery focuses on standard button content.
- Share keyboard/pointer handling and loading layout across the three variants. Remove their Material ink surfaces and IconTheme wrappers; resolve standard icon slots through DievasIcon. Loading keeps the content footprint and accessible label; pulse and loader animations respect reduced motion.
- Wrap long labels in narrow layouts and retain natural width in unbounded parents. Support icon-only content and long-press-only buttons.
- Default outlined buttons to primary foregrounds with neutral borders, and text buttons to secondary foregrounds. Destructive styles and explicit theme/colour overrides remain available. Text buttons now use the size variant's minimum height and padding instead of a content-only hit area.
- Add grouped Widgetbook controls for all reference options, independent semantic colour overrides, zero-radius overrides, RTL, loading/disabled states, and working tap/long-press feedback. Add a standard three-variant showcase; omit custom-shape examples.

### Breadcrumb

- Add optional middle item collapse with a menu for hidden pages, customizable overflow content, and a localized tooltip.
- Add item/current_item/hover/divider colour overrides, gap, and leading/trailing item slots. Preserve the existing complete trail default and navigation API.
- Support keyboard navigation, selected page semantics, and horizontal scrolling on narrow screens. Disable home navigation when the trail is disabled.
- Expand Widgetbook with reference controls, semantic colour selectors, working navigation/reset, and a custom overflow example. Fix item count indexing.

### Avatar

- Add a foreground content slot over image backgrounds; show initials or the placeholder while images load or fail. Preserve complete Unicode graphemes when shortening initials.
- Add a status badge with colour, size, transparent margin, semantic label, and four corners that mirror in RTL layouts.
- Add XL2 (80 dp), custom width/height, radius, text style, and border width. Existing XS–XL dimensions remain unchanged; avatar theme additions are optional for existing custom constructors.
- Change the default shape to rounded square and default text/icon colours to primary foregrounds on the page surface. Pass `shape: .circle` to retain the previous default shape.
- Paint borders above images and content. Expand Widgetbook with grouped token overrides, image/failure examples, content overlays, and badge controls.

### AuthCode

- Add box, circle, and underline shapes, horizontal alignment, radius and gap overrides, and independent selected, filled, inactive, error, text, and cursor colours.
- Add an explicit error state and optional shake animation, including when shake is enabled during an existing error. Respect reduced motion.
- Add optional timed peeking of the newest typed digit; keep multi digit pasted codes masked.
- Add `onChanged`, distinct completed edit callbacks, OTP autofill, accessible input labels, and safe truncation when code length changes. Adapt fields and gaps to narrow layouts.
- Limit code length to 7 digits. Replace the Widgetbook decimal slider with 4, 5, 6, and 7 digit presets.
- Expand Widgetbook with grouped semantic colour overrides, disabled/active/error examples, and an error shake replay button.

### Bottom sheet

- Use a circular, tinted `DievasIconButton` at MD size for the close action, inheriting Dievas button and icon sizing.

- Remove bottom-sheet shadows and the `shadow` option from the modal helper and bottom-sheet theme. The animated barrier provides separation.

- Disable automatic scrollbars inside bottom sheets while preserving scrolling and drag-to-resize.

- Center header titles independently of the trailing action; accept a custom `trailing` widget in place of the close button.
- Align Widgetbook header and item insets with the component default, and remove item hover highlights. Add a custom trailing-action control.

- Header separators use `DievasDivider` so divider colour and thickness follow the active Dievas theme.

- Give the close action a filled circular background. Share horizontal padding between header, body tiles, and footer; expose the padding and close background in Widgetbook.
- Add upward resizing from the initial height to a configurable safe-viewport cap (90% by default), shrink back toward the initial height before dismissal, and hand scrolling to the list at the cap. Resizing can be disabled independently.
- Add `fitContent` to wrap short content instead of reserving a fixed initial height; use shrink-wrapped lazy lists for content measurement. Widgetbook includes a short-content use case and item-count control.

- Replace the static Widgetbook sample with a real modal launcher, selectable scrolling rows, close/result feedback, and a keyboard-form example inside the device preview.
- Add background/barrier colour, radius, shadow, pixel/fractional height, expanded layout, safe-area, root-navigator, close-threshold, and transition overrides. Preserve the natural-content `isScrollControlled` height limit when no explicit height is supplied.
- Coordinate downward drags at the top of scrolling content with sheet dismissal; support threshold release, fast flings, snap-back, and disabling drag independently of barrier/Escape dismissal.
- Add fixed header/footer slots, optional title, keyboard-accessible close action, header divider, body padding, and handle-colour overrides. Return selected results through `closeDievasBottomSheet`.
- Preserve caller-local Dievas/Material themes across route boundaries, clip content to the surface, avoid the keyboard, and respect reduced motion. Extend the theme with optional motion/threshold/handle defaults and `copyWith`.

## 1.0.1

### Breaking colour role names

- Name colours by element, variant or state, and property: `pageBackground`, `buttonPrimaryHoveredBackground`, and `inputFocusedBorder`.
- Replace ambiguous brand, background, surface, and action names; separate dialog, menu, tooltip, and other component backgrounds.
- Preserve existing colour values and extend palette application to the new component roles.
- Migrate Flutter themes, component consumers, examples, gallery labels, and tests together.
- See the token package’s README colour naming migration section for the replacement table and custom-theme migration requirements.

### Accordion

- Add grouped and ungrouped layouts, small/medium/large sizes, and optional borders, dividers, and token shadows.
- Add independent collapsed and expanded text, icon, and background colours; content, border, and divider colours; radius, padding, height, spacing, alignment, and motion overrides.
- Add controlled expansion through `expandedIndices`, expansion callbacks, content state preservation, and focus and semantic options.
- Fix the initially expanded chevron rotation and disable header interaction for disabled items.

### Alerts

- Add base, filled, and outlined variants, with optional leading, label, content, and trailing widget slots.
- Add independent slot and surface colours, border visibility, radius, padding, and semantic labels.
- Add disabled trailing actions and keyboard-accessible dismiss buttons while retaining `leadingIcon` and `onDismiss`.
- Default filled alerts to no border; outlined alerts show a border unless explicitly overridden.

### Theme token access

- Align the Flutter theme layer with `dievas_tokens` 1.0.1.
- Expose all 50 semantic height and width values through `context.sizing`, all 18 opacity percentage values through `context.opacity`, and large radii `R28` through `R64` through `context.border`.
- Include the added values in constructor defaults, `copyWith`, and equality.
- Resolve default animation easing curves from semantic tokens while preserving const construction and custom curve overrides.
- Add `DievasZIndexThemeData`, `DievasTheme.zIndexOf`, and `context.zIndex`, with aspect-scoped rebuilds and preservation through theme copies. Custom implementations of `DievasThemeData` must provide `zIndex`.

### Widgetbook

- Add interactive accordion and alert examples, including controlled expansion, form state preservation, alert visibility, dismissal, and restoration.
- Replace colour pickers with curated Dievas semantic token selectors that follow the active light or dark theme.
- Group accordion and alert controls into sections, keeping visibility toggles, overrides, and their values together.

## 1.0.0

The naming unification release. Every size axis token, enum value, and theme value field now follows one law - `<base><UPPERCASE SIZE>` - brand expression is driven by a single selectable palette, and component elevation now paints the Dievas token shadow stacks directly.

### Breaking component elevation fields are now shadow stacks

Every component that painted elevation through Flutter's `Material` / `Drawer` / `showModalBottomSheet` numeric `elevation` now paints the Dievas token shadow list directly, so overlays read as the same soft halo as the rest of the system and no longer pick up the M3 `surfaceTintColor` wash. - Renamed and retyped `double elevation` → `List<BoxShadow> shadow` on `DievasModalThemeData`, `DievasDrawerThemeData`, `DievasBottomSheetThemeData`, and `DievasPopoverThemeData`. - Renamed `DievasDropdownThemeData.overlayElevation` → `shadow`. - Removed the shadow from the accordion entirely - `DievasAccordionThemeData` no longer exposes a `shadow` field and the panel paints no elevation. - Added `DievasSearchThemeData.shadow`; the search field's coloured focus glow is now the standard token shadow. - `DievasPopoverThemeData.elevation` was previously ignored by the widget; the popover now reads `shadow` from its theme data. - `DievasDrawerThemeData.borderRadius` is now applied to the drawer's `shape` (it was previously unused).

### Breaking size token naming

All size axis identifiers were renamed to `<base><SIZE>` (lowercase base, **UPPERCASE** size suffix, multiplier trailing): - Suffixes: `XS`, `SM`, `MD`, `LG`, `XL`, `XL2`…`XL8`; half steps `SMPlus`, `MDPlus`, `LGPlus`, `XLPlus`. - Examples: `spacingMD`, `radiusLG`, `fontSizeXL`, `sizeXL2`, `breakpointSM`. - Enum values follow the same law (`DievasButtonSize.MD`, `DievasGridBreakpoint.XL`). - Component theme value record fields follow the same law (`heightLG`, `paddingMD`). - **Not** renamed (not size axes): opacity roles, z index, easing, animation intents, `touchMin`.

### Breaking removed duplicate easing - `DievasAnimationThemeData.easingEmphasize` was an exact duplicate of `easingStandard` and has been removed

### Breaking shadow opacities moved to the elevation domain

The six shadow opacity aliases leaked into the opacity API. They are removed from `DievasOpacityThemeData`: - Removed: `shadow1`, `shadow1Light`, `shadow2`, `shadow2Upper`, `shadow2Lower`, `shadow2Heavy`. - The shadow tints now live inside the elevation layer records (see `dievas_tokens`), so no `SHADOW_TINT_*` constants are exposed.

### New brand palette selection - **New:** `applyBrandPalette(DievasColourThemeData, DievasBrandPalette)` re resolves every brand derived colour role (brand, brand subtle, on brand text/icon, primary and secondary actions, brand/focus borders, focus input border, switch on track) while leaving neutral, text, surface, and feedback roles fixed. - **New:** `DievasGlobalThemeData` accepts an optional `brandPalette` - the single brand selection point for consumer apps. - The default `DievasBrandPalettes.indigo` reproduces the built in light and dark reference themes exactly (guarded by a parity test)

### Elevation Default shadows now use the soft `DievasElevationSemantic.shadowColour` (`0xFF171717`) ink instead of pure `staticBlack`, and render centred (no vertical offset) so depth reads as a soft halo rather than a drop shadow underneath. Reverses the `offsetY` behaviour introduced in 0.0.3 the offset tokens have since been removed entirely. - Shadow layers are built from the new ordered per tier `DievasElevationShadowLayer` lists (`SM`, `MD`, `LG`, `XL`), replacing the `upper` / `lower` records and the separate `SHADOW_TINT_*` constants. See `dievas_tokens` for the breaking token details

### Changed - `DievasBadge` uses roomier internal padding (`SMPlus` horizontal, `XS` vertical) so labels no longer sit cramped against the pill edge

### Fixed - `DievasAlert` no longer stretches to fill a loosely constrained parent. Its text column is now shrink wrapped on the main axis, so the surface sizes to its content instead of expanding to the full available height (visible as a page filling alert in the widget book canvas). - `DievasTabBar` now uses a single underline indicator that slides between tabs instead of a per tab bottom border that popped in and out, so changing the selected tab animates smoothly

### Docs Documented the size token naming law and the 4pt / 8pt grid law. - Corrected the colour taxonomy (`switchThumbOn` / `switchThumbOff`, added `SurfaceColours`). - Documented brand palettes

## 0.0.5 - **New:** `DievasTag` - pill/rounded shape via `DievasTagBorderRadius` sealed class, per instance colour overrides (`backgroundColor`, `foregroundColor`, `borderColor`), and border width stable sizing across all styles. - **Change:** All American "Color" naming renamed to British "Colour": `DievasTheme.coloursOf()`, `context.colours`, `DievasThemeAspect.colours`, `DievasColourThemeData`. - **API:** `DievasTagBorderRadius.pill` now uses `DievasRadiusSemantic.full` (9999.0) via `resolve()` instead of `containerHeight / 2`. - **Fix:** `DievasTag` stable width test targets Container descendants of DievasTag instead of global `find.byType(Container)`. - **Internal:** Downgraded `widgetbook` to ^3.21.0, `meta` to `>=1.17.0 <2.0.0`, `test` to ^1.30.0 for Flutter SDK 3.41.9 compatibility

## 0.0.4 - **New:** `DievasGlobalThemeData` now accepts an optional `DievasTypographyThemeData? typography` parameter for custom type scales (instead of hardcoded `DievasTypographySemantic` defaults). - **Change:** `DievasGlobalThemeData` relaxed from `sealed` to `base` to allow consumer app extension. - **New:** Private `_raw` constructor added bypasses all derivation (typography, elevation, components, material) for use by `copyWith`. - **Optimization:** `copyWith` now returns `this` immediately when nothing changed, and reuses pre computed `_material`, `_elevation`, and `_typography` when only components change. Only component derivation is re run. - **API:** `copyWith` now also accepts `DievasTypographyThemeData? typography` for dynamic type scale overrides. - **Internal:** `DievasLightThemeData.copyWith` and `DievasDarkThemeData.copyWith` pass `typography` through to match the updated method signature

## 0.0.3 - **Surface colours:** Added `SurfaceColours` value object with canvas, code, sidebar, and table striped tokens; wired into light/dark themes. - **Breakpoints:** `DievasGridBreakpoint` now references `DievasBreakpointSemantic.*` instead of hardcoded pixel values. - **Elevation:** `_buildDefaultElevation` uses `offsetY` from each `DievasElevationShadowLayer` rather than `Offset.zero`. - **Easing curves:** Added 4 `Curve` fields to `DievasAnimationThemeData` (`easingStandard`, `easingEnter`, `easingExit`, `easingEmphasize`) resolved from `DievasEasingPrimitives`; replaced hardcoded `Curves.easeOutCubic`/`Curves.easeInOut` across 6 components. - **Component quality:** - Replaced all `AnimatedBuilder` usages with `AnimatedWidget` subclasses (switch, auth_code, loader). - Removed bang (`!`) operators from component code. - Replaced `_DigitBox._buildContent` builder function with a switch expression dispatching to private widget classes. - Replaced hardcoded `Colors.black` in auth_code obscured dot with token aware fallback. - **DievasTheme integration:** `animationOf()` accessor returning typed `DievasAnimationThemeData` for curve lookups in components

## 0.0.2 Added `repository:` and `homepage:` to pubspec. - Added `example/` directory. - Improved dart doc coverage

## 0.0.1 Initial release. - Theme infrastructure: InheritedModel based theming with static sub system accessors, brand theme contract, and default light/dark themes. - Components: buttons, form inputs, display components, feedback/overlay components, navigation/disclosure widgets. - Semantic colour schemes, typography roles, spacing/sizing scale, elevation layers, and animation presets
