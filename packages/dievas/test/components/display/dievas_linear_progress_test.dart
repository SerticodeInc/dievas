import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasLinearProgress', () {
    testWidgets('renders indeterminate without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLinearProgress()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders determinate value', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLinearProgress(value: 0.6)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all styles', (tester) async {
      for (final style in DievasLinearProgressStyle.values) {
        await tester.pumpWidget(Harness(child: DievasLinearProgress(value: 0.5, style: style)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('clamps value at 0', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLinearProgress(value: -0.1)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('clamps value at 1', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLinearProgress(value: 1.5)));
      expect(tester.takeException(), isNull);
    });
  });
}
