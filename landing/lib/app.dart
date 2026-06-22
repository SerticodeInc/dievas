import 'package:jaspr/server.dart';
import 'package:jaspr/dom.dart';

import 'components/architecture_section.dart';
import 'components/components_section.dart';
import 'components/footer.dart';
import 'components/hero.dart';
import 'components/manifesto_section.dart';
import 'components/nav.dart';

// Shared animation CSS inlined into <head> so scroll-reveal and reduced-motion
// rules fire regardless of whether hero.css / output.css have loaded.
// Hero-specific entry animations (word-in, chip-fall, gradient-mesh) live in
// hero.css — this block owns only cross-section concerns.
const _inlineAnimationStyles = '''<style>
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
///   1. Hero — above-the-fold, gradient mesh, glassmorphism
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
