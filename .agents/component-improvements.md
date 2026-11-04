# Change Log

## Unreleased

### Switch (4 November 2026)

- Extend the controlled switch from the Moon API, source and reference story: XXS/XS/SM geometry, instance colours/dimensions/directional padding/motion, four state-specific content slots, thumb shadow, horizontal drag, RTL, caller-owned focus, Enter/Space, visible focus, toggled/enabled semantics and optional haptics. Preserve label and existing theme construction. Slots are decorative and cannot interact independently.
- Default to a 44×24 track, 16px white thumb and 4px inset; use exact Moon light/dark Beerus inactive tracks through existing semantic colour roles. Update token colour fixtures. Explicit size presets override theme geometry; absent presets preserve custom theme dimensions. Reduced motion settles immediately; rejected drags return to controlled values.
- Replace gallery samples with three independent reference switches and grouped size, semantic colour, slot, disabled, RTL, haptic and motion controls. Preserve state per Widgetbook session across knob remounts. Switch pages own 64px vertical/16px horizontal insets; titles use bodyXs. Retain All States and With Labels pages.
- Add component and gallery regression tests and unreleased API guidance. User owns runtime testing and the already-running local gallery; no tests, debug builds or preview processes were run. Package versions unchanged. Branch: feat/switch_tab_bar_tag; Tab Bar and Tag remain pending.

### Segmented control styling consolidation (30 October 2026)

- Add `DievasSegmentedControlStyle` for container decoration, shared `DievasSegmentStyle`, spacing, and motion. Add `DievasSegmentAppearance` for base/selected/hovered/pressed decoration, text, and independent icon colour. Keep flat control and overlapping segment properties as deprecated compatibility inputs; no version bump or package publication.
- Resolve theme/size defaults, legacy control inputs, shared segment style, then local segment style. Within a style layer, resolve legacy fields, base appearance, selected, hovered, then pressed. Sparse box decorations merge non-null fields; border/shadow fields replace whole values. Non-box legacy decoration retains replacement behaviour. Circles survive sparse overrides; explicit radii restore rectangles.
- Preserve selected fills under border-only decorations, prefer explicit selected text colour over legacy text style colour, keep hover/press distinct from selection, and derive focus outline shape/radius from resolved box decoration. Use shared styling in the gallery rather than copying the same local style to every segment.
- Add the unreleased migration guide and package changelog entry. Verified 24 segmented control tests and the Widgetbook live-override regression; inspected the bundled-font gallery render. Static analysis passes in Dievas and the gallery, changed Dart files pass 120-column formatting, and the documentation Astro check passes. Circle/rectangle transitions snap safely without remounting content; constructor inputs emit migration deprecations.

### Dedicated documentation site (29 October 2026)

- Add the independent Astro Starlight application in `documentation/`, outside Melos, targeting `docs.dievas.serticode.com`. Keep the Jaspr landing page and Flutter Widgetbook gallery separate.
- Document the hosted Dievas 1.0.4 / tokens 1.0.3 baseline with installation, first screen, foundations, theming, five component family guides, the complete 38-widget inventory, three recipes, upgrade/troubleshooting/API/contribution guidance. Distinguish detailed guide coverage from API/gallery-only entries.
- Require task-oriented component documentation with state ownership, supported customisation, verified accessibility behaviour and limitations, versioned API links and gallery links. Update documentation/examples/migrations alongside public API changes.
- Verify 24 Dart blocks through a standalone hosted consumer; four adoption-flow widget tests pass. Astro type/content checks, release build, and 1,320 local links/anchors/assets pass; all 46 linked pub.dev API pages return HTTP 200. Browser checks cover mobile/desktop navigation, themes, search, Escape dismissal and copy feedback.
- Follow the active Obsidian Dievas product checklist for checkpoints and commit cadence. Deployment and review evidence is recorded there; do not infer production availability from this implementation entry.


### Token package compatibility release preparation (29 October 2026)

- Compared Dievas references with the cached hosted `dievas_tokens` 1.0.2 sources. Both theme references to `menuHoveredBackground` are missing from that published API; the constants already exist in the local workspace. No token fallback or hardcoded theme replacement is needed.
- Prepare `dievas_tokens` 1.0.3 and Dievas 1.0.4, following Serticode's revised version choice; require `dievas_tokens: ^1.0.3`. Preserve the ongoing segmented control changes and include their existing changelog entries under the candidate release headings. Keep release instructions in the existing `docs/release_check_list.md`; do not create another release Markdown file or change ignore rules for it.
- Link the README release guidance to the existing `docs/release_check_list.md` checklist and keep that file tracked despite the global `*.md` ignore. The checklist must cover local dry runs, tokens-first publication, and standalone hosted dependency checks at both current resolution and lower bounds. Workspace analysis alone can hide this mismatch. The new token version must be available on pub.dev before standalone consumer resolution can succeed.
- Reviewed source and manifests, then ran the `dievas_tokens`, segmented control, colour-role and gallery tests. `dart analyze` passed in all three packages. No package dry runs, publishing, commits, merges or pushes were performed for this change. Existing colour migration tests already reference both menu hover constants.

### Segmented control (1.0.4)

- Gallery section titles use bodyXs, one step below bodySm, retaining the secondary text colour.

- Compare with Moon Design 1.1.0 API, segment/style types, size presets and published text/icon story. Retain the typed `options`, controlled `value`, `labelBuilder`, `onChanged` and `enabled` API. Add typed `DievasSegment` descriptors with leading/label/trailing widgets, semantic labels, individual enabling, focus nodes/autofocus and `DievasSegmentStyle` overrides. Add a custom content builder that receives the typed value and selection state.
- Add small/medium 40px/48px presets, 4px container padding/gaps, independent outer and segment radii, size-derived icon/gap/padding defaults, expanded widths, explicit dimensions and directional padding. Use neutral selected surfaces with consistent 16px text instead of branded fills, bold selected labels or separators. Preserve legacy theme construction through fallback geometry, and add theme/preset `copyWith` and equality.
- Let a caller-owned TabController take selection precedence; observe index changes, notify typed changes once, detach replaced controllers and leave external controllers/focus nodes undisposed. Add Enter/Space, RTL-aware arrows, Home/End, disabled-segment skipping, hover/press/focus feedback and selected/enabled/group semantics. Respect reduced motion for surface and text transitions; scroll natural-width controls when constrained. Disabled custom content cannot receive pointer interaction.
- Change semantic selected background/text to white/black in light mode and black/white in dark mode, matching Moon Goku/textPrimary. Keep the existing brand-role record fields as neutral compatibility values. Palette application leaves these neutral roles unchanged, preserving custom neutral colours. Update parity/baseline fixtures and palette assertions together; package versions remain unchanged until release preparation.
- Replace static gallery samples with three text segments and four independently controlled frame-icon segments. Persist selections per Widgetbook session across live size, colour, radius, gap/padding, slot, expanded, RTL, disabled and motion controls. Include custom-content and controller examples. The page owns reference vertical/horizontal insets; use single-line section titles and existing semantic selections rather than continuous pixel sliders.
- Add focused component and gallery tests for controlled selection, sizes/expanded geometry, controller replacement/ownership, RTL keyboard navigation, disabled custom content, semantics, narrow scrolling, reduced motion, live gallery state and palette independence. Static analysis and formatting are checked. Runtime tests and rendered previews are intentionally not run, following the machine's resource rule; run the targeted package tests before release.

### Radio (1.0.4)

- Enabled opacity resolves through `DievasTheme.opacityOf(context).opaque`; preserve the component theme's disabled opacity override. Name normalized selection endpoints explicitly; they represent ring/dot interpolation progress, independent of opacity, duration and easing tokens.

- Compare with Moon Design 1.1.0 API, radio painter and published reference story. Default to a 16px outlined ring with a 1px stroke, 8px active-colour dot, transparent interior and 40px hit target. Draw default ring/dot from the existing brand role and neutral ring from iconSecondary; explicit component themes retain their custom dimensions and colours. No token package change is needed.
- Widen `onChanged` to `ValueChanged<T?>` for toggleable deselection. Preserve controlled group values and optional labels; repeated selection is silent unless toggleable. Update the example app's stored value to nullable. Add active/inactive colour overrides, zero-or-larger hit area, caller-owned focus nodes, autofocus, semantic labels, checked/group/disabled semantics and Enter/Space activation.
- Animate ring colour and dot growth from controlled selection; preserve animation continuity and settle immediately for reduced motion. Add visible keyboard focus and directional label spacing with Flexible directly under Row. Add radio theme `copyWith`, optional motion defaults and equality; honour custom disabled ring and background fields.
- Match the reference's two plain radios and two labelled menu rows with independent selection. Menu rows own labelled interactions and child radios are excluded from focus/semantics. Keep values in per-Widgetbook sessions across knob remounts. Expose grouped active/inactive colours, toggleability, disabled state, named hit-area sizing and RTL. Reference page owns its 64px vertical/16px horizontal insets; section headings stay on one line between flexible dividers.
- Verify pointer and keyboard selection/clearing, repeated activation, disabled focus, radio semantics, actual 16px circle/40px hit geometry, edge taps, narrow RTL labels, reduced motion, theme copies, gallery interaction and live state/colour/RTL changes. Render and inspect the bundled-font gallery preview.

### Popover (1.0.4)

- Resolve enum spacing choices with an exhaustive typed switch. Avoid nullable map lookups and forced casts for guaranteed preset values.

- Resolve combined nullable precedence with tuple switches, including target distance by position and instance/theme animation or icon overrides. Select custom decoration with a switch so default surface construction stays in its matching arm. Keep simple two-value defaults concise; do not chain `??` or put `??` before a switch. Use switches for multiline conditional values.

- Compare with the published Moon Design 1.1.0 API, implementation and story. Preserve automatic trigger toggling and add caller-owned `show`, visibility requests, outside-tap callbacks, ten positions, RTL resolution, target distance, viewport margins, constraints and semantic labels.
- Add background, text, icon, border, directional radius/padding, decoration, shadow and transition overrides. Resolve defaults through the component theme; add theme `copyWith`, border/icon/margin/curve fields and equality. Use bodySm and small token shadows. Retain legacy arrow/barrier theme fields for source compatibility; the panel has no arrow or dimming barrier.
- Open on completed taps, preserve trigger handlers, support Enter/Space, Escape, visible keyboard focus and focus return. Fade panels with reduced-motion support, keep them attached to moving targets, preserve caller-local Dievas/Material themes and update open content after builds. Accept a Navigator route observer to hide covered routes and restore requested visibility on return.
- Replace the static gallery with the Moon-style Tap me launcher, avatar/text content and full-width Close button, plus edge and scrolling examples. Group semantic colour/radius/spacing/width, decoration, shadow, interaction and RTL controls. Preserve open state across Widgetbook knob remounts and use the phone-local Navigator overlay.
- Verify all ten open placements, viewport containment, RTL and local themes, live content, disposal, real button triggers, keyboard activation, outside dismissal, gallery controls and bundled-font renders. Existing tokens cover this component; package versions remain unchanged until release preparation.

### Modal (1.0.3)

- Keep standard modal composition in private _ModalContent and _ModalHeader widgets. Resolve heading, trailing-action precedence and body content once with tuple switches; reuse one hasHeader value for visibility and spacing. Avoid inline layout Builders and repeated nullable slot checks; retain close-only headers, custom header styling and action alignment.

- Expose independent titleColour and contentColour widget/theme overrides and gallery controls. Resolve slot overrides before shared textColour; custom headers inherit the title foreground and custom content inherits the body foreground. Preserve shared textColour compatibility and verify both the standard component and reference gallery use different colours simultaneously.

- Keep the reference header height independent of its close action. Overlay a 44px keyboard-accessible hit target with an explicit 20px icon aligned to the content inset; reserve only the glyph and gap in title layout. Retain 20px top/16px bottom heading padding. Verify the divider stays at the same height when Close is enabled and render the enabled-close state with bundled fonts.

- Correct Playground to match the published Moon 1.1.0 story: a centred 300px card, 24px horizontal insets, 20/16px header insets, 18px medium heading, full-width hairline Trunks divider, 14px body, 16px body/action vertical spacing and one full-width 40px Okay button. Omit the close icon by default; retain the confirmation layout under With Actions. Verify actual card/button geometry and inspect the bundled-font render.

- Compare with the published Moon Design 1.1.0 modal and route APIs. Retain title/body/content/actions conveniences and add optional titles, full custom child content, header/trailing slots, independent text/icon/background colours, directional radius/padding, decoration, shadow, viewport insets, constraints and semantic labels.
- Expand showDievasModal with root/local navigator selection, safe-area control, barrier colour/label, transition duration/curve, anchor point and focus requests. Preserve caller-local Dievas and inherited Material themes; return typed results through closeDievasModal. Keep focus inside the modal and respect reduced motion.
- Replace the close gesture with a shared DievasTextButton for Enter/Space activation, visible keyboard focus and localized semantics. Scroll long content above keyboard insets and wrap actions on narrow screens. Custom child content owns its close action.
- Default body text to bodySm, radius to border.md and shadow to an empty stack, following the Moon reference sizing and separation. Retain Dievas rounded geometry rather than introducing a Moon squircle dependency; custom decoration owns alternative painted shapes.
- Replace static cards with a phone-local Tap me launcher, working confirmation/cancellation results, content-only, keyboard-form and long-content examples. Group semantic colour/radius/spacing/sizing, custom decoration, shadow, RTL, route and motion controls. Preserve open/form state across Widgetbook knob remounts; modal gallery pages own their safe area so the barrier covers the full phone viewport.
- Verify results, barrier/Escape dismissal, keyboard close activation and visible focus, caller-local themes, directional clipping and inherited foregrounds, narrow keyboard viewport scrolling and wrapping, nested navigation, reduced motion, theme copyWith/equality and live gallery controls/form state. Render and inspect the open gallery with bundled fonts; run modal, bottom-sheet, theme and gallery-frame regressions.

### Menu item (1.0.3)

- Resolve gallery overrides once in a shared appearance record. Apply them through a private preview widget; example rows own only their content and interactions. Keep widget composition in classes, without widget-returning helpers.

- Gallery gaps/padding use named spacing presets and width/height use named sizing presets resolved from the active theme; do not use continuous pixel sliders.

- Default hover to Moon Heles through menuHoveredBackground: blackAlpha0A in light mode and whiteAlpha14 in dark mode. Preserve per-instance hover overrides.

- Compare with Moon Design 1.1.0 and retain string label/subtitle and leadingIcon conveniences. Add leading, labelWidget and content overrides, independent slot colours, surface/hover/decoration/radius overrides, dimensions, directional padding, gaps and both alignment controls.
- Add tap/long press, caller-owned focus nodes, autofocus, Enter/Space activation, visible focus and semantics. Rows without callbacks retain their existing appearance and allow embedded controls; only actionable rows receive keyboard focus and hover feedback. Explicit disabling blocks both row and child interaction. Gesture absorption routes child taps to the row.
- Add optional theme defaults and copyWith, token-derived minimum height and hover colour, regular bodySm content, reduced-motion hover transitions and a divider composition helper.
- Replace the static gallery with single/multiline, checkbox, switch and expandable menu examples. Keep interactive values across live knob remounts. Add grouped slot, semantic colour/radius, layout, custom decoration, hover timing, gesture, disabled and RTL controls.
- Verify keyboard/long press, gesture ownership, disabled children, custom slots, narrow RTL layout, separators, live gallery state/colours and bundled-font renders. Run menu item, search and dropdown regressions.

### Search composites (1.0.3)

- Express lifecycle replacement with guarded record switches and visibility with an enabled/show tuple switch in both search variants. Keep owned-resource cleanup in replacement helpers; preserve the complete editing value when returning to an owned controller. Verify ownership transitions, detached listeners, caller-owned resource survival and disabled visibility precedence.

- Collapse borderless input decoration when no floating label is present; use the input text strut and font-size caret height to center hint, value and caret. Clear owns no trailing padding: retain a single field inset and preserve shared button keyboard/semantics behaviour. Verify actual hint/caret centres and trailing spacing in LTR/RTL with the bundled font.

- Reviewed Moon Design 1.1.0 published preview source and search-with-dropdown snippet: this is a Dropdown/TextInput/MenuItem composite.
- Rebuilt DievasSearchWithDropdown on DievasDropdown with opening on tap, all initial results, trimmed filtering, retained selection, always-visible Clear, empty-result rows and outside dismissal.
- Added controlled visibility, external controller/focus ownership, input colour overrides, semantic radius and gap choices, joined corners, floating labels and shadow controls. Results default to sizing.height256.
- Gallery retains query, selection and visibility across knob remounts; uses a phone-local Navigator overlay and the reference component sample list.
- Verified component behaviour, SearchWithList/Dropdown regressions, live gallery overrides, scaled viewport geometry and rendered previews with bundled fonts.

- Match both supplied references as distinct compositions: Dropdown owns an overlay; List renders undecorated results in remaining page height, with no popup, border, shadow or separators. List tap opens all results; Clear preserves visibility, Close clears/hides/unfocuses, and selection only reports the result.
- Use regular bodySm (14px, matching Moon textDefault) for MenuItem labels and search input text, height40 minimum search rows, hairline elevation.xs for search dropdowns and compact 32/40/48/56 input sizes. Keep the approved 256px dropdown cap; inline results have no such cap.
- The shared search field owns its full painted surface/border so its allocated and painted bottom edges coincide. Zero-gap dropdowns meet exactly; positive semantic gaps retain full corners. Use a thin search glyph, regular Clear text and a separate accessible Close action for inline search.
- Search gallery pages bypass shared SafeArea/padding and own reference insets (vertical spacing.xl3, horizontal spacing.md). Both preserve query/open state across live controls; list uses the reference component options rather than fruit/static demos.
- Render empty/open/filtered states and verify painted surface geometry, regular label weights, subtle shadows, live sizes/colours/radii, Clear/Close and result selection. Widget-returning helper methods are forbidden; use widget classes and switch expressions for result branches.


### Dropdown (1.0.3)

- Internal UI must use local private widget classes, never widget-returning helper methods. Overlay, options list and option composition now live in _DropdownOverlay, _DropdownOptions and _DropdownOption; retain caller-supplied builder API callbacks.

- Named reference choices use the exact Moon-compatible palette tokens: royalPurple (Piccolo), amberGold (Krillin), leafGreen and its alpha variants (Roshi100/60/10). Verify the rendered Krillin button surface is #FFB319; feedback warning/success roles are not the reference palette.

- Verify against the published Moon Design 1.1.0 API, implementation and multi-choice/nested-menu story. Preserve the existing single-select API while adding multi-select, caller-owned triggers/content, controlled visibility, all anchor positions, alignment/offset overrides, surface overrides and constraints.
- Resolve nullable widget overrides through the dropdown component theme. Derive menu margin and trigger distance from spacing.sm, content padding from spacing.xs, border width from border.strokeThin and maximum height from sizing.height256. Omit the border when showBorder is false.
- Anchor using the actual popup size, preserve the active Dievas and Material themes below the Navigator overlay, defer overlay invalidation until after build, and keep default option rows free of Material/InkWell. Use GestureDetector with keyboard actions and button/selection semantics; caller-built ink content owns its Material surface.
- Keep dropdown previews in a phone-local Navigator/overlay. Ignore outside taps beyond that viewport, and retain gallery selection and visibility per Widgetbook instance across knob URI remounts so live overrides remain visible.
- Mirror the supplied Moon preview composition: keep the hint beside a compact removable count tag, use full-width compact menu buttons that change to the named reference swatch with the selection, and highlight hovered/selected rows and the open submenu. Match section spacing, minimum menu-row touch height, and the small shadow tier. Render and inspect both multi-choice and selected nested-menu states with the bundled font.
- Mirror the multi-choice and nested menu reference with Dievas controls. Expose working background/border/radius/shadow, size, gap, anchor, enabled, multi-select and RTL controls. Radius options use active border semantics through r32.
- Verify component regressions and semantic defaults, popup geometry and containment, live gallery surface overrides and width/height/anchor/RTL changes, multi-select count/clear-all, menu-button colour updates and nested selection/dismissal. Render both reference states with the bundled font; keep shared frame padding for other pages.

### Drawer (1.0.3)

- Gallery radius overrides use semantic token choices none through r32 resolved from the active border theme; never a continuous decimal slider. Round only the exposed edge for start/end placement, including RTL.

- Verify against the published moon_design 1.1.0 archive, including its story: the reference explicitly uses a full viewport, 80% width and zero end radius. Drawer gallery pages bypass shared SafeArea/8px padding; default the reference example to square corners and no shadows while retaining optional shadow controls and component theme overrides.

- Add per-instance background/barrier colours, directional radius, custom decoration, shadow stack and semantic label overrides. Keep the existing child/drawer and GlobalKey controller API.
- Add start/end placement with RTL-aware default corners, edge opening and barrier dismissal controls, an isOpen getter and change callbacks. Constrain oversized widths to the available parent width.
- Replace the Material demo scaffold with a full-height interactive Open/Close reference example and grouped semantic colour, radius, width, placement, RTL and interaction controls.

## 1.0.2

- Complete package release notes for carousel, divider, dot indicator and shared gallery styling. Declare the example app’s direct Flutter SDK dependency to remove analyzer dependency notices.

### Dot indicator

- Default selected and unselected dots to equal 8px diameters with 8px gaps and a 200ms easeInOutCubic colour fade. Keep existing custom active-size themes and optional dot tapping compatible.
- Add per-instance selected/unselected colours, uniform size, gap, duration, curve, and accessible label overrides. Support keyboard activation, selected/disabled semantics, visible focus, and reduced motion.
- Match the gallery reference with four dots and working numbered buttons, grouped colour/layout/motion controls, optional dot tapping, count changes, RTL, and disabled state. Simplify carousel 6px dot customization to instance overrides.

### Gallery page padding

- The shared iPhone frame applies 8px (spacing.sm) padding inside SafeArea. Remove duplicate page insets from component and foundation examples and the home page. Retain internal component, card, section-heading, and modal content spacing.

### Divider

- Explicitly fill the available rule axis after alignment loosens child constraints; verify positive painted lengths for plain and labelled rules.

- Add centred labels, optional label style and axis spacing for horizontal and vertical dividers. Default line thickness to the 1.5px standard stroke token; keep explicit overrides. Preserve the painted stroke under tight parent constraints. Expose labels and optional thickness overrides in the gallery.

### Carousel

- Match Moon extras controls with card-edge overlap, squircle surfaces, small token shadows, thin chevrons, and disabled first/last navigation when not looping. Fade the complete disabled surface so the card and page show through.

- The extras example fills its available page width with one slide and no adjacent peeking. Use 32px arrow surfaces with 8px corners and 24px icons, plus equal 6px dots; keep these gallery overrides local.

- Use the Gohan surface for the shared gallery phone background and the white page surface for carousel cards. Use small arrow buttons with compact icons and token hairline shadows.

- Add DievasCarousel and DievasCarouselController with fixed item extents, snapping, gap, anchor or centered alignment, bidirectional looping, velocity control, and optional finite trailing-edge clamping. Support horizontal, vertical, mouse drag, RTL, and keyboard navigation.
- Add theme defaults and per-instance autoplay delay, transition duration, and curve. Pause autoplay during interaction, background lifecycle states, and disabled tickers; disable autoplay and animated navigation for reduced motion. Preserve selection through live item extent and count changes.
- Add the reference gallery strip and large-card example with synchronized previous/next buttons and dot navigation. Expose grouped layout, motion, semantic background override, and RTL controls. Item decoration remains caller-owned.
- Verify controller navigation, finite boundaries, reverse looping, snapping, live geometry, autoplay disposal, reduced motion, RTL/vertical layout, theme equality, and gallery controls.

- Slow the shared loader rotation token from 800ms to 2222ms, matching Moon timing so the arc growth and shrinkage remain visible. Applies to standalone loaders and button loaders; explicit duration overrides remain available.

### Checkbox

- Add optional tristate cycling: unchecked, checked, mixed, then unchecked. Preserve the enum API and binary default, including programmatically supplied mixed values.
- Add independent check, active/inactive fill and unchecked border colour overrides, focus node, autofocus, semantic label, and a configurable tap area.
- Animate fill and progressive tick/dash drawing; respect reduced motion. Add keyboard activation, checked/mixed/disabled semantics, and visible keyboard focus without Material ink effects.
- Match the reference defaults with a 16px rounded box, thin stroke, neutral border, Piccolo active fill and a 40px tap target. Custom checkbox themes retain their dimensions and colours.
- Add directional label placement and optional full width label rows. Fix long label wrapping and make the entire row clickable.
- Rework Widgetbook with independently interactive standalone and trailing checkbox label examples, grouped semantic colour overrides, tristate/disabled, tap area and RTL controls. State/label examples remain interactive.

- Use Moon Design Piccolo purple (`#5C33CF`) for the default primary brand in both themes. Update focus, selection, active controls, cursors, and tinted brand surfaces together; derive hover and pressed shades from Piccolo. Explicit palette overrides remain available.

### Buttons

- Fade and scale between normal content and loading on all three standard variants. `animateLoading` defaults to true; false or reduced motion switches instantly. Preserve content size and semantics through both directions and rapid reversals. Widgetbook exposes an Animate loading transition toggle.
- Use the shared DievasLoader inside buttons. Replace the fixed rotating sweep with a rounded arc whose head grows and tail catches up while rotating, following MoonCircularLoader. Default the loader track to transparent and its timing to the loader motion token; add optional diameter, stroke width, and animation duration overrides. Reduced motion displays a static arc.

- Consolidate button sizes, states, styles, and icon behaviour in one types file. Keep public package exports and variant style exports available. Move the icon button colour resolver and state controller lifecycle into the icon button; remove unused switcher and loader/press mixin files.

- Add border visibility, radius overrides, full width, long press actions, semantic labels, and optional pulse/jiggle press effects to filled, outlined, and text buttons. Keep custom child and shape APIs; the gallery focuses on standard button content.
- Share keyboard/pointer handling and loading layout across the three variants. Remove their Material ink surfaces and IconTheme wrappers; resolve standard icon slots through DievasIcon. Loading keeps the content footprint and accessible label; pulse and loader animations respect reduced motion.
- Wrap long labels in narrow layouts and retain natural width in unbounded parents. Support icon only content and long press only buttons.
- Default outlined buttons to primary foregrounds with neutral borders, and text buttons to secondary foregrounds. Destructive styles and explicit theme/colour overrides remain available. Text buttons now use the size variant's minimum height and padding instead of a content-only hit area.
- Add grouped Widgetbook controls for all reference options, independent semantic colour overrides, zero radius overrides, RTL, loading/disabled states, and working tap/long-press feedback. Add a standard three variant showcase; omit custom shape examples.

### Breadcrumb

- Add optional middle item collapse with a menu for hidden pages, customizable overflow content, and a localized tooltip.
- Add item/current_item/hover/divider colour overrides, gap, and leading/trailing item slots. Preserve the existing complete trail default and navigation API.
- Support keyboard navigation, selected page semantics, and horizontal scrolling on narrow screens. Disable home navigation when the trail is disabled.
- Expand Widgetbook with reference controls, semantic colour selectors, working navigation/reset, and a custom overflow example. Fix item count indexing.

### Breaking size token naming reversed

- Align the Flutter theme mirrors with the lowercased `dievas_tokens` size vocabulary: `DievasSpacingThemeData.md`, `DievasBorderThemeData.sm`, `DievasElevationThemeData.xl`, `DievasSizingThemeData.buttonHeightMd`, `DievasTypographyThemeData.displayLg`, and `DievasGridBreakpoint.md`.
- Colour roles, opacity, z-index, easing, animation intents, and `strokeThin`/`touchMin` are unchanged.
- Run `dart run dievas_migrate --write` to migrate theme mirrors and component call sites. The new `dievas_migrate` CLI reads analyzer errors and rewrites only the renamed token types.

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
