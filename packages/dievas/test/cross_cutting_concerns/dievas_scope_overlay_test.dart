import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const bannerMessage = 'Scope banner message';
  const snackbarMessage = 'Scope snackbar message';

  // Mirrors the example app wiring: MaterialApp built through the scope's
  // builder, so the overlay slots render beside — not inside — MaterialApp.
  Future<void> pumpScope(WidgetTester tester) async {
    await tester.pumpWidget(
      DievasScope(
        builder: (context, theme, child) => MaterialApp(
          theme: theme.material,
          localizationsDelegates: DievasLocalizations.localizationsDelegates,
          supportedLocales: DievasLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final scope = DievasScope.of(context);

                return Column(
                  children: [
                    FilledButton(
                      onPressed: () => scope.showBanner(
                        (context, _) => DievasBanner(tone: .info, message: bannerMessage, onDismiss: scope.hideBanner),
                      ),
                      child: const Text('Show banner'),
                    ),
                    FilledButton(
                      onPressed: () => scope.showSnackbar(
                        (context, _) => DievasSnackbar(
                          message: snackbarMessage,
                          action: DievasSnackbarAction(label: 'Dismiss', onPressed: scope.hideSnackbar),
                        ),
                      ),
                      child: const Text('Show snackbar'),
                    ),
                    FilledButton(onPressed: scope.hideBanner, child: const Text('Hide banner')),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('DievasScope overlays', () {
    testWidgets('showBanner renders beside MaterialApp without throwing', (tester) async {
      await pumpScope(tester);

      await tester.tap(find.text('Show banner'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text(bannerMessage), findsOneWidget);
    });

    testWidgets('showSnackbar renders beside MaterialApp without throwing', (tester) async {
      await pumpScope(tester);

      await tester.tap(find.text('Show snackbar'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text(snackbarMessage), findsOneWidget);
    });

    testWidgets('hideBanner removes the banner', (tester) async {
      await pumpScope(tester);

      await tester.tap(find.text('Show banner'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hide banner'));
      await tester.pumpAndSettle();

      expect(find.text(bannerMessage), findsNothing);
    });

    testWidgets('snackbar action hides the snackbar', (tester) async {
      await pumpScope(tester);

      await tester.tap(find.text('Show snackbar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dismiss'));
      await tester.pumpAndSettle();

      expect(find.text(snackbarMessage), findsNothing);
    });

    testWidgets('overlay directionality matches app locale resolution', (tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('ar');
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);

      await pumpScope(tester);
      await tester.tap(find.text('Show banner'));
      await tester.pumpAndSettle();

      final directions = tester
          .widgetList<Directionality>(
            find.ancestor(of: find.text(bannerMessage), matching: find.byType(Directionality)),
          )
          .map((widget) => widget.textDirection)
          .toSet();

      // Only English is supported, so MaterialApp and the overlay host must
      // agree on LTR even on an Arabic device — no split-direction rendering.
      expect(directions, {TextDirection.ltr});
    });
  });
}
