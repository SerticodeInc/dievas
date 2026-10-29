import 'dart:io';
import 'dart:ui' as ui;

import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/form/dievas_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference groups select independently and survive live controls', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await (FontLoader(
      'MartianMono',
    )..addFont(rootBundle.load('packages/dievas/lib/assets/fonts/MartianMono-Regular.ttf'))).load();
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=radio/playground',
        directories: [radioComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final first = find.byKey(const ValueKey('plain-first'));
    final second = find.byKey(const ValueKey('plain-second'));
    final state = WidgetbookState.of(tester.element(first));
    expect(
      find.byWidgetPredicate(
        (widget) => switch (widget) {
          DievasRadio<Object?>() => true,
          _ => false,
        },
      ),
      findsNWidgets(4),
    );
    if (Platform.environment['DIEVAS_RADIO_PREVIEW'] case final path?) {
      final boundary = tester.renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        if (await image.toByteData(format: ui.ImageByteFormat.png) case final bytes?) {
          File(path).writeAsBytesSync(bytes.buffer.asUint8List());
        }
        image.dispose();
      });
    }
    await tester.tap(second);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasRadio<Object?>>(second).groupValue, tester.widget<DievasRadio<Object?>>(second).value);
    await tester.tapAt(tester.getCenter(find.byKey(const ValueKey('labelled-second'))));
    await tester.pumpAndSettle();
    final labelled = tester.widget<DievasMenuItem>(find.byKey(const ValueKey('labelled-second')));
    expect(labelled.trailing, isNotNull);
    state.updateQueryField(group: 'knobs', field: 'Toggleable', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Right to left', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override active colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Active colour', value: 'Error border');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasRadio<Object?>>(second).groupValue, tester.widget<DievasRadio<Object?>>(second).value);
    expect(
      tester.widget<DievasRadio<Object?>>(first).activeColour,
      DievasTheme.of(tester.element(first)).colours.feedback.feedbackError.border,
    );
    expect(Directionality.of(tester.element(first)), TextDirection.rtl);
    await tester.tap(second);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasRadio<Object?>>(second).groupValue, isNull);
    await tester.tapAt(tester.getCenter(find.byKey(const ValueKey('labelled-second'))));
    await tester.pumpAndSettle();
    final allRadios = tester.widgetList<DievasRadio<Object?>>(
      find.byWidgetPredicate(
        (widget) => switch (widget) {
          DievasRadio<Object?>() => true,
          _ => false,
        },
      ),
    );
    expect(allRadios.every((radio) => radio.groupValue == null), isTrue);
    state.updateQueryField(group: 'knobs', field: 'Disabled', value: 'true');
    await tester.pumpAndSettle();
    await tester.tap(first);
    await tester.pumpAndSettle();
    expect(tester.widget<DievasRadio<Object?>>(first).groupValue, isNull);
    expect(tester.takeException(), isNull);
  });
}
