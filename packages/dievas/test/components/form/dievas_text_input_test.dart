import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasTextInput', () {
    testWidgets('renders without throwing — default args', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasTextInputSize.values) {
        await tester.pumpWidget(Harness(child: DievasTextInput(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(label: 'Email')));
      expect(tester.takeException(), isNull);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('renders with hint', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(hint: 'you@example.com')));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders helper text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(helperText: 'We will never share your email')));
      expect(tester.takeException(), isNull);
      expect(find.text('We will never share your email'), findsOneWidget);
    });

    testWidgets('renders error text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(errorText: 'Invalid email')));
      expect(tester.takeException(), isNull);
      expect(find.text('Invalid email'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(leadingIcon: Icon(Icons.email_outlined))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with trailing icon', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(trailingIcon: Icon(Icons.clear))));
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onChanged on text input', (tester) async {
      String? result;
      await tester.pumpWidget(Harness(child: DievasTextInput(onChanged: (v) => result = v)));
      await tester.enterText(find.byType(TextField), 'hello');
      expect(result, 'hello');
    });

    testWidgets('renders disabled state', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(enabled: false)));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders obscured text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(obscureText: true)));
      expect(tester.takeException(), isNull);
    });
  });
}
