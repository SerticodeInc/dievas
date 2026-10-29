# Changelog

## 1.0.4

- **Token dependency compatibility**: require `dievas_tokens` 1.0.4 or newer, which includes `menuHoveredBackground` for both themes. The published 1.0.2 dependency lacks these constants, causing undefined getters and constant evaluation errors outside the workspace, including dependency lower bound analysis. Publish the token package before Dievas.

- **Segmented control**: retain typed controlled options and add widget segments, leading/trailing slots, icon only and custom content, per segment styling, 40px/48px sizes, expanded layout, directional geometry and instance surface/motion overrides. Add caller owned `TabController` integration, keyboard navigation, focus/hover/press feedback, selection semantics and reduced motion support. Replace static gallery samples with independently selectable text and icon groups and live semantic controls.
- **Segmented control appearance**: default to neutral selected surfaces and consistent text weight, with separate container/segment radii and gaps instead of separators. Brand palettes preserve neutral selection colours. Theme radius and padding fields accept directional geometry; use the size presets for size-specific layout overrides.

- **Radio callback migration**: `DievasRadio.onChanged` accepts `T?` so toggleable radios can clear selection. Update explicitly typed callback parameters and stored group values to accept null. Repeated activation of an already selected radio does nothing unless `toggleable` is enabled.
- **Radio**: match the Moon reference with a 16px outlined ring, 8px coloured dot and 40px tap target. Add active/inactive colour overrides, configurable hit area, focus nodes, autofocus, keyboard activation, focus feedback and radio semantics. Animate the ring and dot with reduced motion support; fix label wrapping and add theme `copyWith`. Rebuild the gallery with independent plain and labelled groups whose selection survives live controls.

- **Popover**: add controlled visibility, ten placements, viewport constraints, RTL, surface and motion overrides, keyboard activation, focus feedback, Escape dismissal and route observation. Preserve local themes and live content in the overlay. Replace the dimming barrier with non modal outside tap handling. Refresh the gallery with interactive reference content and semantic controls.

## 1.0.3

- **Modal colours**: add independent `titleColour` and `contentColour` widget/theme overrides and gallery selectors. Keep `textColour` as the shared fallback.

- **Modal gallery**: match the Moon reference composition with a 300px card, divided header, reference content insets and one full width 40px Okay button. Keep the confirmation example under With Actions.

- **Modal**: add title free custom content, header/trailing slots, colour, decoration, shadow, directional radius/padding, viewport inset, constraint and semantic overrides. Add configurable route barriers, safe areas, navigation, focus and transitions, preserving local themes and respecting reduced motion. Replace the close gesture with an accessible keyboard button, scroll long content above the keyboard and wrap actions on narrow screens. Add `closeDievasModal` for typed results and modal theme `copyWith`. Default body text to 14px, radius to 8px and shadows to none; existing custom themes retain their values. Replace static gallery cards with working modal examples and live controls.

- **Dependencies**: raise the minimum `dievas_tokens` version to `1.0.2`, matching the lowercase token names used by Dievas and excluding incompatible `1.0.1` from dependency lower bound resolution.

- **Menu item**: add custom leading, label and content slots; independent slot colours; surface, hover, decoration, radius and layout overrides; long press, keyboard activation, focus and semantics; and child gesture control. Use Moon Heles for neutral hover feedback and semantic opacity for enabled rows. Preserve the existing text and icon conveniences. Rebuild the interactive gallery with selection controls, expandable rows, named spacing/sizing presets and shared preview configuration.

- **Search composites**: join the dropdown to the painted input edge, use regular body text for menu labels, reduce search shadows to the hairline semantic tier, and offer compact input sizes. Rebuild Search with List as a flat, full height inline list with separate Clear and Close actions, centered initial/empty states, and live colour, radius, size, floating label and RTL controls. Result selection reports the item without clearing or dismissing the inline list. Keep the dropdown's semantic 256px cap.

- **Search with dropdown**: compose the search field with `DievasDropdown`; show all options on opening, filter trimmed queries, retain selected labels, and provide Clear and empty result states. Add joined or spaced surfaces, colour and semantic radius overrides, floating labels, shadow control, and a semantic 256px results cap. Preserve search state across Widgetbook controls and keep results inside the phone viewport.

- **Dropdown**: add anchor placement, width/height constraints, surface overrides, multi select and nested menus. Derive menu layout defaults from semantic tokens, including the 256px height cap. Fix overlay theme inheritance, placement and rebuild timing. Keep Widgetbook overlays inside the phone and preserve open menus while changing grouped controls.

- **Drawer**: add surface, barrier, radius, decoration, shadow and semantic label overrides; start/end placement with RTL support; opening gesture and barrier dismissal controls; open state feedback; and parent constrained widths. Refresh the interactive Widgetbook example with an edge to edge viewport, 80% default width, square corners and shadows off by default.

## 1.0.2

### Breaking changes - size names, localization and bottom sheet shadows

- Rename component size enums, divider indents and theme record keys to lowercase members such as `sm`, `md`, `lg` and `none`.
- Align theme size tokens with `dievas_tokens`: `spacing.md`, `border.sm`, `sizing.buttonHeightMd` and `typography.bodyMd`.
- Rename `context.l10n` to `context.dievasL10n`.
- Remove bottom sheet shadows and the `shadow` option from its theme and modal helper.
- Run `dart run dievas_migrate --write` to migrate size names, shorthand references and theme record keys.

### Components

- **Carousel**: add `DievasCarousel` and its controller with snapping, looping, autoplay, alignment and motion overrides. Support horizontal, vertical, keyboard, mouse and RTL navigation. Preserve selection through layout changes and pause autoplay during interaction or background states.
- **Breadcrumb**: add middle item collapse, a hidden page popover, custom overflow content, colour and spacing overrides, and leading/trailing slots. Add keyboard navigation, current page semantics and narrow screen scrolling. Remove ink effects.
- **Buttons**: add border, radius, full width, long press, semantic label and pulse options to filled, outlined and text variants. Fade and scale loading transitions without changing the content footprint; set `animateLoading: false` to disable them. Improve label wrapping and icon only layouts, and remove ink effects.
- **Checkbox**: add optional tristate cycling, colour overrides, rounded corners, configurable tap areas and animated tick/dash drawing. Support keyboard focus, accessible states, wrapping labels and clickable label rows.
- **Loader**: replace the fixed sweep with a growing and shrinking rounded arc. Use a 2222ms rotation cycle, matching Moon timing. Share the loader with buttons and expose diameter, stroke and duration overrides.
- **Divider**: add centred labels with style and gap overrides in both orientations. Change default thickness from 2px to 1.5px and fix collapsed or stretched strokes.
- **Dot indicator**: use equal 8px dots, 8px gaps and a 200ms colour fade. Add colour, size, gap, motion and accessible label overrides, keyboard activation and focus feedback. Preserve custom active sizes and optional tapping.
- **Avatar**: add image overlays, loading/failure fallbacks, Unicode safe initials, status badges and custom dimensions. Default to a rounded square; use `shape: .circle` for the previous shape. Paint borders above content.
- **AuthCode**: add box, circle and underline shapes, colour/layout overrides, error shaking, timed digit peeking, OTP autofill and edit callbacks. Support changing lengths up to 7 digits and narrow layouts.
- **Bottom sheet**: add resizing, content fitting, fixed header/footer slots, custom trailing actions, layout/motion overrides and selection results. Coordinate scrolling, dragging and dismissal; preserve local themes, safe areas and keyboard clearance. Centre titles and use a filled circular close button.

### Theme and gallery

- Use Piccolo purple (`#5C33CF`) as the default brand colour. Explicit palette overrides remain available.
- Default outlined buttons to primary foregrounds with neutral borders, and text buttons to secondary foregrounds with size based tap areas.
- Respect reduced motion across the updated animations. Disable carousel autoplay when reduced motion is enabled.
- Expand Widgetbook examples with grouped semantic colour controls and working component interactions. Use a shared Gohan background and 8px page padding inside the phone safe area.
- Declare Flutter as a direct dependency of the example app to resolve analyzer notices.

## 1.0.1

### Breaking changes - colour roles and z-index theme contract

- Rename colour roles by element, variant or state, and property: `pageBackground`, `buttonPrimaryHoveredBackground` and `inputFocusedBorder`. See the token package README for migration details.
- Custom `DievasThemeData` implementations must provide `zIndex`.

### Components and theme

- **Accordion**: add grouped layouts, sizes, borders, dividers, shadows, visual overrides and controlled expansion. Support state preservation and disabled items; fix initial chevron rotation.
- **Alerts**: add base, filled and outlined variants with content slots, colour/layout overrides and accessible dismiss actions.
- Expose the remaining semantic sizing, opacity and radius tokens through context accessors. Add `DievasZIndexThemeData`, `DievasTheme.zIndexOf` and `context.zIndex`.
- Resolve animation curves from semantic tokens while preserving custom overrides.
- Add interactive accordion and alert examples with grouped semantic colour controls.

## 1.0.0

### Breaking changes - size names, elevation, easing and shadow opacity

- Rename size tokens, enums and theme record keys to uppercase size suffixes, such as `spacingMD`, `DievasButtonSize.MD` and `heightLG`.
- Replace numeric component elevation with `List<BoxShadow> shadow` in modal, drawer, bottom sheet and popover themes. Rename dropdown `overlayElevation` to `shadow` and remove accordion `shadow`.
- Remove `DievasAnimationThemeData.easingEmphasize`; use `easingStandard`.
- Remove shadow opacity aliases from `DievasOpacityThemeData`: `shadow1`, `shadow1Light`, `shadow2`, `shadow2Upper`, `shadow2Lower` and `shadow2Heavy`. Shadow tints now belong to elevation layers.

### Added and changed

- Add `applyBrandPalette` and the `DievasGlobalThemeData.brandPalette` option. The default indigo palette preserves existing colours.
- Use centred token shadow stacks with the `shadowColour` tint. Add search field shadows.
- Increase badge padding and document size naming, spacing and brand palettes.

### Fixed

- Apply popover shadows and drawer corner radii from their themes.
- Keep alerts at their natural height in loosely constrained layouts.
- Animate the tab bar with one sliding underline.

## 0.0.5

- Add `DievasTag` with shape, colour and border width options.
- Rename public colour APIs to British spelling: `DievasTheme.coloursOf()`, `context.colours`, `DievasThemeAspect.colours` and `DievasColourThemeData`.
- Use the full radius token for pill tags and fix stable width verification.
- Adjust development dependency versions for Flutter 3.41.9 compatibility.

## 0.0.4

- Add custom typography and dynamic `copyWith` overrides to `DievasGlobalThemeData`.
- Allow consumer apps to extend `DievasGlobalThemeData`.
- Reuse derived theme values when copying unchanged subsystems.

## 0.0.3

- Add `SurfaceColours` for canvas, code, sidebar and striped table surfaces.
- Resolve grid breakpoints and animation curves from semantic tokens.
- Apply token shadow offsets and fix token aware AuthCode placeholder colours.
- Add `DievasTheme.animationOf()` and improve component animation handling.

## 0.0.2

- Add package repository/homepage metadata, the example app and API documentation.

## 0.0.1

- Initial release with theme infrastructure, semantic tokens, light/dark themes and Flutter components.
