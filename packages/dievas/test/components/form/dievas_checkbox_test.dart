import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasCheckbox', () {
    testWidgets('renders without throwing — unchecked', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .unchecked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders checked state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .checked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders indeterminate state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .indeterminate, onChanged: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasCheckbox(value: .checked, onChanged: null, label: 'Accept terms'),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Accept terms'), findsOneWidget);
    });

    testWidgets('fires onChanged on tap', (tester) async {
      DievasCheckboxValue? result;
      await tester.pumpWidget(
        Harness(
          child: DievasCheckbox(value: .unchecked, onChanged: (v) => result = v),
        ),
      );
      await tester.tap(find.byType(DievasCheckbox));
      expect(result, DievasCheckboxValue.checked);
    });

    testWidgets('disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCheckbox(value: .checked, onChanged: null)));
      expect(tester.takeException(), isNull);
    });
  });
}
