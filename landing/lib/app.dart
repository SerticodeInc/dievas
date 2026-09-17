import 'package:jaspr/server.dart';
import 'package:jaspr/dom.dart';

import 'components/chapters.dart';
import 'components/closing.dart';
import 'components/craft_section.dart';
import 'components/footer.dart';
import 'components/hero.dart';
import 'components/nav.dart';
import 'components/theme_section.dart';

/// Root document. Renders the complete v1 landing page.
///
/// Theming: an inline head script applies `data-theme` (light default,
/// persisted) before paint — no FOUC. All interaction on the page is
/// driven by the vanilla JS bundle at the end of [body]; no @client
/// hydration exists anywhere on the site.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) => Document(
    title: 'Dievas | Flutter Design System',
    lang: 'en',
    meta: const {
      'description':
          'Dievas. The Flutter design system that ships tokens, components, '
          'and themes from one layer. InheritedModel-first, multi-brand, '
          'zero hardcoded values. Production components built from the token '
          'layer up.',
    },
    head: [
      meta(
        name: 'theme-color',
        content: '#f8fafc',
        attributes: const {'id': 'theme-color'},
      ),
      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(
        rel: 'preconnect',
        href: 'https://fonts.gstatic.com',
        attributes: const {'crossorigin': ''},
      ),
      link(
        rel: 'stylesheet',
        href:
            'https://fonts.googleapis.com/css2?family=DM+Mono:wght@300;400;500&display=swap',
      ),
      link(rel: 'stylesheet', href: '/output.css'),
      link(rel: 'stylesheet', href: '/base.css'),
      link(rel: 'stylesheet', href: '/nav.css'),
      link(rel: 'stylesheet', href: '/hero.css'),
      link(rel: 'stylesheet', href: '/stage.css'),
      link(rel: 'stylesheet', href: '/chapters.css'),
      link(rel: 'stylesheet', href: '/theme_section.css'),
      link(rel: 'stylesheet', href: '/craft.css'),
      link(rel: 'stylesheet', href: '/closing.css'),
      link(rel: 'stylesheet', href: '/footer.css'),
      link(rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg'),
      RawText(_themeInitScript),
    ],
    body: const _AppBody(),
  );
}

/// Runs in the document head, before paint: applies the saved theme
/// (or the light default), and flags JS availability so reveal styles
/// only hide content when scripts can restore it.
const _themeInitScript = '''<script>
(function(){
  var root = document.documentElement;
  var saved = null;
  try { saved = localStorage.getItem('dievas-theme'); } catch (e) {}
  root.dataset.theme = (saved === 'dark' || saved === 'light') ? saved : 'light';
  root.classList.add('js-on');
})();
</script>''';

// First paint gate — CSS entrance animations begin from their hidden
// initial state only once the browser has painted frame one.
const _jsLoadedScript = '''<script>
(function(){
  requestAnimationFrame(function(){
    document.body.classList.add('js-loaded');
  });
})();
</script>''';

/// The landing's single interaction layer.
///
/// Order matters: scroll reveals and press states wire up first so no
/// content can remain hidden if a later module throws. Each module is
/// scoped to its own selector.
const _interactionsScript = '''<script>
(function(){
  'use strict';
  var reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var root = document.documentElement;
  var SHEETS = { light: '#f8fafc', dark: '#171717' };

  /* ── Shared resolvers ────────────────────────────────────── */
  // Resolve a --dv-* variable from the nearest data-theme scope so
  // scoped surfaces (stage window, theme-wall cards) read their own sheet.
  function themeContext(el) {
    var c = el;
    while (c && c.parentElement) {
      if (c.hasAttribute('data-theme')) return c;
      c = c.parentElement;
    }
    return document.documentElement;
  }
  function resolveVar(el, prop) {
    var v = getComputedStyle(themeContext(el)).getPropertyValue(prop);
    return v ? v.trim() : '';
  }

  /* ── 1 · Scroll reveals ──────────────────────────────────── */
  var io = new IntersectionObserver(function(entries){
    entries.forEach(function(e){
      if (e.isIntersecting) {
        e.target.classList.add('is-in');
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -5% 0px' });
  document.querySelectorAll('.sr').forEach(function(el){ io.observe(el); });

  /* ── 2 · Press states (guarded by reduced-motion) ────────── */
  if (!reduce) {
    document.addEventListener('pointerdown', function(e){
      var p = e.target.closest && e.target.closest('.press');
      if (!p) return;
      p.classList.add('is-pressing');
      var done = function(){ p.classList.remove('is-pressing'); };
      p.addEventListener('pointerup', done, { once: true });
      p.addEventListener('pointercancel', done, { once: true });
      p.addEventListener('pointerleave', done, { once: true });
    });
  }

  /* ── 3 · Theme (site-wide) ───────────────────────────────── */
  function applyTheme(theme) {
    root.dataset.theme = theme;
    var meta = document.getElementById('theme-color');
    if (meta) meta.setAttribute('content', SHEETS[theme] || SHEETS.light);
    try { localStorage.setItem('dievas-theme', theme); } catch (e) {}
    document.dispatchEvent(new CustomEvent('dievas:theme', { detail: theme }));
  }
  document.querySelectorAll('[data-theme-toggle]').forEach(function(btn){
    btn.addEventListener('click', function(){
      applyTheme(root.dataset.theme === 'dark' ? 'light' : 'dark');
    });
  });

  /* ── 4 · Stage — scoped theme + tabs + switches ──────────── */
  var stage = document.querySelector('[data-stage]');
  var stageLabel = null;
  function setStageLabel(text) {
    var el = document.querySelector('[data-stage-label]');
    if (el) el.textContent = text;
  }
  if (stage) {
    document.querySelectorAll('[data-stage-theme]').forEach(function(btn){
      btn.addEventListener('click', function(){
        stage.dataset.theme = stage.dataset.theme === 'dark' ? 'light' : 'dark';
        setStageLabel('scoped sheet: ' + stage.dataset.theme);
      });
    });
  }
  /* Sliding tab indicator — one bar under the row, sized and moved to
   * the selected tab. Measured against the tab row's own box so the
   * fit survives a resize or a theme swap. The bar only gains its
   * transition once placed, so the first position and the web-font
   * swap correction land instantly rather than sliding in. */
  var stageTabs = stage && stage.querySelector('.stage-tabs');
  var indicator = stageTabs && stageTabs.querySelector('[data-stage-indicator]');
  function moveStageIndicator(tab) {
    if (!indicator || !tab) return;
    indicator.style.width = tab.offsetWidth + 'px';
    indicator.style.transform = 'translateX(' + tab.offsetLeft + 'px)';
  }
  function syncStageIndicator() {
    var active = null;
    document.querySelectorAll('[data-stage-tab]').forEach(function(t){
      if (t.getAttribute('aria-selected') === 'true') active = t;
    });
    moveStageIndicator(active);
  }
  if (stageTabs) {
    syncStageIndicator();
    var armIndicator = function(){
      if (reduce) return;
      requestAnimationFrame(function(){ stageTabs.classList.add('is-ready'); });
    };
    if (document.fonts && document.fonts.ready) {
      document.fonts.ready.then(function(){ syncStageIndicator(); armIndicator(); });
    } else {
      armIndicator();
    }
    window.addEventListener('resize', syncStageIndicator);
    document.addEventListener('dievas:theme', syncStageIndicator);
  }

  document.querySelectorAll('[data-stage-tab]').forEach(function(tab){
    tab.addEventListener('click', function(){
      var name = tab.dataset.stageTab;
      document.querySelectorAll('[data-stage-tab]').forEach(function(t){
        t.setAttribute('aria-selected', t === tab ? 'true' : 'false');
      });
      moveStageIndicator(tab);
      document.querySelectorAll('[data-stage-panel]').forEach(function(panel){
        if (panel.dataset.stagePanel === name) {
          panel.removeAttribute('hidden');
        } else {
          panel.setAttribute('hidden', '');
        }
      });
      sizeStageBody();
      setStageLabel(name);
    });
  });

  /* Pin the stage body to the tallest panel so the window holds one
   * height across tabs and the swap is a crossfade, not a jump. All
   * panels are measured at the current width, so the heights match
   * what a panel will occupy when shown. */
  var stageBody = stage && stage.querySelector('.stage-body');
  function stageActivePanel() {
    var panels = stageBody ? stageBody.querySelectorAll('[data-stage-panel]') : [];
    for (var i = 0; i < panels.length; i++) {
      if (!panels[i].hasAttribute('hidden')) return panels[i];
    }
    return panels[0];
  }
  function sizeStageBody() {
    if (!stageBody) return;
    var active = stageActivePanel();
    stageBody.querySelectorAll('[data-stage-panel]').forEach(function(panel){
      if (panel.hidden) panel.hidden = false;
      var h = panel.offsetHeight;
      if (h > stageBody._maxH) stageBody._maxH = h;
      panel._h = h;
    });
    stageBody.style.minHeight = Math.max(stageBody._maxH || 0, 400) + 'px';
    stageBody.querySelectorAll('[data-stage-panel]').forEach(function(panel){
      if (panel !== active) panel.hidden = true;
    });
  }
  if (stageBody) {
    stageBody._maxH = 0;
    if (!reduce) sizeStageBody();
    window.addEventListener('resize', function(){ stageBody._maxH = 0; sizeStageBody(); });
    document.addEventListener('dievas:theme', function(){ stageBody._maxH = 0; sizeStageBody(); });
  }
  var rebuildCounter = 0;
  document.querySelectorAll('[data-di-switch]').forEach(function(sw){
    sw.addEventListener('click', function(){
      var on = sw.getAttribute('aria-pressed') === 'true';
      sw.setAttribute('aria-pressed', on ? 'false' : 'true');
      sw.classList.toggle('is-on', !on);
      if (stage && stage.contains(sw)) {
        rebuildCounter += 1;
        setStageLabel('scoped rebuild → switch · ' + rebuildCounter);
      }
    });
  });
  document.querySelectorAll('[data-acc-head]').forEach(function(head){
    head.addEventListener('click', function(){
      var open = head.getAttribute('aria-expanded') === 'true';
      head.setAttribute('aria-expanded', open ? 'false' : 'true');
      if (stage && stage.contains(head)) {
        setStageLabel('accordion · ' + (open ? 'collapsed' : 'expanded'));
      }
    });
  });
  document.querySelectorAll('.dots').forEach(function(dots){
    dots.querySelectorAll('[data-di-dot]').forEach(function(dot, i){
      dot.addEventListener('click', function(){
        dots.querySelectorAll('[data-di-dot]').forEach(function(d){
          d.classList.toggle('is-active', d === dot);
          d.setAttribute('aria-current', d === dot ? 'true' : 'false');
        });
        if (stage && stage.contains(dots)) {
          setStageLabel('dot indicator · step ' + (i + 1));
        }
      });
    });
  });

  /* ── 5 · Nav compact + hide + scroll progress ────────────── */
  var nav = document.getElementById('site-nav');
  var navInner = nav && nav.querySelector('.nav-pill');
  var progress = document.createElement('div');
  progress.className = 'scroll-progress';
  document.body.appendChild(progress);
  var lastY = window.scrollY, ticking = false, wasHiding = false;
  var HEAD = 80, HIDE_DELTA = 56;
  function onScroll(){
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(function(){
      var y = window.scrollY;
      var h = document.documentElement;
      progress.style.width = (h.scrollHeight > h.clientHeight)
        ? ((h.scrollTop / (h.scrollHeight - h.clientHeight)) * 100) + '%' : '0%';
      if (nav) {
        if (y <= HEAD) {
          nav.classList.remove('is-hidden');
          nav.classList.remove('is-compact');
          wasHiding = false;
        } else {
          if (navInner) navInner.classList.toggle('is-scrolled', y > HEAD);
          if (y - lastY > HIDE_DELTA) {
            nav.classList.add('is-hidden');
            wasHiding = true;
          } else if (lastY - y > HIDE_DELTA) {
            nav.classList.remove('is-hidden');
          }
        }
      }
      lastY = y;
      ticking = false;
    });
  }
  window.addEventListener('scroll', onScroll, { passive: true });

  /* ── 6 · Chapter 02 · aspect picker + rebuild readout ────── */
  var aspect = 'text';
  document.querySelectorAll('[data-aspect-trigger]').forEach(function(btn){
    btn.addEventListener('click', function(){
      aspect = btn.dataset.aspectTrigger;
      document.querySelectorAll('[data-aspect-trigger]').forEach(function(b){
        b.setAttribute('aria-pressed', b === btn ? 'true' : 'false');
      });
    });
  });
  document.querySelectorAll('[data-di-touch]').forEach(function(btn){
    btn.addEventListener('click', function(){
      var row = btn.closest('.rebuild-well').querySelector(
        '.rebuild-item[data-rebuild-count="' + aspect + '"]'
      );
      if (!row) return;
      row.classList.add('is-touched');
      var count = row.querySelector('b');
      count.textContent = String(parseInt(count.textContent, 10) + 1);
    });
  });

  /* ── 7 · Chapter 04 · brand switcher ─────────────────────── */
  var brandDemo = document.querySelector('[data-brand-demo]');
  document.querySelectorAll('[data-brand-trigger]').forEach(function(btn){
    btn.addEventListener('click', function(){
      document.querySelectorAll('[data-brand-trigger]').forEach(function(b){
        b.setAttribute('aria-pressed', b === btn ? 'true' : 'false');
      });
      if (brandDemo) brandDemo.dataset.brand = btn.dataset.brandTrigger;
    });
  });

  /* ── 8 · Chapter 03 · component state switcher ───────────── */
  var stateDemo = document.querySelector('[data-state-demo]');
  document.querySelectorAll('[data-state-trigger]').forEach(function(btn){
    btn.addEventListener('click', function(){
      document.querySelectorAll('[data-state-trigger]').forEach(function(b){
        b.setAttribute('aria-pressed', b === btn ? 'true' : 'false');
      });
      if (stateDemo) stateDemo.dataset.state = btn.dataset.stateTrigger;
    });
  });

  /* ── 9 · Copy chips ──────────────────────────────────────── */
  /* A `--dv-*` custom property resolves to its computed value; any other
   * string is a Dart symbol, so it copies verbatim. */
  document.querySelectorAll('[data-di-copy]').forEach(function(chip){
    chip.addEventListener('click', function(){
      var prop = chip.dataset.diCopy;
      var value = prop.charAt(1) === '-' ? resolveVar(chip, prop) : prop;
      if (navigator.clipboard && value) {
        navigator.clipboard.writeText(value)['catch'](function(){});
      }
      chip.classList.add('is-copied');
      setTimeout(function(){ chip.classList.remove('is-copied'); }, 1200);
    });
  });

  /* ── 10 · Footer GitHub star count ───────────────────────── */
  /* The repo is public, so the API needs no token. Fill the glass
   * pill client-side; on any failure it stays at the ghost "…". */
  var starCount = document.querySelector('.star-count');
  if (starCount) {
    var pill = starCount.parentElement;
    fetch('https://api.github.com/repos/SerticodeInc/dievas')
      .then(function(r){ return r.ok ? r.json() : null; })
      .then(function(d){
        if (d && typeof d.stargazers_count === 'number') {
          starCount.textContent = d.stargazers_count.toLocaleString('en-US');
        }
      })['catch'](function(){})
      .then(function(){ pill.classList.add('is-loaded'); });
  }

  /* ── 11 · Chapters backdrop · reactive dot matrix ────────── */
  /* A grid of dots on canvas. The far field shimmers idly; dots within
   * RADIUS of the pointer bloom brand-coloured. Colours are resolved from
   * the page sheet at build time — canvas cannot consume var(). RAF only
   * runs while the section is on screen. */
  var matrix = document.querySelector('[data-chapter-matrix]');
  if (matrix) {
    var GRID = 46;
    var RADIUS = 190;
    var ctx = matrix.getContext('2d');
    var dots = [], w = 0, h = 0, col = { base: '', brand: '' };
    var px = -9999, py = -9999;
    var visible = false, raf = null;

    function build() {
      var rect = matrix.getBoundingClientRect();
      var dpr = Math.min(window.devicePixelRatio || 1, 2);
      w = rect.width;
      h = rect.height;
      matrix.width = Math.round(w * dpr);
      matrix.height = Math.round(h * dpr);
      if (ctx) ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      col = {
        base: resolveVar(matrix, '--dv-border-hi'),
        brand: resolveVar(matrix, '--dv-brand'),
      };
      dots = [];
      for (var y = GRID / 2; y < h; y += GRID) {
        for (var x = GRID / 2; x < w; x += GRID) {
          dots.push({ x: x, y: y, ph: Math.random() * Math.PI * 2, near: 0 });
        }
      }
    }

    function frame(t) {
      if (!visible) { raf = null; return; }
      if (!ctx) return;
      var now = t / 1000;
      ctx.clearRect(0, 0, w, h);
      ctx.fillStyle = col.base;
      for (var i = 0; i < dots.length; i++) {
        var d = dots[i];
        var dx = d.x - px, dy = d.y - py;
        var dist = Math.sqrt(dx * dx + dy * dy);
        d.near = dist < RADIUS ? 1 - dist / RADIUS : 0;
        if (d.near > 0.05) continue;
        var idle = (Math.sin(now * 1.6 + d.ph) + 1) / 2;
        ctx.globalAlpha = 0.09 + idle * 0.11;
        ctx.beginPath();
        ctx.arc(d.x, d.y, 1, 0, Math.PI * 2);
        ctx.fill();
      }
      ctx.fillStyle = col.brand;
      for (var j = 0; j < dots.length; j++) {
        var e = dots[j];
        if (e.near <= 0.05) continue;
        var idle2 = (Math.sin(now * 1.6 + e.ph) + 1) / 2;
        ctx.globalAlpha = 0.18 + e.near * 0.62 + idle2 * 0.06;
        ctx.beginPath();
        ctx.arc(e.x, e.y, 1 + e.near * 2.4, 0, Math.PI * 2);
        ctx.fill();
      }
      ctx.globalAlpha = 1;
      raf = requestAnimationFrame(frame);
    }

    function start() { if (raf == null) raf = requestAnimationFrame(frame); }

    if (!reduce) {
      build();
      var mio = new IntersectionObserver(function(entries){
        entries.forEach(function(e){
          visible = e.isIntersecting;
          if (visible) { build(); start(); }
        });
      }, { threshold: 0 });
      mio.observe(matrix);
      window.addEventListener('pointermove', function(e){
        var rect = matrix.getBoundingClientRect();
        px = e.clientX - rect.left;
        py = e.clientY - rect.top;
        start();
      }, { passive: true });
      window.addEventListener('resize', build);
      document.addEventListener('dievas:theme', build);
    }
  }
})();
</script>''';

/// Body — page flow:
///   1. Hero — display claim + Component Stage
///   2. Chapters — five evidence chapters
///   3. ThemeSection — light/dark twin sheets
///   4. CraftSection — four craft rows
///   5. Closing — brand glow easing into the footer
///   6. Footer — ghost wordmark
class _AppBody extends StatelessComponent {
  const _AppBody();

  @override
  Component build(BuildContext context) => div(id: 'main', [
    RawText(_jsLoadedScript),
    const Nav(),
    const Hero(),
    const Chapters(),
    const ThemeSection(),
    const CraftSection(),
    const Closing(),
    const FooterComponent(),
    RawText(_interactionsScript),
  ]);
}
