import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/display/dievas_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('Playground keeps the reference tag centred after activation', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=tag/playground',
        directories: [tagComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final tag = find.byType(DievasTag);
    final initial = tester.getRect(tag);
    final widget = tester.widget<DievasTag>(tag);
    expect(widget.tagSize, DievasTagSize.xs);
    expect(widget.leading, isNull);
    expect(widget.trailing, isNotNull);
    expect(widget.onRemove, isNull);
    expect(tester.getSize(tag).height, 24);
    await tester.tap(find.descendant(of: tag, matching: find.text('DievasTag')));
    await tester.pumpAndSettle();
    expect(tester.getRect(tag), initial);
    expect(find.textContaining('Taps:'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reference tag responds to actions and retains state across live controls', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=tag/interactions',
        directories: [tagComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final tag = find.byType(DievasTag);
    expect(tag, findsOneWidget);
    expect(tester.widget<DievasTag>(tag).tagSize, DievasTagSize.xs);
    expect(tester.widget<DievasTag>(tag).trailing, isNotNull);
    await tester.tap(find.descendant(of: tag, matching: find.text('DievasTag')));
    await tester.longPress(find.descendant(of: tag, matching: find.text('DievasTag')));
    await tester.pumpAndSettle();
    expect(find.text('Taps: 1 · Long presses: 1'), findsOneWidget);
    final state = WidgetbookState.of(tester.element(tag));
    for (final field in ['Override text colour', 'Override icon colour', 'Right to left', 'Leading']) {
      state.updateQueryField(group: 'knobs', field: field, value: 'true');
    }
    state.updateQueryField(group: 'knobs', field: 'Size', value: 'sm');
    await tester.pumpAndSettle();
    expect(find.text('Taps: 1 · Long presses: 1'), findsOneWidget);
    expect(tester.widget<DievasTag>(tag).tagSize, DievasTagSize.sm);
    expect(tester.widget<DievasTag>(tag).textColour, isNotNull);
    expect(tester.widget<DievasTag>(tag).iconColour, isNotNull);
    expect(Directionality.of(tester.element(tag)), TextDirection.rtl);
    state.updateQueryField(group: 'knobs', field: 'Remove action', value: 'true');
    await tester.pumpAndSettle();
    // The remove affordance is last when a leading close glyph is also shown.
    await tester.tap(find.descendant(of: tag, matching: find.byIcon(Icons.close)).last);
    await tester.pumpAndSettle();
    expect(tag, findsNothing);
    expect(find.text('Restore tag'), findsOneWidget);
    state.updateQueryField(group: 'knobs', field: 'Size', value: 'xs');
    await tester.pumpAndSettle();
    expect(tag, findsNothing);
    await tester.tap(find.text('Restore tag'));
    await tester.pumpAndSettle();
    expect(tag, findsOneWidget);
    expect(find.text('Taps: 1 · Long presses: 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
