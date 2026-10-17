# Dievas identity

Use the SVG masters for Dievas branding. The mark abstracts the landing footer into a sun circle, three progressively wider pills, and a moon circle. Keep exports in SVG format; create the social preview separately when its design is agreed.

## Colours and treatments

- Light grey `#DCDEE3`: outline of the sun circle.
- Chi-Chi `#FF4E64`: outline of the smallest pill.
- Hit `#1BD29A`: outline of the middle pill.
- Dievas black `#171717`: sun icon, all three pill fills, and moon circle outline.
- Piccolo purple `#5C33CF`: widest pill outline and moon circle fill.
- White `#FFFFFF`: sun circle fill, moon icon, and logo tile.
- All three pills are solid black so their silhouette remains visible at small sizes.

## Master geometry

Use `dievas-logo.svg` as the source of truth. Scale the complete mark uniformly.

- Canvas: 1024 × 1024, with a white tile and 205-unit corner radius. Exterior corners are transparent.
- Visible mark bounds: x = 256–768, y = 182–842. The mark occupies 50% of the canvas width and is centered vertically.
- Alignment: every element shares the x = 512 centerline.
- Circles: both have an outer diameter of 160 units and a 5 unit outline, centered at (512, 262) and (512, 762).
- Pills, top to bottom: outer widths of 266, 389, and 512 units. All have an outer thickness of 64 units, 5 unit outlines, and fully rounded ends.
- Spacing: 44 units between the visible pill edges; 30 units between each circle and its adjacent pill.
- Sun and moon: retain the landing’s paths in centered 84 × 84 viewports. Keep the smaller icon scale agreed in the final draft.
- Use flat colours, without gradients, shadows, or textures.

`dievas-symbol.svg` contains the identical mark on a transparent canvas. Its top circle remains white. Use it on light surfaces that preserve the black and grey outlines.

## Typography

Use the landing’s Maison Neue Extended Medium for the `dievas` wordmark and Maison Neue Medium for supporting text.

## Assets

| Asset               | Use                                     |
| ------------------- | --------------------------------------- |
| `dievas-logo.svg`   | Master mark on a rounded white tile.    |
| `dievas-symbol.svg` | Identical mark on a transparent canvas. |

Keep alternate treatments separate from these masters until reviewed. PNG logo assets and the previous social preview are removed.

## Website and gallery assets

The landing uses the mark in its favicon, gallery links, and brand demonstration. Its navbar retains the text wordmark. The gallery uses the SVG on its home page, browser favicon, and web manifest. Manifest icons include an opaque white maskable version; no PNG logo exports are used.

When the master changes, synchronize `landing/web/assets/dievas-logo.svg`, both `web/favicon.svg` files, `packages/dievas_gallery/assets/branding/dievas-logo.svg`, and the gallery’s `web/icons/Icon.svg` and `Icon-maskable.svg`. Favicons retain the complete rounded tile and enlarge the mark by 1.25× around the canvas center for small sizes; the maskable icon uses an opaque square background. Keep the mark’s geometry identical in every copy.
