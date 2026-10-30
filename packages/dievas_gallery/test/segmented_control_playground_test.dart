import 'dart:io';
import 'dart:ui' as ui;

import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/form/dievas_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference text and icon groups retain selection across live overrides', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await (FontLoader(
      'MartianMono',
    )..addFont(rootBundle.load('packages/dievas/lib/assets/fonts/MartianMono-Regular.ttf'))).load();
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=segmentedcontrol/playground',
        directories: [segmentedControlComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final controls = find.byWidgetPredicate(
      (widget) => switch (widget) {
        DievasSegmentedControl<Object?>() => true,
        _ => false,
      },
    );
    expect(controls, findsNWidgets(2));
    expect(find.text('Tab1'), findsOneWidget);
    expect(tester.widget<DievasSegmentedControl<Object?>>(controls.first).segments?.length, 3);
    expect(tester.widget<DievasSegmentedControl<Object?>>(controls.last).segments?.length, 4);
    if (Platform.environment['DIEVAS_SEGMENTED_PREVIEW'] case final path?) {
      final boundary = tester.renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        if (await image.toByteData(format: ui.ImageByteFormat.png) case final bytes?) {
          File(path).writeAsBytesSync(bytes.buffer.asUint8List());
        }
        image.dispose();
      });
    }
    final state = WidgetbookState.of(tester.element(controls.first));
    await tester.tap(find.text('Tab2'));
    await tester.pumpAndSettle();
    final selectedText = tester.widget<DievasSegmentedControl<Object?>>(controls.first).value;
    expect(selectedText.toString(), endsWith('tab2'));
    await tester.tap(find.bySemanticsLabel('Icon 3'));
    await tester.pumpAndSettle();
    final selectedIcon = tester.widget<DievasSegmentedControl<Object?>>(controls.last).value;
    for (final field in [
      'Override background colour',
      'Override selected background colour',
      'Override text colour',
      'Override selected text colour',
      'Override container radius',
      'Override segment radius',
      'Custom segment decoration',
      'Expanded',
      'Leading',
      'Trailing',
      'Right to left',
    ]) {
      state.updateQueryField(group: 'knobs', field: field, value: 'true');
    }
    state.updateQueryField(group: 'knobs', field: 'Size', value: 'sm');
    state.updateQueryField(group: 'knobs', field: 'Container radius', value: 'r32');
    state.updateQueryField(group: 'knobs', field: 'Segment radius', value: 'lg');
    await tester.pumpAndSettle();
    final text = tester.widget<DievasSegmentedControl<Object?>>(controls.first);
    final icon = tester.widget<DievasSegmentedControl<Object?>>(controls.last);
    expect(text.value, selectedText);
    expect(icon.value, selectedIcon);
    expect(text.size, DievasSegmentedControlSize.sm);
    expect(text.style?.decoration?.color, isNotNull);
    expect(text.isExpanded, isTrue);
    expect(text.style?.decoration?.borderRadius, DievasTheme.of(tester.element(controls.first)).border.r32);
    expect(Directionality.of(tester.element(controls.first)), TextDirection.rtl);
    final selectedSurface = tester.widget<AnimatedContainer>(
      find.ancestor(of: find.text('Tab2'), matching: find.byType(AnimatedContainer)),
    );
    switch (selectedSurface.decoration) {
      case BoxDecoration(:final color, :final border):
        expect(color, text.style?.segmentStyle?.selected?.decoration?.color);
        expect(border, isNotNull);
      default:
        fail('Expected the gallery border to compose with the selected box surface');
    }
    state.updateQueryField(group: 'knobs', field: 'Disabled', value: 'true');
    await tester.pumpAndSettle();
    await tester.tapAt(tester.getCenter(find.text('Tab1')));
    await tester.pumpAndSettle();
    expect(tester.widget<DievasSegmentedControl<Object?>>(controls.first).value, selectedText);
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });
}
