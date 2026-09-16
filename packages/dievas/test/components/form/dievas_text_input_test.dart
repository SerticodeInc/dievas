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

    testWidgets('renders warning text', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasTextInput(warningText: 'Username is taken')));
      expect(tester.takeException(), isNull);
      expect(find.text('Username is taken'), findsOneWidget);
    });

    testWidgets('warning takes precedence over helper text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTextInput(helperText: 'Optional', warningText: 'Username is taken'),
        ),
      );
      expect(find.text('Username is taken'), findsOneWidget);
      expect(find.text('Optional'), findsNothing);
    });

    testWidgets('error takes precedence over warning', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasTextInput(errorText: 'Invalid email', warningText: 'Username is taken'),
        ),
      );
      expect(find.text('Invalid email'), findsOneWidget);
      expect(find.text('Username is taken'), findsNothing);
    });

    testWidgets('uses warning border colour when warningText is set', (tester) async {
      const warningColour = Color(0xFF00FF00);
      await tester.pumpWidget(
        Harness(
          child: const DievasTextInput(warningText: 'Watch out'),
          themeOverrides: (theme) => theme.copyWith(
            components: theme.components.copyWith(
              textInput: theme.components.textInput.copyWith(borderColourWarning: warningColour),
            ),
          ),
        ),
      );
      final decoration = tester.widget<TextField>(find.byType(TextField)).decoration!;
      final border = decoration.enabledBorder! as OutlineInputBorder;
      expect(border.borderSide.color, warningColour);
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
