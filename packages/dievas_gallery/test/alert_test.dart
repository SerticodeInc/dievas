import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/overlays/dievas_alert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('alert showcase groups overrides and supports visibility and tokens', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=alert/playground',
        directories: [alertComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(DievasAlert), findsNWidgets(5));
    final state = WidgetbookState.of(tester.element(find.byType(DievasAlert).first));
    final labels = state.knobs.keys.toList();
    expect(labels.indexOf('Show leading'), lessThan(labels.indexOf('Override leading colour')));
    expect(labels.indexOf('Override border colour') + 1, labels.indexOf('Border colour'));
    await tester.tap(find.text('Show/Hide alert'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasAlert), findsNWidgets(4));
    await tester.tap(find.text('Show/Hide alert'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasAlert), findsNWidgets(5));
    state.updateQueryField(group: 'knobs', field: 'Override label colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Label colour', value: 'Brand');
    state.updateQueryField(group: 'knobs', field: 'Show content', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Disabled', value: 'true');
    await tester.pumpAndSettle();
    final alert = tester.widget<DievasAlert>(find.byType(DievasAlert).first);
    expect(alert.labelColour, DievasTheme.coloursOf(tester.element(find.byType(DievasAlert).first)).core.primary);
    expect(alert.description, isNotNull);
    expect(alert.disabled, isTrue);
    expect(tester.takeException(), isNull);
  });
}
