# Hand-drawn Annotations & Sketches (Rough.js)

Use this when the user wants an **informal, hand-drawn / sketchy / whiteboard look**, the aesthetic of Excalidraw, for shapes, callouts, highlights, or annotations layered over another visual.

> **Different medium, read this first.** Every other diagram type in this skill produces a static PlantUML `.pu` file validated by the PlantUML jar. Rough.js does NOT. It is a JavaScript library that renders sketchy shapes onto an HTML `<canvas>` or `<svg>` in a browser. The output here is a **self-contained `.html` file**, and the PlantUML setup / jar / PNG-inspection pipeline in `SKILL.md` **does not apply**. This file carries its own build and verification workflow. Do not run `plantuml.jar` on Rough.js output.

## When to Use Rough.js

- Hand-drawn / whiteboard-style boxes, circles, arrows, connectors
- **Annotations over an existing visual**, screenshot, photo, chart, or diagram: circle a region, point an arrow, underline, strike-through, bracket, add a margin note
- Sketchy callouts and highlights that should read as informal / draft / human-made
- Any figure where a precise, machine-drawn look would feel too formal and a hand-sketched look communicates "note", "idea", or "in-progress"

Prefer PlantUML (the other sub-files) when the user wants a **precise, structured, declarative** diagram (architecture, sequence, hierarchy, process). Rough.js is for the *sketchy* register, not for rigor.

## What Rough.js Is

Rough.js is the rendering engine behind Excalidraw's hand-drawn look. It draws each primitive with multiple slightly-offset strokes so straight lines wobble and fills look scribbled. It has two back-ends:

- **Canvas**, `rough.canvas(canvasEl)` → draws immediately onto a `<canvas>` 2D context. Best for annotating raster content (screenshots, photos) and for interactivity.
- **SVG**, `rough.svg(svgEl)` → returns `<g>` nodes you append to an `<svg>`. Best for crisp, zoomable, DOM-inspectable output.

Both expose the same drawing methods and options.

## Setup, Vendor the Library (offline / CSP constraint)

Rough.js must be **inlined**, not linked from a CDN:
- Published Artifacts run under a strict CSP that blocks every external host (no `<script src="…cdn…">`).
- The build environment may have no network in the sandboxed shell.

Download the UMD bundle once (network needs sandbox off), then inline its contents into the HTML:

```bash
# UMD build, defines a global `rough`. Pin a version.
D="$CLAUDE_JOB_DIR/tmp"   # or any scratch dir
curl -k -sL -o "$D/rough.js" 'https://unpkg.com/roughjs@4.6.6/bundled/rough.js'
ls -lh "$D/rough.js"      # ~28KB
```

> If `curl` fails on TLS, add `-k` (this environment intercepts TLS). If there is genuinely no network, ask the user to run the `curl` with a `!` prefix so it runs in their shell.

Splice it into a template that has an `__ROUGHJS__` placeholder inside a `<script>` tag:

```bash
python3 - template.html "$D/rough.js" out.html <<'PY'
import sys
tmpl, rough, out = sys.argv[1:4]
html = open(tmpl, encoding='utf-8').read()
js   = open(rough, encoding='utf-8').read()
assert '</script>' not in js, "rough.js contains </script>, would break inlining"
assert '__ROUGHJS__' in html, "placeholder missing"
open(out, 'w', encoding='utf-8').write(html.replace('__ROUGHJS__', js))
PY
```

See [template.html](template.html) for a ready, goal-agnostic scaffold (theme-aware, DPR-scaled, with annotation helpers).

## Core API

```js
const rc = rough.canvas(document.getElementById('c'));   // or rough.svg(svgEl)

rc.line(x1, y1, x2, y2, options);
rc.rectangle(x, y, w, h, options);
rc.ellipse(cx, cy, w, h, options);
rc.circle(cx, cy, diameter, options);
rc.linearPath([[x1,y1],[x2,y2],[x3,y3]], options);   // open polyline
rc.polygon([[x1,y1],[x2,y2],[x3,y3]], options);      // closed
rc.arc(cx, cy, w, h, startAngleRad, stopAngleRad, closed, options);
rc.curve([[x1,y1],[x2,y2],[x3,y3]], options);        // smooth through points
rc.path('M10 10 C …', options);                       // SVG path data
```

### Options (the ones that matter)

| Option | Effect | Typical |
|--------|--------|---------|
| `roughness` | how sketchy. 0 = precise, 1 = default, 3+ = very scribbly | `1.2`–`1.8` for annotations |
| `bowing` | how much straight lines bow out | `1`–`1.5` |
| `stroke` | line color | any CSS color |
| `strokeWidth` | line thickness | `1.5`–`2.6` |
| `fill` | fill color | use with a `fillStyle` |
| `fillStyle` | `hachure` (default), `solid`, `zigzag`, `cross-hatch`, `dots`, `dashed`, `zigzag-line` | `hachure` |
| `fillWeight` | thickness of hachure strokes | `0.5`–`1.5` |
| `hachureGap` | spacing between hachure lines | `8`–`18` |
| `hachureAngle` | angle of hachure fill | `-41` default |
| `seed` | fixed integer → identical sketch every redraw | see below |
| `strokeLineDash` | dashed outline, e.g. `[8,6]` | for "draft" borders |

### Stable redraws, always set a `seed`

Rough.js randomizes stroke offsets each call. If you redraw (theme switch, resize, animation) **without a fixed seed, the sketch reshuffles and flickers**. Assign one seed per figure and reuse it:

```js
const SEED = 42;                       // any fixed integer; or rough.newSeed() once, then store it
rc.rectangle(x, y, w, h, { seed: SEED, roughness: 1.5, stroke });
```

## Annotation Primitives (goal-agnostic helpers)

These are the reusable building blocks for annotating anything. They take a `RoughCanvas` and coordinates, no assumption about what is being annotated.

```js
// Arrow: line with a hand-drawn head at (x2,y2)
function arrow(rc, x1, y1, x2, y2, o = {}) {
  const c = o.stroke || '#e8590c', s = o.head || 12, seed = o.seed || 1;
  const a = Math.atan2(y2 - y1, x2 - x1);
  rc.line(x1, y1, x2, y2, { roughness: 1.3, strokeWidth: 2, stroke: c, seed });
  rc.line(x2, y2, x2 - s * Math.cos(a - 0.4), y2 - s * Math.sin(a - 0.4), { roughness: 1, strokeWidth: 2, stroke: c, seed });
  rc.line(x2, y2, x2 - s * Math.cos(a + 0.4), y2 - s * Math.sin(a + 0.4), { roughness: 1, strokeWidth: 2, stroke: c, seed });
}

// Ring: circle/ellipse drawn AROUND a target region to call it out
function ring(rc, cx, cy, w, h, o = {}) {
  rc.ellipse(cx, cy, w, h, { roughness: 1.6, strokeWidth: 2.4, stroke: o.stroke || '#e8590c', seed: o.seed || 2 });
}

// Box highlight: rough rectangle around a region (optionally faint fill)
function box(rc, x, y, w, h, o = {}) {
  rc.rectangle(x, y, w, h, {
    roughness: 1.5, strokeWidth: 2, stroke: o.stroke || '#4263eb',
    fill: o.fill, fillStyle: 'hachure', hachureGap: 14, fillWeight: 0.8, seed: o.seed || 3
  });
}

// Marker underline: a low, wobbly line under a span (x..x+w at baseline y)
function underline(rc, x, y, w, o = {}) {
  rc.line(x, y, x + w, y, { roughness: 2.2, bowing: 2, strokeWidth: 3, stroke: o.stroke || '#f59f00', seed: o.seed || 4 });
}

// Strike-through
function strike(rc, x, y, w, o = {}) {
  rc.line(x, y, x + w, y, { roughness: 1.4, strokeWidth: 2, stroke: o.stroke || '#e03131', seed: o.seed || 5 });
}

// Leader line: connect an annotation to a margin note
function leader(rc, x1, y1, x2, y2, o = {}) {
  rc.linearPath([[x1, y1], [(x1 + x2) / 2, y1], [x2, y2]], { roughness: 1.2, strokeWidth: 1.6, stroke: o.stroke || '#868e96', seed: o.seed || 6 });
}
```

Compose these; do not hard-code any subject into them.

## Text, Rough.js Does Not Draw It

Rough.js renders **shapes only**. Labels and notes are drawn separately:

- **On canvas:** `ctx.fillText(...)`. Rough.js draws no text, so use the same 2D context. Canvas has no auto-wrap, wrap manually (`ctx.measureText`).
- **On SVG:** append `<text>` elements.

For a hand-drawn *feel* in the text itself, use a handwriting font. Two CSP-safe options:

1. **System handwriting stack** (zero bytes, but may fall back to a generic face on machines that lack these):
   ```css
   font-family: "Comic Sans MS","Chalkboard SE","Segoe Print","Bradley Hand",cursive;
   ```
2. **Inlined handwriting webfont** (guaranteed look, costs a few KB), embed as a `@font-face` `data:` URI. Excalidraw's own font is **Virgil**; any open handwriting font works. Never link a font CDN, the Artifact CSP blocks it and you get a silent fallback.

```css
@font-face{
  font-family:"Sketch";
  src:url("data:font/woff2;base64,<BASE64>") format("woff2");
  font-display:swap;
}
```

Trade-off: option 1 keeps the file tiny but the text look is machine-dependent; option 2 guarantees the hand-drawn text everywhere. State which you used when reporting.

## Rendering Targets

### A) Standalone self-contained HTML (default)

One `.html` with Rough.js inlined, any font inlined, and your draw script. Opens in any browser and works as an Artifact. Prefer this.

**Crispness, scale for devicePixelRatio:**
```js
const dpr = Math.max(1, Math.min(3, window.devicePixelRatio || 1));
cv.width = W * dpr; cv.height = H * dpr;          // backing store
cv.style.width = W + 'px'; cv.style.height = H + 'px';
ctx.setTransform(dpr, 0, 0, dpr, 0, 0);           // draw in design coords
```

**Responsive:** keep a fixed design size (`W`×`H`) and put the canvas in a container with `overflow-x:auto` so the page body never scrolls sideways. Do not squash the canvas below legibility.

**Theme-aware:** a canvas cannot read CSS variables. Keep a light and a dark palette object in JS, pick by theme, and **redraw** on change. Watch all three signals:
```js
function themeNow(){ const a=document.documentElement.getAttribute('data-theme');
  return a || (matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light'); }
matchMedia('(prefers-color-scheme:dark)').addEventListener('change', draw);
new MutationObserver(draw).observe(document.documentElement,{attributes:true,attributeFilter:['data-theme']});
```
Reuse a fixed `seed` so redraws don't reshuffle the sketch (see above).

### B) Publishing as an Artifact

Use the `Artifact` tool on the `.html` file. Requirements enforced by CSP: Rough.js inlined, fonts inlined, no external requests. Write the file in Artifact content form (no `<html>/<head>/<body>` wrapper) if publishing; keep a full-document version if the user also wants to open it locally.

### C) Overlay annotations on an existing visual

To annotate a screenshot, photo, chart, or another diagram without redrawing it:

```html
<div class="stage" style="position:relative;display:inline-block">
  <img id="base" src="data:image/png;base64,…" alt="…">   <!-- inline the image for CSP -->
  <canvas id="ann" style="position:absolute;inset:0;pointer-events:none"></canvas>
</div>
```
```js
const img = document.getElementById('base'), cv = document.getElementById('ann');
function fit(){ cv.width = img.clientWidth*dpr; cv.height = img.clientHeight*dpr;
  cv.style.width=img.clientWidth+'px'; cv.style.height=img.clientHeight+'px';
  ctx.setTransform(dpr,0,0,dpr,0,0); draw(); }
img.complete ? fit() : img.addEventListener('load', fit);
```
Draw annotations in the image's coordinate space. This is fully goal-agnostic, the underlying visual can be anything.

## Verification (replaces PlantUML validation)

There is no parser to validate against. Verify by **rendering and looking**:

1. **Confirm the library loaded**, grep the built file for `var rough=function` and for your draw code marker.
2. **Render it**, either publish via the `Artifact` tool and view it, or open the local `.html` with the browser MCP and screenshot it.
3. **Read the screenshot** with the Read tool and check: shapes render with the sketchy stroke, nothing overflows the canvas, text is legible and not buried under a hachure fill, both themes read correctly.
4. **Report** which render target and which font option were used.

There is no PNG to delete and no `plantuml.jar` step here.

## Best Practices

- **One accent, used sparingly.** Annotations shout; if everything is circled and arrowed, nothing stands out. Keep the base quiet, mark only what matters.
- **Roughness 1.2–1.8** reads as "hand-drawn" without looking broken. Above ~2.5 gets noisy; use it only for emphatic marks (a scribbled underline).
- **Never put a busy hachure fill behind text**, it destroys legibility. Use a very low `fillWeight` / wide `hachureGap`, or no fill and a colored outline instead.
- **Set a `seed`** on every shape so redraws are stable.
- **Keep annotation helpers subject-free.** Pass colors and coordinates in; never bake a specific figure into a helper.
- **Semantic annotation colors** (a red strike, an amber highlight, a blue box) carry meaning, keep them consistent within one figure.

## Common Pitfalls

| Symptom | Cause | Fix |
|---------|-------|-----|
| Blank canvas in a published Artifact | `<script src>` to a CDN blocked by CSP | Inline the Rough.js bundle |
| Inlining breaks the page | Inlined JS contained `</script>` | Assert it does not before splicing (the minified bundle does not) |
| Sketch flickers / changes on redraw | No fixed `seed` | Assign one seed per shape and reuse |
| Blurry lines | Drawn at CSS size, not device pixels | Scale by `devicePixelRatio`, `setTransform` |
| Text look is machine-dependent | System handwriting font fell back | Inline a handwriting webfont as a data URI |
| Text unreadable | Hachure fill drawn behind labels | Remove/lighten fill under text |
| Page scrolls sideways | Oversized canvas on the body | Wrap canvas in an `overflow-x:auto` container |
| Colors wrong in dark mode | Canvas can't use CSS vars | Keep JS palettes per theme, redraw on change |

## Reference

- Rough.js API: https://github.com/rough-js/rough/wiki
- Excalidraw (the reference aesthetic): https://excalidraw.com
