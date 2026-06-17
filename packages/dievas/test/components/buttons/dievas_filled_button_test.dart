import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasFilledButton', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasFilledButton(label: 'Continue', onPressed: () {}),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders all three styles', (tester) async {
      for (final style in DievasFilledButtonStyle.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasFilledButton(label: style.name, style: style, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all three sizes', (tester) async {
      for (final size in DievasButtonSize.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasFilledButton(label: 'Label', size: size, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasFilledButton(label: 'Disabled', onPressed: null)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading state renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasFilledButton(label: 'Saving', state: .loading),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed callback on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasFilledButton(label: 'Go', onPressed: () => tapped = true),
        ),
      );
      await tester.tap(find.byType(DievasFilledButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not fire onPressed when loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasFilledButton(label: 'Go', state: .loading, onPressed: () => tapped = true),
        ),
      );

      await tester.tap(find.byType(DievasFilledButton));
      expect(tapped, isFalse);
    });

    testWidgets('renders both shapes', (tester) async {
      for (final shape in DievasButtonShape.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasFilledButton(label: 'Shape', shape: shape, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });
  });
}
