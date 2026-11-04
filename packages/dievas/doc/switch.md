# Use the switch (unreleased)

Use `DievasSwitch` for an on/off preference. Your application owns `value` and updates it in `onChanged`. These additions are in workspace source and are not included in the hosted 1.0.4 API.

This example belongs inside a stateful widget with a boolean `darkMode` field:

```dart
DievasSwitch(
  value: darkMode,
  onChanged: (value) => setState(() => darkMode = value),
  semanticLabel: 'Dark mode',
  switchSize: DievasSwitchSize.xs,
  activeTrackWidget: const Text('ON'),
  inactiveTrackWidget: const Text('OFF'),
)
```

## Choose a size and appearance

The default theme uses a 44 × 24 track with a 16px thumb and 4px padding. Explicit `switchSize` presets are `xxs` (32 × 16, 12px thumb, 2px padding), `xs` (44 × 24, 16px thumb, 4px padding), and `sm` (60 × 32, 24px thumb, 4px padding). Without a preset, the switch preserves geometry from your `components.toggle` theme.

Override `width`, `height`, `thumbSize`, or directional `padding` per instance. Leave enough track width for thumb travel and enough height for the thumb and padding. Override `activeTrackColour`, `inactiveTrackColour`, and `thumbColour` independently. The theme retains separate on/off thumb colours. `thumbShadow` in the component theme defaults to the active small elevation tier; use an empty list to remove it.

Use `activeThumbWidget` and `inactiveThumbWidget` for thumb content. Track content occupies the free half of the track and mirrors in RTL. Content fades during movement. Text and icons inherit size and foreground defaults; supply explicit styles or colours in custom widgets when needed. Slots are decorative and cannot receive focus or pointer interaction; use `semanticLabel` to describe the preference.

## Handle interaction

A null `onChanged` disables pointer, drag, keyboard, and accessibility activation. Enter and Space request the opposite value. Horizontal drags report a change only when the thumb crosses the midpoint into the opposite state. The thumb returns to the value supplied by your application if you reject that request.

Supply a caller-owned `focusNode`, or use `autofocus`. The switch does not dispose your node. A keyboard focus indicator appears on the thumb. `label` remains an optional visible, wrapping label and supplies the accessible name unless `semanticLabel` overrides it.

Haptic feedback is enabled by default; set `hasHapticFeedback: false` to suppress it. Use `duration` and `curve` to override theme motion. Reduced-motion preferences settle changes immediately.

## Verify in your application

Check tap, drag, Enter, Space, focus visibility, screen-reader announcements, disabled states, narrow labels, and RTL on your target platforms. Automated component and gallery tests accompany this change but were not run during implementation.

Existing constructors remain supported. Default thumb geometry and off-state colours change to match the Moon reference; explicit component theme values remain authoritative. No package version changes are included.
