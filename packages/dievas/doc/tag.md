# Use Tag (unreleased)

Use `DievasTag` to display a compact label with optional leading and trailing content. Your application owns tap, long-press, and removal behaviour. These additions are in workspace source and are not included in hosted 1.0.4.

This example displays a tag with a decorative close glyph. Tapping the glyph invokes the tag’s action; it does not remove the tag:

```dart
DievasTag(
  label: 'Flutter',
  tagSize: DievasTagSize.xs,
  trailing: const Icon(Icons.close),
  onPressed: openDetails,
)
```

## Choose size and content

The default is a filled XS tag with a neutral white/black surface and primary foreground. XXS, XS, and SM presets use heights of 16, 24, and 32px. Their text sizes are 9, 12, and 12px, icon sizes are 12, 16, and 16px, and slot gaps are 2, 2, and 8px. XXS/XS use 4px radii and SM uses 8px. Label-only horizontal padding is 8, 8, and 16px. Slots replace adjacent default padding with their gap insets.

Existing `label`, `leadingIcon`, `.filled`, `.tinted`, and `.outlined` calls remain supported. `labelWidget` overrides the string label; `leading` overrides `leadingIcon`. An empty string omits the label slot. Use `trailing` for decorative content, or `onRemove` for a separate accessible action. When both are supplied, the remove action takes precedence.

String labels stay on one line and truncate under narrow constraints. Give custom labels a layout that fits the chosen height. Supply `semanticLabel` for icon-only tags or a richer accessible name.

## Control appearance

Override `width`, `height`, directional `padding`, `gap`, `textStyle`, and `borderRadius` per instance. `DievasTagBorderRadius.rounded` accepts directional radii and resolves them using the surrounding text direction. Existing `.pill` calls and no-argument `resolve()` calls remain supported.

Set `textColour` and `iconColour` independently. The existing `foregroundColor` still controls both when independent instance colours are absent. Instance colours precede theme colours, then style defaults. The existing `backgroundColor` and `borderColor` names remain supported. A custom `decoration` replaces the default surface; text and icon styling still apply.

Without `tagSize`, flat theme geometry remains authoritative. Explicit presets can be customised with the optional `xxs`, `xs`, and `sm` `DievasTagSizeData` entries on `components.tag`. Theme copies include preset, foreground, and disabled-opacity additions; use `clearTextColour` or `clearIconColour` to restore derived colours.

## Handle actions

Set `onPressed` for taps and `onLongPress` for long presses. Interactive tags support Enter/Space activation and show keyboard focus. A long-press-only tag uses the long-press callback for keyboard activation. A caller-owned `focusNode` remains caller-owned. Tags without actions remain static display elements.

`onRemove` adds a separate close action. It handles pointer, keyboard, and screen-reader activation without also invoking `onPressed`. Set `removeSemanticLabel` to provide a contextual action name; the default uses the localised delete tooltip and string label. Remove the tag from your own state when the callback runs.

Set `enabled: false` to dim the tag and block its actions and embedded controls. Pointer hover does not paint an additional surface. No animation is introduced.

## Verify in your application

Check pointer and keyboard activation, independent removal, screen-reader names, disabled children, narrow labels, directional geometry, custom themes, and all sizes on your target platforms. Component and gallery tests are written but have not been run during this implementation.

The default changes from tinted to filled, with a 24px height, regular 12px text and Moon-compatible slot spacing. Pass an explicit style or custom component theme to preserve an existing appearance. Dark `tagBackground` changes to neutral black. No package versions change.
