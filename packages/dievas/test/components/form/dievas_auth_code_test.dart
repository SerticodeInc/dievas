import 'package:dievas/dievas.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAuthCode', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: DievasAuthCode(codeLength: 4, onCompleted: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders different code lengths', (tester) async {
      for (var len in [4, 6, 8]) {
        await tester.pumpWidget(
          Harness(
            child: DievasAuthCode(codeLength: len, onCompleted: (_) {}),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with obscure text', (tester) async {
      await tester.pumpWidget(Harness(child: DievasAuthCode(codeLength: 6, obscureText: true, onCompleted: (_) {})));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: DievasAuthCode(codeLength: 4, enabled: false, onCompleted: (_) {})));
      expect(tester.takeException(), isNull);
    });
  });
}
