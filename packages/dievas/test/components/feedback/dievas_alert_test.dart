import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasAlert', () {
    for (final tone in DievasAlertTone.values) {
      testWidgets('renders $tone tone without throwing', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: DievasAlert(tone: tone, title: 'Title'),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    }

    for (final variant in DievasAlertVariant.values) {
      testWidgets('$variant resolves the surface and optional border', (tester) async {
        await tester.pumpWidget(
          Harness(
            child: DievasAlert(variant: variant, tone: .success, title: 'Status', showLeading: false),
          ),
        );
        final context = tester.element(find.byType(DievasAlert));
        final colours = DievasTheme.coloursOf(context);
        final box = tester
            .widget<DecoratedBox>(
              find.descendant(of: find.byType(DievasAlert), matching: find.byType(DecoratedBox)).first,
            )
            .decoration;
        if (box case BoxDecoration(:final color, :final border)) {
          expect(color, switch (variant) {
            .base => colours.background.cardBackground,
            .filled => colours.feedback.feedbackSuccess.background,
            .outlined => Colors.transparent,
          });
          expect(border != null, variant == DievasAlertVariant.outlined);
        } else {
          fail('Alert must expose its surface decoration');
        }
        expect(find.byIcon(Icons.check_circle), findsNothing);
      });
    }

    testWidgets('custom slots inherit independent colours and border overrides', (tester) async {
      await tester.pumpWidget(
        const Harness(
          child: DievasAlert(
            title: 'Fallback',
            label: Text('Label'),
            content: Text('Content'),
            leading: Icon(Icons.star),
            trailing: Icon(Icons.arrow_forward),
            leadingColour: Colors.red,
            labelColour: Colors.green,
            trailingColour: Colors.blue,
            contentColour: Colors.orange,
            backgroundColour: Colors.white,
            borderColour: Colors.purple,
            showBorder: true,
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
        ),
      );
      expect(find.text('Fallback'), findsNothing);
      expect(DefaultTextStyle.of(tester.element(find.text('Label'))).style.color, Colors.green);
      expect(DefaultTextStyle.of(tester.element(find.text('Content'))).style.color, Colors.orange);
      expect(IconTheme.of(tester.element(find.byIcon(Icons.star))).color, Colors.red);
      expect(IconTheme.of(tester.element(find.byIcon(Icons.arrow_forward))).color, Colors.blue);
      final box = tester
          .widget<DecoratedBox>(
            find.descendant(of: find.byType(DievasAlert), matching: find.byType(DecoratedBox)).first,
          )
          .decoration;
      expect(
        box,
        const BoxDecoration(
          color: Colors.white,
          border: Border.fromBorderSide(BorderSide(color: Colors.purple)),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      );
    });

    testWidgets('disabled trailing action does not fire and can be hidden', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(title: 'Disabled', disabled: true, onDismiss: () => taps++),
        ),
      );
      await tester.tap(find.byIcon(Icons.close));
      expect(taps, 0);
      expect(tester.widget<IconButton>(find.byType(IconButton)).onPressed, isNull);
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(title: 'Hidden action', showTrailing: false, onDismiss: () => taps++),
        ),
      );
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAlert(tone: .info, title: 'Hello Alert'),
        ),
      );
      expect(find.text('Hello Alert'), findsOneWidget);
    });

    testWidgets('renders description when provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasAlert(tone: .info, title: 'Title', description: 'Description text'),
        ),
      );
      expect(find.text('Description text'), findsOneWidget);
    });

    testWidgets('renders dismiss button when onDismiss provided', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(tone: .info, title: 'Title', onDismiss: () {}),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('fires onDismiss when close icon tapped', (tester) async {
      bool dismissed = false;
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(tone: .info, title: 'Title', onDismiss: () => dismissed = true),
        ),
      );
      await tester.tap(find.byIcon(Icons.close));
      expect(dismissed, isTrue);
    });

    testWidgets('renders custom leading icon', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: DievasAlert(
            tone: .info,
            title: 'Title',
            leadingIcon: const Icon(Icons.star, key: Key('custom_icon')),
          ),
        ),
      );
      expect(find.byKey(const Key('custom_icon')), findsOneWidget);
    });

    testWidgets('renders default icon for each tone', (tester) async {
      for (final tone in DievasAlertTone.values) {
        await tester.pumpWidget(
          Harness(
            child: DievasAlert(tone: tone, title: 'Title'),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('shrink-wraps vertically inside a loose bounded parent', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: Center(
                child: DievasAlert(tone: .info, title: 'Title', description: 'Description text'),
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(DievasAlert)).height, lessThan(200));
    });
  });
}
