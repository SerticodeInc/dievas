import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  testWidgets('title and content colours override the shared foreground independently', (tester) async {
    await tester.pumpWidget(
      const Harness(
        child: DievasModal(
          title: 'Independent heading',
          body: 'Independent body',
          textColour: Colors.green,
          titleColour: Colors.red,
          contentColour: Colors.blue,
        ),
      ),
    );
    expect(tester.widget<Text>(find.text('Independent heading')).style?.color, Colors.red);
    expect(DefaultTextStyle.of(tester.element(find.text('Independent body'))).style.color, Colors.blue);
    await tester.pumpWidget(
      Harness(
        themeOverrides: (data) => data.copyWith(
          components: data.components.copyWith(
            modal: data.components.modal.copyWith(titleColour: Colors.purple, contentColour: Colors.orange),
          ),
        ),
        child: const DievasModal(header: Text('Custom heading'), content: Text('Custom body')),
      ),
    );
    expect(DefaultTextStyle.of(tester.element(find.text('Custom heading'))).style.color, Colors.purple);
    expect(DefaultTextStyle.of(tester.element(find.text('Custom body'))).style.color, Colors.orange);
  });

  testWidgets('custom content takes precedence over body and actions return a result', (tester) async {
    String? result;
    await tester.pumpWidget(
      Harness(
        child: Builder(
          builder: (context) => DievasFilledButton(
            label: 'Open',
            onPressed: () async {
              result = await showDievasModal<String>(
                context: context,
                builder: (context) => DievasModal(
                  title: 'Title',
                  body: 'Hidden body',
                  content: const Text('Custom content'),
                  actions: [
                    DievasFilledButton(label: 'Confirm', onPressed: () => closeDievasModal(context, 'confirmed')),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Hidden body'), findsNothing);
    expect(find.text('Custom content'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();
    expect(result, 'confirmed');
    expect(find.byType(DievasModal), findsNothing);
  });

  testWidgets('title-free child inherits foregrounds, custom decoration and directional clipping', (tester) async {
    const radius = BorderRadiusDirectional.only(topStart: Radius.circular(32), bottomEnd: Radius.circular(8));
    const decoration = BoxDecoration(color: Colors.amber);
    await tester.pumpWidget(
      Harness(
        child: Directionality(
          textDirection: .rtl,
          child: const DievasModal(
            textColour: Colors.red,
            iconColour: Colors.green,
            borderRadius: radius,
            decoration: decoration,
            child: Column(mainAxisSize: .min, children: [Text('Content only'), Icon(Icons.star)]),
          ),
        ),
      ),
    );
    final textContext = tester.element(find.text('Content only'));
    expect(DefaultTextStyle.of(textContext).style.color, Colors.red);
    expect(IconTheme.of(textContext).color, Colors.green);
    expect(find.byIcon(Icons.close), findsNothing);
    expect(
      tester
          .widget<ClipRRect>(find.descendant(of: find.byType(DievasModal), matching: find.byType(ClipRRect)))
          .borderRadius,
      radius.resolve(TextDirection.rtl),
    );
    expect(
      find.byWidgetPredicate(
        (widget) => switch (widget) {
          DecoratedBox(decoration: final value) => value == decoration,
          _ => false,
        },
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('local themes survive root navigation and surface overrides preserve layout', (tester) async {
    final data = DievasDarkThemeData();
    final local = data.copyWith(
      components: data.components.copyWith(
        modal: data.components.modal.copyWith(
          backgroundColour: Colors.orange,
          textColour: Colors.cyan,
          borderRadius: data.border.r32,
        ),
      ),
    );
    await tester.pumpWidget(
      Harness(
        child: DievasTheme(
          data: local,
          child: Theme(
            data: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.pink),
            child: Builder(
              builder: (context) => DievasFilledButton(
                label: 'Open',
                onPressed: () => showDievasModal(
                  context: context,
                  barrierColour: Colors.purple,
                  barrierLabel: 'Dismiss custom modal',
                  builder: (_) => const DievasModal(title: 'Local theme', body: 'Inherited body'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    final context = tester.element(find.text('Inherited body'));
    expect(DievasTheme.of(context), same(local));
    expect(Theme.of(context).scaffoldBackgroundColor, Colors.pink);
    expect(DefaultTextStyle.of(context).style.color, Colors.cyan);
    final surface = tester.widget<DecoratedBox>(
      find.descendant(of: find.byType(DievasModal), matching: find.byType(DecoratedBox)).first,
    );
    expect(
      surface.decoration,
      isA<BoxDecoration>()
          .having((value) => value.color, 'background', Colors.orange)
          .having((value) => value.borderRadius, 'radius', local.border.r32),
    );
    final barrier = tester.widgetList<ModalBarrier>(find.byType(ModalBarrier)).last;
    expect(barrier.color, Colors.purple);
    expect(barrier.semanticsLabel, 'Dismiss custom modal');
  });

  for (final dismissible in [true, false]) {
    testWidgets('barrier and Escape honour dismissible=$dismissible', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Builder(
            builder: (context) => DievasFilledButton(
              label: 'Open',
              onPressed: () => showDievasModal(
                context: context,
                barrierDismissible: dismissible,
                builder: (_) => const DievasModal(title: 'Dismissal'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      expect(find.text('Dismissal'), dismissible ? findsNothing : findsOneWidget);
      if (dismissible) {
        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();
      }
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.text('Dismissal'), dismissible ? findsNothing : findsOneWidget);
    });
  }

  testWidgets('close is labelled, keyboard reachable, visibly focused and activates with Enter', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      Harness(
        child: Builder(
          builder: (context) => DievasFilledButton(
            label: 'Open',
            onPressed: () => showDievasModal(
              context: context,
              builder: (_) => const DievasModal(title: 'Keyboard modal', closeButtonLabel: 'Close this modal'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Close this modal'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(DievasModal),
        matching: find.byWidgetPredicate(
          (widget) => switch (widget) {
            Container(decoration: ShapeDecoration(shadows: final shadows?)) => shadows.isNotEmpty,
            _ => false,
          },
        ),
      ),
      findsOneWidget,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byType(DievasModal), findsNothing);
    semantics.dispose();
  });

  testWidgets('narrow keyboard viewport scrolls long content and wraps actions', (tester) async {
    await tester.binding.setSurfaceSize(const Size(280, 500));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(size: Size(280, 500), viewInsets: EdgeInsets.only(bottom: 160)),
          child: DievasModal(
            title: 'Long modal title that wraps on a narrow screen',
            content: Column(mainAxisSize: .min, children: [for (int i = 0; i < 30; i++) Text('Long content $i')]),
            actions: [
              DievasFilledButton(label: 'First action', onPressed: () {}),
              DievasTextButton(label: 'Second action', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final clip = find.descendant(of: find.byType(DievasModal), matching: find.byType(ClipRRect));
    expect(tester.getRect(clip).bottom, lessThanOrEqualTo(340));
    await tester.scrollUntilVisible(find.text('Second action'), 200, scrollable: find.byType(Scrollable).first);
    expect(tester.getRect(find.text('Second action')).top, greaterThan(tester.getRect(find.text('First action')).top));
    expect(tester.takeException(), isNull);
  });

  testWidgets('local navigator owns modal and reduced motion disables route animation', (tester) async {
    final local = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      Harness(
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Navigator(
            key: local,
            onGenerateRoute: (_) => MaterialPageRoute<void>(
              builder: (context) => DievasFilledButton(
                label: 'Open',
                onPressed: () => showDievasModal(
                  context: context,
                  useRootNavigator: false,
                  transitionDuration: const Duration(seconds: 5),
                  routeSettings: const RouteSettings(name: 'local-modal'),
                  builder: (_) => const DievasModal(title: 'Local modal'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pump();
    final context = tester.element(find.text('Local modal'));
    expect(Navigator.of(context), same(local.currentState));
    final route = ModalRoute.of(context);
    expect(route?.settings.name, 'local-modal');
    expect(route?.transitionDuration, Duration.zero);
    expect(route?.traversalEdgeBehavior, TraversalEdgeBehavior.closedLoop);
    expect(route?.animation?.value, 1);
  });

  test('modal theme copyWith preserves defaults and participates in equality', () {
    final theme = DievasLightThemeData().components.modal;
    expect(theme.copyWith(), theme);
    expect(theme.shadow, isEmpty);
    final changed = theme.copyWith(
      textColour: Colors.red,
      iconColour: Colors.green,
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.linear,
    );
    expect(changed, isNot(theme));
    expect(changed.copyWith(), changed);
    expect(changed.backgroundColour, theme.backgroundColour);
  });
}
