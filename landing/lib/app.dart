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

/* Scroll-triggered reveal */
.reveal {
  opacity: 0;
  transform: translateY(22px);
  transition: opacity 0.8s cubic-bezier(0.22, 1, 0.36, 1),
              transform 0.8s cubic-bezier(0.22, 1, 0.36, 1);
}
.reveal.is-visible {
  opacity: 1;
  transform: translateY(0);
}

.reveal-group > * {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.7s cubic-bezier(0.22, 1, 0.36, 1),
              transform 0.7s cubic-bezier(0.22, 1, 0.36, 1);
}
.reveal-group.is-visible > * { opacity: 1; transform: translateY(0); }
.reveal-group.is-visible > *:nth-child(2) { transition-delay: 0.1s; }
.reveal-group.is-visible > *:nth-child(3) { transition-delay: 0.2s; }
.reveal-group.is-visible > *:nth-child(4) { transition-delay: 0.3s; }
.reveal-group.is-visible > *:nth-child(5) { transition-delay: 0.4s; }

@media (prefers-reduced-motion: reduce) {
  .word-in, .chip-falling { opacity: 1; }
  .js-loaded .word-in      { animation: none; opacity: 1; }
  .js-loaded .chip-falling { animation: none; opacity: 1; }
  .js-loaded .marquee-track { animation: none; }
  .reveal, .reveal-group > * { opacity: 1; transform: none; transition: none; }
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
    title: 'Dievas — Flutter Design System',
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

// Scroll-reveal IntersectionObserver — fires `.is-visible` on `.reveal` and
// `.reveal-group` elements as they enter the viewport (Anchor-style stagger).
const _scrollRevealScript = '''<script>
(function(){
  var io = new IntersectionObserver(function(entries){
    entries.forEach(function(e){
      if(e.isIntersecting){
        e.target.classList.add('is-visible');
        io.unobserve(e.target);
      }
    });
  },{threshold:0.12});
  document.querySelectorAll('.reveal,.reveal-group').forEach(function(el){
    io.observe(el);
  });
})();
</script>''';

const _navScrollScript = '''<script>
(function(){
  var nav=document.getElementById('site-nav');
  if(!nav)return;
  var lastY=window.scrollY,ticking=false,deadZone=16,topZone=80;
  window.addEventListener('scroll',function(){
    if(ticking)return;
    ticking=true;
    requestAnimationFrame(function(){
      var y=window.scrollY;
      if(y<topZone){
        nav.style.transform='translateY(0)';
      }else if(y-lastY>deadZone){
        nav.style.transform='translateY(-130%)';
      }else if(lastY-y>deadZone){
        nav.style.transform='translateY(0)';
      }
      lastY=y;
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
    const Nav(),
    const Hero(),
    const ManifestoSection(),
    const ArchitectureSection(),
    div(attributes: const {'style': 'background: #FFFFFF;'}, [const ComponentsSection(), const FooterComponent()]),
    RawText(_scrollRevealScript),
    RawText(_navScrollScript),
  ]);
}
