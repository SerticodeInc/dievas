# Dievas documentation

The dedicated documentation application lives in this directory, outside the Dart/Melos workspace.

## Scope

Help Flutter engineers install Dievas, build a first screen, customise themes, select components, and migrate existing applications. Use source-verified examples and distinguish published APIs from workspace changes.

## Content map

- Start: installation and first screen
- Foundations: tokens, typography/spacing, layout, motion/accessibility
- Theming: scope, theme mode, brand palettes, component overrides
- Components: inventory, buttons, inputs, selection, feedback, overlays
- Recipes: forms, settings, confirmation
- Maintenance: migration, troubleshooting, API reference, contributing

## Release baseline

Verified against pub.dev on 29 October 2026: `dievas` 1.0.4 requires `dievas_tokens` ^1.0.3. Both require Dart >=3.11.4; the Flutter package declares Flutter >=3.22.0. Choose a Flutter SDK that also satisfies the Dart requirement. `dievas_migrate` is not published on pub.dev at this audit; its CLI instructions must run from its repository checkout.

## Working agreement

Branch: `feat/dievas_documentation`. Commit after every 3 completed numbered Obsidian checkpoints. Keep the checklist honest about unperformed verification and deployment blockers. Submit a draft PR for human review; do not merge automatically.
