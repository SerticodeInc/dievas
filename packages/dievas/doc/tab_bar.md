# Use Tab Bar (unreleased)

Use `DievasTabBar` to navigate between related views. Your application owns `selectedIndex`, or supplies a `TabController` shared with a `TabBarView`. These additions are in workspace source and are not included in hosted 1.0.4.

## Keep a controlled selection

Existing string-label calls remain supported. Inside a stateful widget with an integer `selected` field, update the selection in the callback:

```dart
DievasTabBar(
  tabs: const ['Details', 'Activity', 'Settings'],
  selectedIndex: selected,
  onChanged: (index) => setState(() => selected = index),
)
```

A null callback makes the bar read-only unless you supply a controller. Selecting the active tab does not report another change. Set `enabled: false` to disable interaction and dim the entire bar.

## Add icons, disabled tabs, or custom content

Supply `items` instead of `tabs` for rich content. Each `DievasTab` supports `leading`, `label`, `trailing`, a semantic label, individual enabling, focus options, and a local style. This example uses a caller-owned `selected` index:

```dart
DievasTabBar(
  selectedIndex: selected,
  onChanged: (index) => setState(() => selected = index),
  items: const [
    DievasTab(label: Text('Details')),
    DievasTab(label: Text('Activity'), enabled: false),
    DievasTab(
      leading: Icon(Icons.settings_outlined),
      label: Text('Settings'),
    ),
  ],
)
```

Set `variant: DievasTabBarVariant.pill` for filled selected surfaces. For caller-painted tabs, use `.custom` and provide a `builder` on each descriptor. The builder receives the controlled selection state. Tab content is decorative: the bar owns pointer and keyboard activation, so nested gestures and focus targets do not act independently. Name icon-only or custom tabs with `semanticLabel`.

## Link a page view

Create a `TabController` in your state using a ticker provider, pass it to both the tab bar and `TabBarView`, and dispose it in your state. Its length must match the tabs. Its index takes precedence over `selectedIndex`; controller changes notify `onChanged` once per distinct index. The bar detaches listeners when you replace or remove the controller and never disposes it. External controller updates can select any index, including a disabled tab; disabling prevents user activation.

## Customise appearance and layout

`tabBarSize` selects small (32px) or medium (40px) height. Medium is the default. Both sizes use 24px icons, a 2px underline, and 16px medium-weight labels. Small uses 12px horizontal label padding, 4px slot gaps and 4px pill radius; medium uses 16px padding, 8px slot gaps and 8px radius. Outer tab gaps default to 4px. Theme overrides remain available.

Set `isExpanded: true` to divide bounded width equally. Natural-width tabs scroll when constrained; selection changes bring the active tab into view in LTR and RTL. Set `width`, `height`, directional `padding`, `gap`, or container `decoration` to customise layout. `showDivider` adds an optional baseline; the default has none.

Apply shared `tabStyle` and override individual fields through `DievasTab.style`. Styles include independent text/icon colours, selected colours, selected pill fill, indicator colour/height, focus colour, directional radius/padding, slot gap, text style, and decoration. Explicit state colours take precedence over text-style colours. Local fields override shared fields; text styles merge. A foreground decoration can add borders without removing the selected pill surface. Opaque custom decoration can cover that surface.

Unselected labels use the primary foreground; selected underline labels use the brand indicator colour. Pill surfaces use neutral white/black with the primary foreground. Pointer hover and press show the active tab appearance without changing selection. The underline continues to slide between selected tabs.

## Verify interaction

Enter and Space request selection. Left/Right follow text direction, and Home/End select the first/last enabled focusable tab. Keyboard navigation skips disabled tabs. Caller-owned focus nodes remain caller-owned; focus outlines and selected/enabled semantics are provided.

Set `transitionDuration` and `transitionCurve` to override theme motion. Reduced-motion preferences disable component transitions and selection scrolling animation. Check focus order, screen-reader announcements, narrow layouts, page-view swipes, RTL, disabled tabs, and custom content on your platforms. Component and gallery regression tests accompany this implementation but have not been run.

Default dimensions, text colours, pill radii, and the optional baseline differ from hosted 1.0.4. Existing custom theme constructors remain accepted; added theme fields are optional and participate in `copyWith` and equality. Package versions are unchanged.
