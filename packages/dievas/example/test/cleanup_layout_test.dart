import 'package:dievas/dievas.dart';
import 'package:dievas_example/screens/example_foundations_screen.dart';
import 'package:dievas_example/main.dart' as example;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  testWidgets('floating tabs retain selection and small-screen content scrolls clear', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    example.main();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(NavigationBar), findsOneWidget);
    final tabs = tester.getRect(find.byType(NavigationBar));
    expect(tabs.left, greaterThan(0));
    expect(tabs.right, lessThan(375));
    expect(tabs.bottom, lessThan(812));
    await tester.tap(find.text('Foundations').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex, 1);
    expect(find.text('Colour'), findsOneWidget);
    final themeContext = tester.element(find.byType(ExampleFoundationsScreen));
    expect(tester.getSize(find.byType(DievasFilledButton).first).height, themeContext.sizing.buttonHeightMD);
    expect(tester.getSize(find.byType(DievasTextInput)).height, themeContext.sizing.inputHeightMD);
    final motion = find.descendant(of: find.byType(AnimatedAlign), matching: find.byType(CircleAvatar));
    await tester.ensureVisible(find.text('Replay motion'));
    await tester.pump();
    final start = tester.getCenter(motion).dx;
    await tester.tap(find.text('Replay motion'));
    await tester.pump();
    await tester.pump(themeContext.animation.standard);
    expect(tester.getCenter(motion).dx, greaterThan(start));
    await tester.tap(find.text('Replay motion'));
    await tester.pump();
    await tester.pump(themeContext.animation.standard);
    expect(tester.getCenter(motion).dx, closeTo(start, 0.01));

    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Components').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex, 2);
    expect(tester.takeException(), isNull);
  });
}
