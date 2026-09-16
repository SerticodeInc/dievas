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
      meta(name: 'theme-color', content: '#f8fafc', attributes: const {'id': 'theme-color'}),
      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(rel: 'preconnect', href: 'https://fonts.gstatic.com', attributes: const {'crossorigin': ''}),
      link(rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=DM+Mono:wght@300;400;500&display=swap'),
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
  var SHEETS = { light: '#f8fafc', dark: '#020617' };

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
  }, { threshold: 0.18, rootMargin: '0px 0px -8% 0px' });
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
  document.querySelectorAll('[data-stage-tab]').forEach(function(tab){
    tab.addEventListener('click', function(){
      var name = tab.dataset.stageTab;
      document.querySelectorAll('[data-stage-tab]').forEach(function(t){
        t.setAttribute('aria-selected', t === tab ? 'true' : 'false');
      });
      document.querySelectorAll('[data-stage-panel]').forEach(function(panel){
        if (panel.dataset.stagePanel === name) {
          panel.removeAttribute('hidden');
        } else {
          panel.setAttribute('hidden', '');
        }
      });
      setStageLabel(name);
    });
  });
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
})();
</script>''';

/// Body — page flow:
///   1. Hero — display claim + Component Stage
///   2. Chapters — five evidence chapters
///   3. ThemeSection — light/dark twin sheets
///   4. CraftSection — four craft rows
///   5. Closing — the install island
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