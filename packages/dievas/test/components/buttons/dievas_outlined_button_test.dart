import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasOutlinedButton', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasOutlinedButton(label: 'Cancel', onPressed: () {}),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('renders both styles', (tester) async {
      for (final style in DievasOutlinedButtonStyle.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasOutlinedButton(label: style.name, style: style, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all three sizes', (tester) async {
      for (final size in DievasButtonSize.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasOutlinedButton(label: 'Label', size: size, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasOutlinedButton(label: 'Disabled', onPressed: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasOutlinedButton(label: 'Go', onPressed: () => tapped = true),
        ),
      );
      await tester.tap(find.byType(DievasOutlinedButton));
      expect(tapped, isTrue);
    });
  });
}
