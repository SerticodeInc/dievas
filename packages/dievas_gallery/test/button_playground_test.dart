import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/buttons/dievas_filled_button.dart';
import 'package:dievas_gallery/components/buttons/dievas_outlined_button.dart';
import 'package:dievas_gallery/components/buttons/dievas_text_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  for (final (component, route) in [
    (filledButtonComponent, 'filledbutton'),
    (outlinedButtonComponent, 'outlinedbutton'),
    (textButtonComponent, 'textbutton'),
  ]) {
    testWidgets('$route playground exposes reference controls and working actions', (tester) async {
      await tester.pumpWidget(
        Widgetbook.material(
          initialRoute: '/?path=$route/playground',
          directories: [component],
          addons: [DievasThemeAddon()],
        ),
      );
      await tester.pumpAndSettle();
      final state = WidgetbookState.of(tester.element(find.text('DievasButton')));
      final labels = state.knobs.keys.toList();
      expect(
        labels,
        containsAll([
          'Label text',
          'Size',
          'Background colour',
          'Border colour',
          'Text colour',
          'Border radius',
          'Show border',
          'Show pulse effect',
          'Show pulse effect jiggle',
          'Leading',
          'Label',
          'Trailing',
          'Full width',
          'Disabled',
        ]),
      );
      expect(labels.indexOf('Override border colour') + 1, labels.indexOf('Border colour'));
      expect(labels, isNot(contains('Use custom child')));
      await tester.tap(find.text('DievasButton'));
      await tester.pumpAndSettle();
      expect(find.text('Pressed ${route.replaceAll('button', '')} (1)'), findsOneWidget);
      state.updateQueryField(group: 'knobs', field: 'Override text colour', value: 'true');
      state.updateQueryField(group: 'knobs', field: 'Text colour', value: 'Brand');
      state.updateQueryField(group: 'knobs', field: 'Full width', value: 'true');
      state.updateQueryField(group: 'knobs', field: 'Override border radius', value: 'true');
      state.updateQueryField(group: 'knobs', field: 'Border radius', value: '0');
      await tester.pumpAndSettle();
      final brand = DievasTheme.coloursOf(tester.element(find.text('DievasButton'))).core.primary;
      final foreground = switch (route) {
        'filledbutton' => tester.widget<DievasFilledButton>(find.byType(DievasFilledButton)).foregroundColor,
        'outlinedbutton' => tester.widget<DievasOutlinedButton>(find.byType(DievasOutlinedButton)).foregroundColor,
        _ => tester.widget<DievasTextButton>(find.byType(DievasTextButton)).foregroundColor,
      };
      expect(foreground, brand);
      state.updateQueryField(group: 'knobs', field: 'Animate loading transition', value: 'false');
      state.updateQueryField(group: 'knobs', field: 'Loading', value: 'true');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 30));
      expect(switch (route) {
        'filledbutton' => tester.widget<DievasFilledButton>(find.byType(DievasFilledButton)).animateLoading,
        'outlinedbutton' => tester.widget<DievasOutlinedButton>(find.byType(DievasOutlinedButton)).animateLoading,
        _ => tester.widget<DievasTextButton>(find.byType(DievasTextButton)).animateLoading,
      }, isFalse);
      state.updateQueryField(group: 'knobs', field: 'Loading', value: 'false');
      await tester.pumpAndSettle();
      state.updateQueryField(group: 'dievas-theme', field: 'theme', value: 'Dark');
      state.updateQueryField(group: 'knobs', field: 'Disabled', value: 'true');
      await tester.pumpAndSettle();
      await tester.tap(find.text('DievasButton'));
      await tester.pumpAndSettle();
      expect(find.text('Pressed ${route.replaceAll('button', '')} (2)'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
