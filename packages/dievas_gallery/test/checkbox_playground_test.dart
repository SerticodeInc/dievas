import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/form/dievas_checkbox.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('checkbox examples toggle independently and share reference overrides', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=checkbox/playground',
        directories: [checkboxComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final controls = find.byType(DievasCheckbox);
    expect(controls, findsNWidgets(2));
    final state = WidgetbookState.of(tester.element(controls.first));
    final labels = state.knobs.keys.toList();
    expect(
      labels,
      containsAll(['Check colour', 'Active colour', 'Inactive colour', 'Border colour', 'Tristate', 'Disabled']),
    );
    expect(labels.indexOf('Override check colour') + 1, labels.indexOf('Check colour'));
    await tester.tap(controls.first);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(controls.first).value, DievasCheckboxValue.checked);
    expect(tester.widget<DievasCheckbox>(controls.last).value, DievasCheckboxValue.unchecked);
    await tester.tap(find.text('With label'));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(controls.last).value, DievasCheckboxValue.checked);
    expect(tester.widget<DievasCheckbox>(controls.last).labelPosition, DievasCheckboxLabelPosition.start);
    state.updateQueryField(group: 'knobs', field: 'Tristate', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override active colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Active colour', value: 'Brand');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(controls.first).tristate, isTrue);
    await tester.tap(controls.first);
    await tester.pumpAndSettle();
    await tester.tap(controls.first);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(controls.first).value, DievasCheckboxValue.indeterminate);
    state.updateQueryField(group: 'dievas-theme', field: 'theme', value: 'Dark');
    state.updateQueryField(group: 'knobs', field: 'Disabled', value: 'true');
    await tester.pumpAndSettle();
    for (final control in tester.widgetList<DievasCheckbox>(controls)) {
      expect(control.activeColour, DievasTheme.coloursOf(tester.element(controls.first)).core.primary);
      expect(control.onChanged, isNull);
    }
    final previous = tester.widget<DievasCheckbox>(controls.first).value;
    await tester.tap(controls.first);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasCheckbox>(controls.first).value, previous);
    expect(tester.takeException(), isNull);
  });
}
