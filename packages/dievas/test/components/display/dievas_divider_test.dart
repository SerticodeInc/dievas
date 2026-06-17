import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasDivider', () {
    testWidgets('renders horizontal without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders vertical without throwing', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(orientation: DievasDividerOrientation.vertical)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with indent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(indent: 16)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with endIndent', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasDivider(endIndent: 16)));
      expect(tester.takeException(), isNull);
    });
  });
}
