import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasCircularProgress', () {
    testWidgets('renders indeterminate without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCircularProgress()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders determinate value', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasCircularProgress(value: 0.4)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasCircularProgressSize.values) {
        await tester.pumpWidget(Harness(child: DievasCircularProgress(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders both styles', (tester) async {
      for (final style in DievasCircularProgressStyle.values) {
        await tester.pumpWidget(Harness(child: DievasCircularProgress(style: style)));
        expect(tester.takeException(), isNull);
      }
    });
  });
}
