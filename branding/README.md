# Dievas identity

Use these SVG masters for Dievas branding. The approved mark abstracts the landing footer into a sun circle, three progressively wider pills, and a moon circle. Keep exports in SVG format. Create the social preview separately when its design is agreed.

## Colours and lighting

The palette uses the checked Moon reference in `packages/dievas_tokens/test/fixtures/moon_colours_reference.json`, with Dievas black for the icons and shadows:

- Piccolo `#5C33CF`: rounded logo background
- Goten `#FFFFFF`: top circle and all three bars, including outlines
- Krillin `#FFB319`: bottom circle and outline
- Dievas black `#171717`: sun/moon strokes and translucent shadows

Light falls from the upper right (315° azimuth). Each circle and bar has a raised-edge highlight and a soft shadow cast toward the lower left. Sun and moon strokes remain unfiltered for clarity. Keep the same restrained palette and directional lighting across exports.

## Master geometry

Use `dievas-logo.svg` as the source of truth. Scale the complete mark uniformly:

- Canvas: 1024 × 1024, with a Piccolo tile and 205-unit corner radius. Exterior corners are transparent.
- Shape bounds before shadows: x = 256–768, y = 182–842.
- Alignment: every element shares the x = 512 centerline.
- Circles: outer diameter 160 units, 5-unit outlines, centered at (512, 262) and (512, 762).
- Pills from top to bottom: outer widths 266, 389, and 512 units. All have outer thickness 64 units, 5-unit outlines, and fully rounded ends.
- Spacing: 44 units between pill edges; 30 units between each circle and its adjacent pill.
- Sun and moon: retain their paths in centered 84 × 84 viewports.

`dievas-symbol.svg` contains the same mark and lighting on a transparent canvas. Place it on Piccolo or a contrasting dark surface so the white shapes stay visible.

## Typography

Use the landing’s Maison Neue Extended Medium for the `dievas` wordmark and Maison Neue Medium for supporting text. The landing navbar retains its text wordmark.

## Assets

| Asset | Use |
| --- | --- |
| `dievas-logo.svg` | Master mark on a rounded Piccolo tile |
| `dievas-symbol.svg` | Same mark on a transparent canvas |
| `dievas-favicon.svg` | Rounded tile with the mark enlarged 1.25× for browser tabs |

The favicon treatment is approved and promoted to the logo masters. No PNG logo exports or social-preview asset are part of this identity.

## Website and gallery assets

Keep these deployed copies synchronized with the masters:

- `landing/web/assets/dievas-logo.svg`: full-size logo
- `landing/web/favicon.svg`: favicon
- `packages/dievas_gallery/assets/branding/dievas-logo.svg`: Flutter-compatible full-size logo
- `packages/dievas_gallery/web/favicon.svg`: favicon
- `packages/dievas_gallery/web/icons/Icon.svg`: installation icon at the original scale
- `packages/dievas_gallery/web/icons/Icon-maskable.svg`: installation icon on an opaque square Piccolo background
- `packages/dievas/example/web/favicon.svg`: example app favicon

Browser assets use SVG specular lighting and drop-shadow filters. Flutter’s SVG renderer does not support those filters, so the gallery asset uses layered vector shadow silhouettes and upper-right edge highlights. Its shape, base colours, and lighting direction match the master without requiring raster exports.

The root README references the logo master directly. Gallery home uses its bundled logo copy; the component navigation stays unbranded. Update the favicon and landing logo cache versions when the artwork changes.
