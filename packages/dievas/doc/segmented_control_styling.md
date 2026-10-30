# Migrate segmented control styling

This guide covers the unreleased grouped styling API for Flutter application developers. Published Dievas 1.0.4 does not include these types. Use this guide when adopting the source change or a release containing it.

## Group the control appearance

Move appearance settings into `DievasSegmentedControlStyle`. Keep selection, callbacks, content, size, width, height, and expansion on the control. Existing flat parameters remain accepted; their removal requires a separately announced breaking release.

For example, replace these flat parameters:

```dart
DievasSegmentedControl<String>(
  options: const ['Day', 'Week'],
  value: 'Day',
  backgroundColour: Colors.grey,
  selectedSegmentColour: Colors.white,
  selectedTextColour: Colors.black,
  segmentBorderRadius: BorderRadius.circular(8),
)
```

Use the grouped surface and segment states:

```dart
DievasSegmentedControl<String>(
  options: const ['Day', 'Week'],
  value: 'Day',
  style: DievasSegmentedControlStyle(
    decoration: const BoxDecoration(color: Colors.grey),
    segmentStyle: DievasSegmentStyle(
      appearance: DievasSegmentAppearance(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      ),
      selected: const DievasSegmentAppearance(
        decoration: BoxDecoration(color: Colors.white),
        textStyle: TextStyle(color: Colors.black),
      ),
    ),
  ),
)
```

Import `package:dievas/dievas.dart` and Flutter Material for these examples. They are read-only; supply `onChanged` and update `value` to enable selection.

## Choose an override layer

The control resolves styling in this order:

1. Component theme and size defaults
2. Legacy control constructor parameters
3. `style.segmentStyle` shared defaults
4. Each `DievasSegment.style` override

At each segment layer, legacy fields apply first, followed by `appearance`, `selected`, `hovered`, and `pressed` when those states apply. A local base appearance can therefore override a shared selected appearance. Use the local `selected` appearance when the override should affect selection alone. Hover and press do not change selected semantics or the controlled value.

`TextStyle` values merge with inherited typography. Set `DievasSegmentAppearance.iconColour` to override icons separately; otherwise icons inherit the resolved text colour. Widgets with their own explicit text or icon colours keep those colours under Flutter inheritance rules.

## Compose decorations

`BoxDecoration` overrides merge non-null fields. A border-only override preserves the inherited fill, radius, gradient, and shadow. Lists and borders replace as whole fields; border sides and shadow entries do not merge individually.

Use `Colors.transparent` to clear a fill, `const []` to clear shadows, `Border.fromBorderSide(BorderSide.none)` to clear a border, and `BorderRadius.zero` to clear rounding. Null means inherit. A gradient paints over a colour; override the gradient itself to change it. A circle discards the inherited radius. Sparse overrides preserve a circle; an explicit radius, including zero, restores a rectangle.

The legacy `Decoration` inputs still accept non-box decorations, which replace the inherited surface. The grouped API accepts `BoxDecoration` so composition and focus geometry stay predictable. Focus outlines follow the final box shape and radius; legacy non-box surfaces retain the fallback outline.

## Verify the migration

Run your application checks:

```sh
flutter analyze
flutter test
```

Inspect both themes, keyboard focus, RTL corners, disabled segments, and pointer hover/press states. Confirm a border-only decoration preserves the selected fill and that selected text changes independently from normal text. Reduced motion still disables surface and text transitions. Changes between circles and rectangles snap immediately because Flutter cannot interpolate those box geometries safely; content stays mounted.

To return to the flat API, restore the original arguments. The compatibility inputs remain available, but they also receive the decoration composition and interaction fixes.
