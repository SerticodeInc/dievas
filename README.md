# Dievas Design System

> A Flutter design system inspired by [Genesis Design] and the visual language of [Moon Design System](https://flutter.moon.io). Multi-brand from day one.

---

## What It Is

Dievas is a Melos monorepo that houses a token layer, a full theme architecture, a Flutter component library, and a live gallery app. It is **not an application** — it is the foundation that applications build on.

The three-layer model that drives it:

```text
Moon Design System      →   component catalogue and visual reference  (what we port)
Genesis Design Pattern  →   architectural blueprint                   (how we structure it)
Dievas                  →   the output                                (our system, our API)
```

## Monorepo Structure

```text
dievas/
├── packages/
│   ├── dievas_tokens/      # Pure Dart — primitive + semantic token layer
│   ├── dievas/             # Flutter — theme stack + component library
│   └── dievas_gallery/     # Flutter app — live component showcase
├── pubspec.yaml            # Melos workspace root
└── analysis_options.yaml   # Shared lint rules (line length: 120)
```

### Package dependency rule

```text
dievas_gallery  →  dievas  →  dievas_tokens (pure Dart, zero Flutter dependency)
```

`dievas_tokens` must never import Flutter. It is safe to use in Dart-only targets — CLI tools, Jaspr, server-side code. A Flutter import in that package is a bug.

---

## Token Architecture

### Two-tier model

**Primitives** — raw values with no semantic meaning. Raw `int` or `double` constants, no Flutter types.

```dart
abstract final class DievasColourPrimitives {
  static const int indigo500 = 0xFF6366F1;
  static const int slate900  = 0xFF0F172A;
}
```

**Semantic tokens** — pure Dart aliases that map primitives to roles. No Flutter types here either — `Color()` wrapping happens in the `dievas` Flutter package.

```dart
// dievas_tokens — pure Dart, no Flutter import
abstract final class DievasColourSemanticLight {
  static const int textPrimary   = DievasColourPrimitives.slate900;
  static const int actionPrimary = DievasColourPrimitives.indigo500;
}

// dievas package — Color wrapping happens here
static const Color textPrimary = Color(DievasColourSemanticLight.textPrimary);
```

Colour roles use **grouped semantic naming** — `textPrimary`, `bgBase`, `actionPrimary`, `borderDefault` — not Moon character names. Primitive scales follow the Tailwind convention: `50` → `950`.

### Token families

| Family     | Primitives file              | Semantic file                     |
| ---------- | ---------------------------- | --------------------------------- |
| Colour     | `colour_primitives.dart`     | `colour_semantic_light/dark.dart` |
| Elevation  | `elevation_primitives.dart`  | `elevation_semantic.dart`         |
| Opacity    | `opacity_primitives.dart`    | `opacity_semantic.dart`           |
| Radius     | `radius_primitives.dart`     | `radius_semantic.dart`            |
| Spacing    | `spacing_primitives.dart`    | `spacing_semantic.dart`           |
| Typography | `typography_primitives.dart` | `typography_semantic.dart`        |

Typography uses **Maison Neue** (body, label, title) and **Maison Neue Extended** (display, heading), with JetBrains Mono for code.

---

## Theme Architecture

### Inheritance chain

```text
DievasThemeData               ← abstract interface (the contract)
  └── DievasGlobalThemeData   ← sealed abstract (shared construction logic)
       ├── DievasLightThemeData   ← default brand, light
       ├── DievasDarkThemeData    ← default brand, dark
       └── [AppThemeData]         ← consumer app's brand (lives in the app, not here)
```

`DievasTheme` is an `InheritedModel<DievasThemeAspect>`. Each sub-system (`colors`, `typography`, `spacing`, `sizing`, `border`, `elevation`, `opacity`, `components`, `material`) is a named aspect — a widget that depends only on `colors` does not rebuild when `spacing` changes.

### Context extension — flat API

```dart
// Inside any widget's build method
final color = context.colors.action.actionPrimary;
final style = context.typography.labelMd;
final gap   = context.spacing.md;
final cols  = context.grid.columns;
```

### Plugging in a brand theme

Consumer apps never touch `DievasLightThemeData` directly — they extend `DievasGlobalThemeData` with their own brand tokens:

```dart
// In the Cadence app — not in this repo
class CadenceLightThemeData extends DievasGlobalThemeData {
  CadenceLightThemeData({super.components})
    : super(
        colors: DievasColourThemeData(
          brightness: Brightness.light,
          action: ActionColors(actionPrimary: Color(0xFF7C3AED)),
        ),
        border: const DievasBorderThemeData(...),
      );
}
```

Then at the app root:

```dart
DievasScope(
  lightTheme: CadenceLightThemeData(),
  darkTheme: CadenceDarkThemeData(),
  child: MaterialApp.router(...),
)
```

The design system never knows which brand is running. Brand is resolved at `DievasScope` instantiation.

---

## Component Anatomy

Every component follows a strict four-layer pattern. No exceptions.

```text
Widget side                          Theme side
───────────────────────────────────  ─────────────────────────────────────────
dievas_filled_button.dart            dievas_filled_button_theme_data.dart
dievas_outlined_button.dart          dievas_outlined_button_theme_data.dart
dievas_button.dart  (@internal)      dievas_button_theme_data.dart
dievas_button_builder.dart           dievas_button_theme_style.dart  (@internal)
types/                               dievas_button_theme_state_style.dart
  dievas_button_size.dart (enum)     dievas_button_theme_value.dart  (typedef)
  dievas_button_state.dart (enum)
  dievas_button_style.dart (sealed)
```

Rules components always follow:

- No hardcoded colour, size, or spacing value — everything comes from `context.*`
- No `ThemeData` parameters on the widget itself — components read from `DievasTheme.componentsOf(context)`
- The `style` field is always a sealed class or enum, never a raw string
- No string literals — all copy goes through `context.l10n.*`

---

## Grid System

`DievasGrid` gives any widget breakpoint-aware layout via `LayoutBuilder`.

| Breakpoint | Min width | Columns | Margin | Gutter |
| ---------- | --------- | ------- | ------ | ------ |
| `xSmall`   | 0px       | 4       | 16     | 16     |
| `small`    | 360px     | 4       | 16     | 16     |
| `medium`   | 700px     | 8       | 32     | 24     |
| `large`    | 1000px    | 12      | 32     | 24     |
| `xLarge`   | 1348px    | 12      | 32     | 24     |

---

## Running Locally

Requires Flutter SDK and [Melos](https://melos.invertase.dev/).

```bash
dart pub global activate melos
melos bootstrap
```

```bash
melos run analyze          # dart analyze across all packages
melos run format           # dart format (line length: 120)
melos run test             # dart test (packages with a test/ dir)
melos run codegen          # build_runner build
```

To run the gallery:

```bash
cd packages/dievas_gallery
flutter run
```

---

## Dart / Flutter Version

```text
SDK: >=3.11.4 <4.0.0
```

Dart 3 idioms throughout — pattern matching with `switch` expressions, sealed classes, records, exhaustive matching. No legacy pre-null-safety patterns.

---

## Reference Systems

| Reference                                                        | Role in Dievas                                                     |
| ---------------------------------------------------------------- | ------------------------------------------------------------------ |
| [Moon Design System](https://flutter.moon.io)                    | Component catalogue, visual language                               |
| [Genesis Design System](https://github.com/bushadigital/warlock) | Architectural pattern, theme inheritance, InheritedModel structure |

---

## Status

`v0.0.1-dev` — **M1 complete** (semantic token layer). Theme architecture in progress. Target: complete system by **May 21, 2026**.

| Milestone                 | Status     | Window    |
| ------------------------- | ---------- | --------- |
| M1 — Semantic token layer | ✅ Done    | May 7–9   |
| M2 — Theme architecture   | 🔄 Next    | May 10–12 |
| M3 — Core components      | ⬜ Pending | May 12–15 |
| M4 — Composite components | ⬜ Pending | May 16–18 |
| M5 — Gallery + polish     | ⬜ Pending | May 19–21 |

---

## Team

Built by [Engineering](mailto:engineering@serticode.com) · Serticode Inc.
