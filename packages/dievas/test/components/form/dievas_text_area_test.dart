import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTextArea', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(label: 'Bio')));
      expect(tester.takeException(), isNull);
      expect(find.text('Bio'), findsOneWidget);
    });

    testWidgets('renders with hint', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(hint: 'Tell us about yourself...')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders helper text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(helperText: 'Optional')));
      expect(tester.takeException(), isNull);
      expect(find.text('Optional'), findsOneWidget);
    });

    testWidgets('renders error text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(errorText: 'Required')));
      expect(tester.takeException(), isNull);
      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('renders warning text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(warningText: 'Bio is very short')));
      expect(tester.takeException(), isNull);
      expect(find.text('Bio is very short'), findsOneWidget);
    });

    testWidgets('warning takes precedence over helper text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTextArea(helperText: 'Optional', warningText: 'Bio is very short'),
        ),
      );
      expect(find.text('Bio is very short'), findsOneWidget);
      expect(find.text('Optional'), findsNothing);
    });

    testWidgets('error takes precedence over warning', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTextArea(errorText: 'Required', warningText: 'Bio is very short'),
        ),
      );
      expect(find.text('Required'), findsOneWidget);
      expect(find.text('Bio is very short'), findsNothing);
    });

    testWidgets('uses warning border colour when warningText is set', (tester) async {
      const warningColour = Color(0xFF00FF00);
      await tester.pumpWidget(
        Harness(
          child: const DievasTextArea(warningText: 'Watch out'),
          themeOverrides: (theme) => theme.copyWith(
            components: theme.components.copyWith(
              textInput: theme.components.textInput.copyWith(borderColourWarning: warningColour),
            ),
          ),
        ),
      );
      final decoration = tester.widget<TextField>(find.byType(TextField)).decoration!;
      final border = decoration.enabledBorder! as OutlineInputBorder;
      expect(border.borderSide.color, warningColour);
    });

    testWidgets('renders with custom min/max lines', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(minLines: 2, maxLines: 8)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onChanged on text input', (tester) async {
      String? result;
      await tester.pumpWidget(Harness(child: DievasTextArea(onChanged: (v) => result = v)));
      await tester.enterText(find.byType(TextField), 'multi\nline');
      expect(result, 'multi\nline');
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextArea(enabled: false)));
      expect(tester.takeException(), isNull);
    });
  });
}
