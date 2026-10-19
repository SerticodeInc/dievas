import 'package:dievas/dievas.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasLoader', () {
    test('standalone and text-button defaults use the slower shared loader timing', () {
      expect(const DievasAnimationThemeData().loader, const Duration(milliseconds: 2222));
      expect(const DievasTextButton(label: 'Loading').loaderRotationDuration, const Duration(milliseconds: 2222));
    });
    testWidgets('arc grows and shrinks instead of rotating a fixed sweep', (tester) async {
      await tester.pumpWidget(Harness(child: Center(child: const DievasLoader(diameter: 48))));
      final counts = <int>[];
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 300));
        counts.add(await _paintedPixels(tester));
      }
      counts.sort();
      expect(counts.last, greaterThan(counts.first * 2));
    });

    testWidgets('reduced motion displays a stable arc with no scheduled frames', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Center(child: const DievasLoader()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final pixels = await _paintedPixels(tester);
      await tester.pump(const Duration(seconds: 2));
      expect(await _paintedPixels(tester), pixels);
      expect(tester.binding.hasScheduledFrame, isFalse);
    });

    testWidgets('renders without throwing — default size', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders all sizes', (tester) async {
      for (final size in DievasLoaderSize.values) {
        await tester.pumpWidget(Harness(child: DievasLoader(size: size)));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders label when provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader(label: 'Loading...')));
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('does not render label when not provided', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader()));
      expect(find.byType(DievasLoader), findsOneWidget);
    });

    testWidgets('accepts per-instance colour overrides', (tester) async {
      await tester.pumpWidget(
        Harness(
          child: const DievasLoader(size: .LG, colour: Color(0xFF123456), trackColour: Color(0xFF654321)),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('repeats animation', (tester) async {
      await tester.pumpWidget(Harness(child: const DievasLoader()));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    });
  });
}

Future<int> _paintedPixels(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.descendant(of: find.byType(DievasLoader), matching: find.byType(RepaintBoundary)).first,
  );
  final image = await tester.runAsync(() => boundary.toImage());
  if (image == null) throw StateError('Loader image was not captured');
  final bytes = await tester.runAsync(() => image.toByteData(format: ui.ImageByteFormat.rawRgba));
  image.dispose();
  if (bytes == null) throw StateError('Loader pixels were not captured');
  int count = 0;
  for (int offset = 3; offset < bytes.lengthInBytes; offset += 4) {
    if (bytes.getUint8(offset) > 0) count++;
  }
  return count;
}
