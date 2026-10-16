# dievas_gallery

The interactive component gallery for the Dievas Design System, powered by [Widget book](https://widgetbook.io).

Hosted on Cloudflare Pages: `https://master.dievas gallery.pages.dev` -  -  - ## What It Is

`dievas_gallery` is a Widget book app. It is not shipped to users it is the interactive developer tool for inspecting every Dievas component across all variants, sizes, and states.

Every exported component in `dievas` has four use cases: - **Playground** - full knobs panel (style, size, shape, state, icons, label) - **All Styles** - one instance per style variant, side by side - **All Sizes** - one instance per size value - **All States** - one instance per state (disabled rendered via `onPressed: null`) -  -  - ## Custom Addons

### `DievasThemeAddon`

Wraps every use case canvas in the full `DievasScope` + `DievasTheme` + Material bridge. Passing `setting.data` to both `lightTheme` and `darkTheme` bypasses `DievasScope`'s internal brightness detection the addon dropdown is the sole light/dark toggle.

Without this addon, `context.colors` returns nothing - `DievasTheme.of(context)` finds no ancestor and throws. Standard `ThemeAddon<T>` only injects Material theming.

### `ComponentBoundaryAddon`

Toggle able hot pink 1dp border overlay that shows the exact hit box of any component wrapped in a `ComponentBoundary`. Zero component level code changes - `ComponentBoundaryScope` propagates the flag through the tree. -  -  - ## Addons Wired - `DievasThemeAddon` - Light / Dark - `ComponentBoundaryAddon` - toggle component hit boxes - `GridAddon(10)` - column grid overlay - `ViewportAddon` - 7 device viewports - `TextScaleAddon` - accessibility text scaling - `TimeDilationAddon` - slow motion animations - `InspectorAddon` - widget inspector -  -  - ## Running Locally

```bash
cd packages/dievas_gallery
flutter run d chrome
```

Or from the workspace root:

```bash
melos run gallery
``` -  -  - ## Deployment

Deploys to Cloudflare Pages via GitHub Actions. Three workflows in `.github/workflows/`:

| Workflow                        | Trigger                                  |
| -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - |
| `publish_gallery.yml`           | Push to `master` (path filtered)         |
| `publish_gallery_labeled.yml`   | PR labelled `dievas gallery preview`     |
| `publish_gallery_scheduled.yml` | Saturday cron prunes stale PR previews |

PR preview URLs are posted as comments automatically.
