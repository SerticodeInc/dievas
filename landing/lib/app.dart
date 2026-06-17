import 'package:jaspr/server.dart';
import 'package:jaspr/dom.dart';

import 'components/architecture_section.dart';
import 'components/components_section.dart';
import 'components/footer.dart';
import 'components/hero.dart';
import 'components/manifesto_section.dart';
import 'components/nav.dart';

// Animation CSS inlined directly into <head> so it's always present regardless
// of whether output.css (Tailwind compiled output) has been rebuilt.
// This is the authoritative source for all Anchor-style animation rules.
const _inlineAnimationStyles = '''<style>
@keyframes word-in {
  from {
    opacity: 0;
    transform: perspective(1200px) rotateX(-30deg) translateY(12px);
  }
  to {
    opacity: 1;
    transform: perspective(1200px) rotateX(0deg) translateY(0);
  }
}

@keyframes chip-fall {
  0% {
    opacity: 0;
    transform: perspective(900px) rotateX(-22deg) translateY(-56px) scale(0.96);
  }
  65% {
    transform: perspective(900px) rotateX(1.5deg) translateY(3px) scale(1.003);
  }
  100% {
    opacity: 1;
    transform: perspective(900px) rotateX(0deg) translateY(0) scale(1);
  }
}

@keyframes marquee {
  from { transform: translateX(0); }
  to   { transform: translateX(-50%); }
}

/* ── DIEVAS watermark letter-drop animation ────────────────────────────────
   Letters fall staggered (~0.16s apart), all landed within ~4s, then hold
   for ~4s before the cycle repeats at 8s.                                    */
@keyframes letter-drop-0 {
  0%   { transform: translateY(-120vh); }
  38%  { transform: translateY(0); }
  100% { transform: translateY(0); }
}
@keyframes letter-drop-1 {
  0%, 2%   { transform: translateY(-120vh); }
  40%      { transform: translateY(0); }
  100%     { transform: translateY(0); }
}
@keyframes letter-drop-2 {
  0%, 4%   { transform: translateY(-120vh); }
  42%      { transform: translateY(0); }
  100%     { transform: translateY(0); }
}
@keyframes letter-drop-3 {
  0%, 6%   { transform: translateY(-120vh); }
  44%      { transform: translateY(0); }
  100%     { transform: translateY(0); }
}
@keyframes letter-drop-4 {
  0%, 8%   { transform: translateY(-120vh); }
  46%      { transform: translateY(0); }
  100%     { transform: translateY(0); }
}
@keyframes letter-drop-5 {
  0%, 10%  { transform: translateY(-120vh); }
  48%      { transform: translateY(0); }
  100%     { transform: translateY(0); }
}

/* Initial state: invisible, laid out. Animations gate on body.js-loaded. */
.word-in {
  display: inline-block;
  opacity: 0;
}

.chip-falling {
  opacity: 0;
}

.marquee-track {
  display: flex;
  width: max-content;
}

.js-loaded .word-in {
  animation: word-in 0.75s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}

.js-loaded .chip-falling {
  animation: chip-fall 0.9s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}

.js-loaded .marquee-track {
  animation: marquee 38s linear infinite;
}

.js-loaded .letter-drop-0 { animation: letter-drop-0 8s cubic-bezier(0.22, 1, 0.36, 1) infinite; }
.js-loaded .letter-drop-1 { animation: letter-drop-1 8s cubic-bezier(0.22, 1, 0.36, 1) infinite; }
.js-loaded .letter-drop-2 { animation: letter-drop-2 8s cubic-bezier(0.22, 1, 0.36, 1) infinite; }
.js-loaded .letter-drop-3 { animation: letter-drop-3 8s cubic-bezier(0.22, 1, 0.36, 1) infinite; }
.js-loaded .letter-drop-4 { animation: letter-drop-4 8s cubic-bezier(0.22, 1, 0.36, 1) infinite; }
.js-loaded .letter-drop-5 { animation: letter-drop-5 8s cubic-bezier(0.22, 1, 0.36, 1) infinite; }

/* Scroll-triggered reveal */
.reveal {
  opacity: 0;
  transform: translateY(22px);
}
.reveal.is-visible {
  opacity: 1;
  transform: translateY(0);
  transition: opacity 0.6s cubic-bezier(0.22, 1, 0.36, 1),
              transform 0.6s cubic-bezier(0.22, 1, 0.36, 1);
}

.reveal-group > * {
  opacity: 0;
  transform: translateY(20px);
}
.reveal-group.is-visible > * {
  opacity: 1;
  transform: translateY(0);
  transition: opacity 0.6s cubic-bezier(0.22, 1, 0.36, 1),
              transform 0.6s cubic-bezier(0.22, 1, 0.36, 1);
}
.reveal-group.is-visible > *:nth-child(2) { transition-delay: 0.06s; }
.reveal-group.is-visible > *:nth-child(3) { transition-delay: 0.12s; }
.reveal-group.is-visible > *:nth-child(4) { transition-delay: 0.18s; }
.reveal-group.is-visible > *:nth-child(5) { transition-delay: 0.24s; }

@media (prefers-reduced-motion: reduce) {
  .word-in, .chip-falling { opacity: 1; }
  .js-loaded .word-in      { animation: none; opacity: 1; }
  .js-loaded .chip-falling { animation: none; opacity: 1; }
  .js-loaded .marquee-track { animation: none; }
  .js-loaded [class*="letter-drop"] { animation: none; }
  .reveal, .reveal-group > * { opacity: 1; transform: none; }
  .reveal.is-visible, .reveal-group.is-visible > * { transition: none; }
}
</style>''';

/// Root document component. Renders the complete HTML page.
///
/// Jaspr server renders this on every request. The client JS bundle hydrates
/// any components annotated with [@client].
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) => Document(
    title: 'Dievas | Flutter Design System',
    lang: 'en',
    meta: const {
      'description':
          'Dievas. A token driven Flutter design system. '
          'InheritedModel first. Multi brand. Zero hardcoded values. '
          'Production ready components built from the token layer up.',
    },
    head: [
      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(rel: 'preconnect', href: 'https://fonts.gstatic.com', attributes: const {'crossorigin': ''}),
      link(rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=DM+Mono:wght@300;400;500&display=swap'),
      link(rel: 'stylesheet', href: '/output.css'),
      link(rel: 'stylesheet', href: '/base.css'),
      link(rel: 'stylesheet', href: '/nav.css'),
      link(rel: 'stylesheet', href: '/hero.css'),
      link(rel: 'stylesheet', href: '/manifesto.css'),
      link(rel: 'stylesheet', href: '/architecture.css'),
      link(rel: 'stylesheet', href: '/components.css'),
      link(rel: 'stylesheet', href: '/footer.css'),
      link(rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg'),
      RawText(_inlineAnimationStyles),
    ],
    body: const _AppBody(),
  );
}

// Single rAF triggers .js-loaded on body after the browser has painted its
// first frame — guarantees CSS animations start from their invisible initial
// state and are actually perceived by the user (fixes SSR animation timing).
const _jsLoadedScript = '''<script>
(function(){
  requestAnimationFrame(function(){
    document.body.classList.add('js-loaded');
  });
})();
</script>''';

// Scroll-reveal IntersectionObserver — fires `.is-visible` on `.reveal`,
// `.reveal-group`, and directional reveal elements as they enter the viewport.
// A 350ms delay ensures the user has settled into the section before motion fires.
const _scrollRevealScript = '''<script>
(function(){
  var REVEAL_DELAY = 350;
  var selectors = '.reveal,.reveal-group,.reveal-left,.reveal-right,.reveal-scale,.reveal-stagger';
  var timers = new WeakMap();
  var io = new IntersectionObserver(function(entries){
    entries.forEach(function(e){
      if(e.isIntersecting){
        var target = e.target;
        var timer = setTimeout(function(){
          target.classList.add('is-visible');
          io.unobserve(target);
          timers.delete(target);
        }, REVEAL_DELAY);
        timers.set(target, timer);
      } else {
        var pending = timers.get(e.target);
        if (pending) {
          clearTimeout(pending);
          timers.delete(e.target);
        }
      }
    });
  },{threshold:0.25});
  document.querySelectorAll(selectors).forEach(function(el){
    io.observe(el);
  });
})();
</script>''';

const _navScrollScript = '''<script>
(function(){
  var nav=document.getElementById('site-nav');
  if(!nav)return;
  var lastY=window.scrollY,ticking=false,deadZone=16,topZone=80;
  var navInner=nav.querySelector('nav');
  window.addEventListener('scroll',function(){
    if(ticking)return;
    ticking=true;
    requestAnimationFrame(function(){
      var y=window.scrollY;
      if(y<topZone){
        nav.style.transform='translateY(0)';
        navInner&&navInner.classList.remove('nav-scrolled');
      }else if(y-lastY>deadZone){
        nav.style.transform='translateY(-130%)';
        navInner&&navInner.classList.add('nav-scrolled');
      }else if(lastY-y>deadZone){
        nav.style.transform='translateY(0)';
        navInner&&navInner.classList.add('nav-scrolled');
      }
      lastY=y;
      ticking=false;
    });
  },{passive:true});
})();
</script>''';

const _scrollProgressScript = '''<script>
(function(){
  var bar=document.createElement('div');
  bar.className='scroll-progress';
  document.body.appendChild(bar);
  var ticking=false;
  window.addEventListener('scroll',function(){
    if(ticking)return;
    ticking=true;
    requestAnimationFrame(function(){
      var h=document.documentElement;
      var p=(h.scrollTop/(h.scrollHeight-h.clientHeight))*100;
      bar.style.width=p+'%';
      ticking=false;
    });
  },{passive:true});
})();
</script>''';

/// Body content — rendered inside [Document]'s [body].
///
/// Page flow:
///   1. Hero — above-the-fold, dark canvas, interactive mock
///   2. ManifestoSection — the problem, before/after code (dark)
///   3. ArchitectureSection — three-layer code pipeline (white)
///   4. ComponentsSection — categorized catalog + CTA (light/indigo gradient)
///   5. Footer
class _AppBody extends StatelessComponent {
  const _AppBody();

  @override
  Component build(BuildContext context) => div(id: 'main', classes: 'bg-bg-base text-text-hi antialiased', [
    RawText(_jsLoadedScript),
    RawText(_scrollProgressScript),
    const Nav(),
    const Hero(),
    const ManifestoSection(),
    const ArchitectureSection(),
    div(attributes: const {'style': 'background: #FFFFFF;'}, [const ComponentsSection(), const FooterComponent()]),
    RawText(_scrollRevealScript),
    RawText(_navScrollScript),
  ]);
}
