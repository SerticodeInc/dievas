import 'dart:io';
import 'dart:ui' as ui;
import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/popover/dievas_popover.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('reference popup stays inside phone and follows live controls', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1600, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await (FontLoader(
      'MartianMono',
    )..addFont(rootBundle.load('packages/dievas/lib/assets/fonts/MartianMono-Regular.ttf'))).load();
    await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=popover/playground',
        directories: [popoverComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    final state = WidgetbookState.of(tester.element(find.text('Tap me')));
    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();
    expect(find.text('Custom DievasPopover text'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
    expect(
      tester
          .widget<DievasFilledButton>(
            find.byWidgetPredicate((widget) => widget is DievasFilledButton && widget.label == 'Close'),
          )
          .isFullWidth,
      isTrue,
    );
    final viewport = tester.getRect(find.byType(Overlay).last);
    final panel = tester.getRect(find.text('Custom DievasPopover text'));
    expect(viewport.contains(panel.topLeft), isTrue);
    expect(viewport.contains(panel.bottomRight), isTrue);
    await tester.tapAt(Offset(viewport.right + 10, viewport.center.dy));
    await tester.pumpAndSettle();
    expect(find.text('Close'), findsOneWidget);
    if (Platform.environment['DIEVAS_POPOVER_PREVIEW'] case final path?) {
      final boundary = tester.renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        File(path).writeAsBytesSync(bytes!.buffer.asUint8List());
        image.dispose();
      });
    }
    for (final field in [
      'Override background colour',
      'Override border colour',
      'Override border radius',
      'Right to left',
    ]) {
      state.updateQueryField(group: 'knobs', field: field, value: 'true');
    }
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: 'r32');
    await tester.pumpAndSettle();
    expect(find.text('Close'), findsOneWidget);
    final popover = tester.widget<DievasPopover>(find.byType(DievasPopover));
    expect(popover.backgroundColour, isNotNull);
    expect(popover.borderColour, isNotNull);
    expect(Directionality.of(tester.element(find.text('Custom DievasPopover text'))), TextDirection.rtl);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.text('Custom DievasPopover text'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
