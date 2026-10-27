import 'dart:io';
import 'dart:ui' as ui;

import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/overlays/dievas_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

Future<void> _pumpGallery(WidgetTester tester, [String example = 'playground']) async {
  await tester.binding.setSurfaceSize(const Size(1600, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await (FontLoader(
    'MartianMono',
  )..addFont(rootBundle.load('packages/dievas/lib/assets/fonts/MartianMono-Regular.ttf'))).load();
  await (FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  await tester.pumpWidget(
    Widgetbook.material(
      initialRoute: '/?path=modal/$example',
      directories: [modalComponent],
      addons: [DievasThemeAddon()],
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('launcher returns results and open modal follows live surface, layout and RTL knobs', (tester) async {
    await _pumpGallery(tester);
    final state = WidgetbookState.of(tester.element(find.text('Tap me')));
    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasModal), findsOneWidget);
    expect(tester.getSize(find.descendant(of: find.byType(DievasModal), matching: find.byType(ClipRRect))).width, 300);
    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.byType(DievasDivider), findsOneWidget);
    final card = tester.getRect(find.descendant(of: find.byType(DievasModal), matching: find.byType(ClipRRect)));
    final button = tester.getRect(find.byType(DievasFilledButton).last);
    expect(tester.getSize(find.byType(DievasFilledButton).last).height, 40);
    expect((button.left - card.left) / card.width, closeTo(24 / 300, 0.001));
    expect((card.right - button.right) / card.width, closeTo(24 / 300, 0.001));
    final viewport = tester.getRect(find.byType(Overlay).last);
    final surface = find.descendant(of: find.byType(DievasModal), matching: find.byType(ClipRRect));
    expect(viewport.contains(tester.getRect(surface).topLeft), isTrue);
    expect(viewport.contains(tester.getRect(surface).bottomRight), isTrue);
    await tester.tapAt(Offset(viewport.right + 10, viewport.center.dy));
    await tester.pumpAndSettle();
    expect(find.byType(DievasModal), findsOneWidget);
    final headerHeight = tester.getTopLeft(find.byType(DievasDivider)).dy - tester.getTopLeft(surface).dy;
    state.updateQueryField(group: 'knobs', field: 'Show close button', value: 'true');
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byType(DievasDivider)).dy - tester.getTopLeft(surface).dy,
      closeTo(headerHeight, 0.01),
    );
    expect(tester.widget<Icon>(find.byIcon(Icons.close)).size, 20);
    final close = find.ancestor(of: find.byIcon(Icons.close), matching: find.byType(DievasTextButton));
    expect(tester.getSize(close), const Size(44, 44));
    if (Platform.environment['DIEVAS_MODAL_PREVIEW'] case final path?) {
      final boundary = tester.renderObject<RenderRepaintBoundary>(find.byType(RepaintBoundary).first);
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        if (bytes case final data?) File(path).writeAsBytesSync(data.buffer.asUint8List());
        image.dispose();
      });
    }
    for (final field in [
      'Override text colour',
      'Override background colour',
      'Override barrier colour',
      'Override border radius',
      'Right to left',
    ]) {
      state.updateQueryField(group: 'knobs', field: field, value: 'true');
    }
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: 'r32');
    state.updateQueryField(group: 'knobs', field: 'Maximum width', value: 'compact');
    await tester.pumpAndSettle();
    expect(find.byType(DievasModal), findsOneWidget);
    final modal = tester.widget<DievasModal>(find.byType(DievasModal));
    final theme = DievasTheme.of(tester.element(find.byType(DievasModal)));
    expect(modal.textColour, theme.colours.core.primary);
    expect(modal.backgroundColour, isNotNull);
    expect(modal.borderRadius, theme.border.r32);
    expect(tester.getSize(surface).width, lessThanOrEqualTo(theme.sizing.width256));
    expect(Directionality.of(tester.element(find.text('DievasModal title'))), TextDirection.rtl);
    expect(tester.takeException(), isNull);

    state.updateQueryField(group: 'knobs', field: 'Override title colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override content colour', value: 'true');
    await tester.pumpAndSettle();
    expect(tester.widget<Text>(find.text('DievasModal title')).style?.color, theme.colours.core.primary);
    expect(
      DefaultTextStyle.of(
        tester.element(find.text('Re-open the DievasModal to view the updated knob value.')),
      ).style.color,
      theme.colours.text.textSecondary,
    );
    await tester.tap(find.text('Okay'));
    await tester.pumpAndSettle();
    expect(find.byType(DievasModal), findsNothing);
    expect(find.text('Okay'), findsOneWidget);
  });

  testWidgets('form value survives live knob remounts and modal reopening', (tester) async {
    await _pumpGallery(tester, 'keyboard-form');
    final state = WidgetbookState.of(tester.element(find.text('Tap me')));
    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), 'Ada');
    state.updateQueryField(group: 'knobs', field: 'Override border radius', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Border radius', value: 'r32');
    await tester.pumpAndSettle();
    expect(tester.widget<EditableText>(find.byType(EditableText)).controller.text, 'Ada');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();
    expect(tester.widget<EditableText>(find.byType(EditableText)).controller.text, 'Ada');
    expect(tester.takeException(), isNull);
  });

  testWidgets('content-only example has no automatic title and closes', (tester) async {
    await _pumpGallery(tester, 'content-only');
    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();
    expect(find.text('DievasModal title'), findsNothing);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.text('Closed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
