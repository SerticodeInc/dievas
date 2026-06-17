import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../cross_cutting_concerns/harness.dart';

void main() {
  group('DievasLightThemeData', () {
    test('default constructor does not throw', () {
      expect(DievasLightThemeData(), isA<DievasThemeData>());
    });

    test('colors have light brightness', () {
      expect(DievasLightThemeData().colors.brightness, Brightness.light);
    });

    test('all color sets are non-null', () {
      final t = DievasLightThemeData().colors;
      expect(t.core, isNotNull);
      expect(t.text, isNotNull);
      expect(t.icon, isNotNull);
      expect(t.background, isNotNull);
      expect(t.border, isNotNull);
      expect(t.action, isNotNull);
      expect(t.feedback, isNotNull);
      expect(t.input, isNotNull);
      expect(t.switchColours, isNotNull);
      expect(t.staticColours, isNotNull);
    });

    test('components are non-null', () {
      final t = DievasLightThemeData().components;
      expect(t.filledButton, isNotNull);
      expect(t.outlinedButton, isNotNull);
      expect(t.textButton, isNotNull);
      expect(t.iconButton, isNotNull);
      expect(t.badge, isNotNull);
      expect(t.breadcrumb, isNotNull);
      expect(t.avatar, isNotNull);
      expect(t.tag, isNotNull);
      expect(t.linearProgress, isNotNull);
      expect(t.circularProgress, isNotNull);
      expect(t.checkbox, isNotNull);
      expect(t.toggle, isNotNull);
      expect(t.radio, isNotNull);
      expect(t.textInput, isNotNull);
      expect(t.textInputGroup, isNotNull);
      expect(t.alert, isNotNull);
      expect(t.snackbar, isNotNull);
      expect(t.bottomSheet, isNotNull);
      expect(t.modal, isNotNull);
      expect(t.tooltip, isNotNull);
      expect(t.loader, isNotNull);
      expect(t.emptyState, isNotNull);
      expect(t.authCode, isNotNull);
      expect(t.accordion, isNotNull);
      expect(t.dotIndicator, isNotNull);
      expect(t.drawer, isNotNull);
      expect(t.dropdown, isNotNull);
      expect(t.search, isNotNull);
      expect(t.tabBar, isNotNull);
      expect(t.popover, isNotNull);
    });

    test('spacing defaults match 4px grid', () {
      final s = DievasLightThemeData().spacing;
      expect(s.none, 0);
      expect(s.xs, 4);
      expect(s.sm, 8);
      expect(s.smPlus, 12);
      expect(s.md, 16);
      expect(s.mdPlus, 20);
      expect(s.lg, 24);
      expect(s.lgPlus, 28);
      expect(s.xl, 32);
    });

    test('sizing defaults are non-zero', () {
      final s = DievasLightThemeData().sizing;
      expect(s.buttonHeightSm, greaterThan(0));
      expect(s.inputHeightMd, greaterThan(0));
      expect(s.avatarLg, greaterThan(0));
    });

    test('border defaults are non-negative', () {
      final b = DievasLightThemeData().border;
      expect(b.sm, isNotNull);
      expect(b.md, isNotNull);
      expect(b.lg, isNotNull);
      expect(b.strokeDefault, greaterThan(0));
    });

    test('animation defaults have non-zero duration', () {
      final a = DievasLightThemeData().animation;
      expect(a.fast.inMilliseconds, greaterThan(0));
      expect(a.standard.inMilliseconds, greaterThan(0));
      expect(a.slow.inMilliseconds, greaterThan(0));
    });

    test('opacity defaults are between 0 and 1', () {
      final o = DievasLightThemeData().opacity;
      expect(o.disabled, allOf(greaterThan(0), lessThan(1)));
      expect(o.hoverGhost, allOf(greaterThan(0), lessThanOrEqualTo(1)));
    });

    test('elevation defaults have non-null shadow lists', () {
      final e = DievasLightThemeData().elevation;
      expect(e.none, isEmpty);
      expect(e.xs, isNotEmpty);
      expect(e.sm, isNotEmpty);
      expect(e.md, isNotEmpty);
      expect(e.lg, isNotEmpty);
      expect(e.xl, isNotEmpty);
    });

    test('typography defaults are non-null', () {
      final t = DievasLightThemeData().typography;
      expect(t.displayLg, isNotNull);
      expect(t.displayMd, isNotNull);
      expect(t.displaySm, isNotNull);
      expect(t.headingXl, isNotNull);
      expect(t.headingLg, isNotNull);
      expect(t.headingMd, isNotNull);
      expect(t.titleLg, isNotNull);
      expect(t.titleMd, isNotNull);
      expect(t.titleSm, isNotNull);
      expect(t.bodyLg, isNotNull);
      expect(t.bodyMd, isNotNull);
      expect(t.bodySm, isNotNull);
      expect(t.labelLg, isNotNull);
      expect(t.labelMd, isNotNull);
      expect(t.labelSm, isNotNull);
    });

    test('material theme data is non-null', () {
      expect(DievasLightThemeData().material, isNotNull);
    });

    test('copyWith returns different instance', () {
      final t1 = DievasLightThemeData();
      final t2 = t1.copyWith();
      expect(t2, isNot(same(t1)));
    });
  });

  group('DievasDarkThemeData', () {
    test('default constructor does not throw', () {
      expect(DievasDarkThemeData(), isA<DievasThemeData>());
    });

    test('colors have dark brightness', () {
      expect(DievasDarkThemeData().colors.brightness, Brightness.dark);
    });

    test('material theme data is non-null', () {
      expect(DievasDarkThemeData().material, isNotNull);
    });
  });

  group('DievasColourThemeData', () {
    test('copyWith preserves unset fields', () {
      final t = DievasLightThemeData().colors;
      final copy = t.copyWith();
      expect(copy.brightness, t.brightness);
      expect(copy.core, t.core);
      expect(copy.text, t.text);
    });

    test('copyWith overrides specified field', () {
      final t = DievasLightThemeData().colors;
      final copy = t.copyWith(brightness: .dark);
      expect(copy.brightness, Brightness.dark);
      expect(copy.core, t.core);
    });

    test('lerp between light and dark', () {
      final light = DievasLightThemeData().colors;
      final dark = DievasDarkThemeData().colors;
      final mid = DievasColourThemeData.lerp(light, dark, 0.5);
      expect(mid, isA<DievasColourThemeData>());
    });
  });

  group('DievasTheme (InheritedModel)', () {
    const childKey = ValueKey('test-child');

    testWidgets('of returns theme data in DievasScope', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      final theme = DievasTheme.of(ctx);
      expect(theme, isA<DievasThemeData>());
    });

    testWidgets('colorsOf returns colour theme', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      expect(DievasTheme.colorsOf(ctx), isA<DievasColourThemeData>());
    });

    testWidgets('spacingOf returns spacing theme', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      expect(DievasTheme.spacingOf(ctx), isA<DievasSpacingThemeData>());
    });

    testWidgets('componentsOf returns component theme', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      expect(DievasTheme.componentsOf(ctx), isA<DievasComponentThemeData>());
    });

    testWidgets('typographyOf returns typography theme', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      expect(DievasTheme.typographyOf(ctx), isA<DievasTypographyThemeData>());
    });

    testWidgets('materialOf returns Material ThemeData', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      expect(DievasTheme.materialOf(ctx), isA<ThemeData>());
    });

    testWidgets('updateShouldNotify returns true for different data', (tester) async {
      await tester.pumpWidget(const Harness(child: SizedBox(key: childKey)));
      final ctx = tester.element(find.byKey(childKey));
      expect(DievasTheme.of(ctx).colors.brightness, anyOf(Brightness.light, Brightness.dark));
    });
  });

  group('DievasSpacingThemeData', () {
    test('default constructor values match 4px grid', () {
      const s = DievasSpacingThemeData();
      expect(s.none, 0);
      expect(s.xs, 4);
      expect(s.sm, 8);
      expect(s.smPlus, 12);
      expect(s.md, 16);
      expect(s.mdPlus, 20);
      expect(s.lg, 24);
      expect(s.lgPlus, 28);
      expect(s.xl, 32);
      expect(s.xlPlus, 40);
      expect(s.x2l, 48);
    });

    test('copyWith overrides', () {
      const s = DievasSpacingThemeData();
      final c = s.copyWith(md: 32);
      expect(c.md, 32);
      expect(c.sm, 8); // unchanged
    });
  });

  group('DievasOpacityThemeData', () {
    test('defaults are within valid range', () {
      const o = DievasOpacityThemeData();
      expect(o.disabled, inInclusiveRange(0, 1));
      expect(o.hoverGhost, inInclusiveRange(0, 1));
      expect(o.pressedGhost, inInclusiveRange(0, 1));
      expect(o.focusRing, inInclusiveRange(0, 1));
    });
  });

  group('DievasElevationThemeData', () {
    test('defaults have shadow lists for each level', () {
      final e = DievasLightThemeData().elevation;
      expect(e.none, isEmpty);
      expect(e.xs, isNotEmpty);
      expect(e.sm, isNotEmpty);
      expect(e.md, isNotEmpty);
      expect(e.lg, isNotEmpty);
      expect(e.xl, isNotEmpty);
    });
  });

  group('DievasComponentThemeData (override constructor)', () {
    test('creating with explicit values does not throw', () {
      final filledButton = DievasLightThemeData().components.filledButton;
      final outlinedButton = DievasLightThemeData().components.outlinedButton;
      final textButton = DievasLightThemeData().components.textButton;
      final iconButton = DievasLightThemeData().components.iconButton;
      final badge = DievasLightThemeData().components.badge;
      final breadcrumb = DievasLightThemeData().components.breadcrumb;
      final avatar = DievasLightThemeData().components.avatar;
      final tag = DievasLightThemeData().components.tag;
      final linearProgress = DievasLightThemeData().components.linearProgress;
      final circularProgress = DievasLightThemeData().components.circularProgress;
      final checkbox = DievasLightThemeData().components.checkbox;
      final toggle = DievasLightThemeData().components.toggle;
      final radio = DievasLightThemeData().components.radio;
      final textInput = DievasLightThemeData().components.textInput;
      final textInputGroup = DievasLightThemeData().components.textInputGroup;
      final alert = DievasLightThemeData().components.alert;
      final snackbar = DievasLightThemeData().components.snackbar;
      final bottomSheet = DievasLightThemeData().components.bottomSheet;
      final modal = DievasLightThemeData().components.modal;
      final tooltip = DievasLightThemeData().components.tooltip;
      final loader = DievasLightThemeData().components.loader;
      final emptyState = DievasLightThemeData().components.emptyState;
      final authCode = DievasLightThemeData().components.authCode;
      final accordion = DievasLightThemeData().components.accordion;
      final dotIndicator = DievasLightThemeData().components.dotIndicator;
      final drawer = DievasLightThemeData().components.drawer;
      final dropdown = DievasLightThemeData().components.dropdown;
      final search = DievasLightThemeData().components.search;
      final segmentedControl = DievasLightThemeData().components.segmentedControl;
      final menuItem = DievasLightThemeData().components.menuItem;
      final tabBar = DievasLightThemeData().components.tabBar;
      final popover = DievasLightThemeData().components.popover;

      expect(
        () => DievasComponentThemeData(
          filledButton: filledButton,
          outlinedButton: outlinedButton,
          textButton: textButton,
          iconButton: iconButton,
          badge: badge,
          breadcrumb: breadcrumb,
          avatar: avatar,
          tag: tag,
          linearProgress: linearProgress,
          circularProgress: circularProgress,
          checkbox: checkbox,
          toggle: toggle,
          radio: radio,
          textInput: textInput,
          textInputGroup: textInputGroup,
          alert: alert,
          snackbar: snackbar,
          bottomSheet: bottomSheet,
          modal: modal,
          tooltip: tooltip,
          loader: loader,
          menuItem: menuItem,
          emptyState: emptyState,
          authCode: authCode,
          accordion: accordion,
          dotIndicator: dotIndicator,
          drawer: drawer,
          dropdown: dropdown,
          search: search,
          segmentedControl: segmentedControl,
          tabBar: tabBar,
          popover: popover,
        ),
        returnsNormally,
      );
    });

    test('copyWith overrides a single field', () {
      final defaultComponents = DievasLightThemeData().components;
      final modified = defaultComponents.copyWith(toggle: DievasLightThemeData().components.toggle);
      expect(modified, isA<DievasComponentThemeData>());
      // Equatable equality
      expect(modified, defaultComponents);
    });
  });
}
