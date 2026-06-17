import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTextButton', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasTextButton(label: 'View details', onPressed: () {}),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('View details'), findsOneWidget);
    });

    testWidgets('renders both styles', (tester) async {
      for (final style in DievasTextButtonStyle.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasTextButton(label: style.name, style: style, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders all three sizes', (tester) async {
      for (final size in DievasButtonSize.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasTextButton(label: 'Label', size: size, onPressed: () {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with leading and trailing icons', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasTextButton(
            label: 'With icons',
            leadingIcon: const Icon(Icons.arrow_back),
            trailingIcon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextButton(label: 'Disabled')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('loading state renders without throwing', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTextButton(label: 'Loading', state: DievasButtonState.loading),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onPressed on tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        Harness(
          child: DievasTextButton(label: 'Go', onPressed: () => tapped = true),
        ),
      );
      await tester.tap(find.byType(DievasTextButton));
      expect(tapped, isTrue);
    });
  });
}
