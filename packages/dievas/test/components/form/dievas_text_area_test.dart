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
