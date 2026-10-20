# Changelog

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
