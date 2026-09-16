# Dievas Example App

A complete, runnable reference app for the [Dievas design system](../README.md).

This is the app to study before wiring Dievas into your own Flutter project.

It evolves as the design system grows into maturity and at its core, it demonstrates two things end to end:

1. **How to set up your app's theme properly**: brand tokens, a custom typography ramp, and light/dark theme data that extend `DievasGlobalThemeData` (the exact pattern every consumer app follows).
2. **How to consume the system**: every context extension, the `DievasTheme` statics, the responsive grid, overlays, localizations, and a broad slice of the component library.

No names from any other design system appear here. Everything is branded "Example" so you can rename it to your own app.

## Run it

```bash
cd packages/dievas/example
flutter pub get
flutter run
```

Requires the Melos workspace to be bootstrapped first (`melos bootstrap` at the repo root), because the example depends on `dievas` and `dievas_tokens` by path.

## What each file teaches

### `lib/main.dart`

The entry point. A single `DievasScope` wraps the whole app and:

- resolves the active theme from `themeMode` + platform brightness,
- inserts the `DievasTheme` InheritedModel into the tree,
- bridges to Material by passing `theme.material` to `MaterialApp`,
- registers `DievasLocalizations` so component copy resolves via `context.l10n`,
- hosts a `NavigationBar` shell with three demo screens.

### This is the only place an app talks to Dievas directly. Everything below reads the theme through `context.*`

### `lib/example_theme/` — the brand theme (copy this folder)

The template every consumer app copies. Study the files in order:

| File                       | Teaches                                                                                                                                |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `example_tokens.dart`      | Raw `int` brand colours + fonts. Pure values, no `Color` wrapping, no Flutter.                                                         |
| `example_typography.dart`  | Building a `DievasTypographyThemeData` over the `DievasTypographySemantic` ramp with your own font (Cascadia Code via `google_fonts`). |
| `example_light_theme.dart` | `ExampleLightThemeData extends DievasGlobalThemeData` — supplies the light colour set and typography; everything else is derived.      |
| `example_dark_theme.dart`  | The same for dark mode.                                                                                                                |

To make it your brand: rename `Example*` → `YourBrand*`, replace
`ExampleColours` with your palette, and point the fonts at your typefaces.

### `lib/screens/`

| Screen                            | Teaches                                                                                                                                                                                                               |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `example_overview_screen.dart`    | Theme switching (`DievasScope.of(context).setThemeMode`), banner/snackbar overlays (`showBanner` / `showSnackbar`), the responsive grid (`DievasGrid` + `context.grid`), and `context.l10n`.                          |
| `example_foundations_screen.dart` | Every aspect scoped subsystem — `colours`, `typography`, `spacing`, `sizing`, `border`, `elevation`, `opacity`, `animation` — plus the `DievasTheme.of` statics and a per instance component override via `copyWith`. |
| `example_components_screen.dart`  | The component library: buttons, form controls, display components, progress, feedback, overlays, tooltips, loaders, and empty states — all driven by the theme.                                                       |

## Key concepts to notice

- **Granular rebuilds.** `DievasTheme` is an `InheritedModel`; reading `context.colours` rebuilds only when colours change, never when `spacing` changes.
- **Nothing is hardcoded.** No component in the screens hardcodes a colour, size, or spacing; every value comes from `context.*`.
- **Contrast is a contract.** Dievas draws text on action surfaces using `colours.core.onBrand`, so `onBrand` must contrast `actionPrimary`. This brand's light-mode primary action is ink, so `onBrand` is lavender here — read the notes in `example_light_theme.dart` / `example_dark_theme.dart` before remapping any role.
- **Per instance overrides.** Wrap a subtree in `DievasTheme(data: copy)` to override a component for that subtree only (see the Foundations screen).
- **Material bridge.** Standard Flutter widgets (`NavigationBar`, `Scaffold`, `MaterialApp`) work automatically through `theme.material`.
