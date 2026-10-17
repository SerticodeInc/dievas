import 'package:flutter/material.dart';
import 'package:dievas/dievas.dart';
import 'package:dievas_gallery/addons/dievas_theme_addon.dart';
import 'package:dievas_gallery/components/accordion/dievas_accordion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('accordion playground registers overrides and applies knob changes', (tester) async {
    await tester.pumpWidget(
      Widgetbook.material(
        initialRoute: '/?path=accordion/playground',
        directories: [accordionComponent],
        addons: [DievasThemeAddon()],
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final accordion = find.byType(DievasAccordion);
    expect(accordion, findsOneWidget);
    final state = WidgetbookState.of(tester.element(accordion));
    expect(
      state.knobs.keys,
      containsAll([
        'Size',
        'Show border',
        'Show divider',
        'Show shadows',
        'Border radius',
        'Override border radius',
        'Override header text colour',
        'Override expanded header text colour',
        'Override content text colour',
        'Override icon colour',
        'Override expanded icon colour',
        'Override background colour',
        'Override expanded background colour',
        'Override border colour',
        'Override divider colour',
        'Maintain content state',
      ]),
    );
    state.updateQueryField(group: 'knobs', field: 'Size', value: 'lg');
    state.updateQueryField(group: 'knobs', field: 'Show border', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Show divider', value: 'false');
    state.updateQueryField(group: 'knobs', field: 'Override border colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Override divider colour', value: 'true');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final widget = tester.widget<DievasAccordion>(accordion);
    expect(widget.size, DievasAccordionSize.lg);
    expect(widget.showBorder, isTrue);
    expect(widget.showDivider, isFalse);
    expect(widget.borderColour, isNotNull);
    expect(widget.dividerColour, isNotNull);
    state.updateQueryField(group: 'knobs', field: 'Border colour', value: 'Error border');
    state.updateQueryField(group: 'knobs', field: 'Override background colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Background colour', value: 'Success background');
    state.updateQueryField(group: 'knobs', field: 'Override header text colour', value: 'true');
    state.updateQueryField(group: 'knobs', field: 'Header text colour', value: 'Secondary text');
    await tester.pumpAndSettle();
    final light = DievasTheme.coloursOf(tester.element(accordion));
    expect(tester.widget<DievasAccordion>(accordion).borderColour, light.feedback.feedbackError.border);
    expect(tester.widget<DievasAccordion>(accordion).backgroundColour, light.feedback.feedbackSuccess.background);
    expect(tester.widget<DievasAccordion>(accordion).textColour, light.text.textSecondary);
    state.updateQueryField(group: 'dievas-theme', field: 'theme', value: 'Dark');
    await tester.pumpAndSettle();
    final dark = DievasTheme.coloursOf(tester.element(accordion));
    expect(dark.brightness, Brightness.dark);
    expect(tester.widget<DievasAccordion>(accordion).borderColour, dark.feedback.feedbackError.border);
    expect(tester.widget<DievasAccordion>(accordion).backgroundColour, dark.feedback.feedbackSuccess.background);
    expect(tester.widget<DievasAccordion>(accordion).textColour, dark.text.textSecondary);
    state.updateQueryField(group: 'knobs', field: 'Override border colour', value: 'false');
    await tester.pumpAndSettle();
    expect(tester.widget<DievasAccordion>(accordion).borderColour, isNull);
  });
}
