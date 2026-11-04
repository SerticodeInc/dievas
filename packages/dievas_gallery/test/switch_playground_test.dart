import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/form/dievas_switch.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference switches retain independent values through live knobs', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=switch/playground',
        directories: [switchComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final switches = find.byType(DievasSwitch);
    expect(switches, findsNWidgets(3));
    expect(tester.widgetList<DievasSwitch>(switches).map((control) => control.value), [false, false, false]);
    await tester.tap(switches.at(1));
    await tester.pumpAndSettle();
    final state = WidgetbookState.of(tester.element(switches.first));
    state.updateQueryField(group: 'knobs', field: 'Switch size', value: 'sm');
    state.updateQueryField(group: 'knobs', field: 'Override active track colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    await tester.pumpAndSettle();
    expect(tester.widgetList<DievasSwitch>(switches).map((control) => control.value), [false, true, false]);
    for (final control in tester.widgetList<DievasSwitch>(switches)) {
      expect(control.switchSize, DievasSwitchSize.sm);
      expect(control.activeTrackColour, isNotNull);
    }
    expect(Directionality.of(tester.element(switches.first)), TextDirection.rtl);
    state.updateQueryField(group: 'knobs', field: 'Disabled', value: 'true');
    await tester.pumpAndSettle();
    for (final control in tester.widgetList<DievasSwitch>(switches)) {
      expect(control.onChanged, isNull);
    }
    expect(tester.takeException(), isNull);
  });
}
