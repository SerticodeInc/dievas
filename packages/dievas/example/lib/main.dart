import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';

import 'package:dievas_example/example_theme/example_theme.dart';
import 'package:dievas_example/screens/example_components_screen.dart';
import 'package:dievas_example/screens/example_foundations_screen.dart';
import 'package:dievas_example/screens/example_overview_screen.dart';

// 1. Entry point
//
// The DievasScope is the root of every Dievas app. It:
//   - resolves the active theme from `themeMode` + platform brightness
//   - inserts `DievasTheme` (an InheritedModel) into the tree, so every widget below can read the theme via `context.colours`, `context.spacing`, `DievasTheme.of(context)`, etc.
//   - bridges to Material via `theme.material` (used below on MaterialApp)
//   - owns the banner/snackbar overlay controller (`DievasScope.of(context)`)
//
// This is the only place the app talks to Dievas directly.
//
// Everything below reads the theme through the context: no theme plumbing ever leaks again.
void main() => runApp(const _DievasExampleApp());

class _DievasExampleApp extends StatelessWidget {
  const _DievasExampleApp();

  @override
  Widget build(BuildContext context) => DievasScope(
    // 2. Brand themes
    //
    // The Example App defines its own light and dark themes in `example_theme/` (tokens → typography → theme data).
    // Swap these for your own brand and the whole design system re-skins itself.
    themeMode: .light,
    lightTheme: ExampleLightThemeData(),
    darkTheme: ExampleDarkThemeData(),

    // 3. Material bridge
    //
    // DievasScope rebuilds `builder` whenever the resolved theme changes (manual switch or system brightness change), so `theme.material` is always the ThemeData for the active mode.
    // Register the Dievas localizations so component internal copy resolves via `context.l10n`.
    builder: (context, theme, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dievas Example App',
      theme: theme.material,
      localizationsDelegates: DievasLocalizations.localizationsDelegates,
      supportedLocales: DievasLocalizations.supportedLocales,
      home: const _ExampleShell(),
    ),
  );
}

// 4. Shell
//
// A floating translucent tab bar hosting the three demo screens.
//
// Using the Material bridge here shows that standard Flutter widgets (NavigationBar,
// Scaffold, AppBar) pick up the Dievas theme automatically via `theme.material`.
class _ExampleShell extends StatefulWidget {
  const _ExampleShell();

  @override
  State<_ExampleShell> createState() => _ExampleShellState();
}

class _ExampleShellState extends State<_ExampleShell> {
  static const _initialTabIndex = 0;
  static const _screens = [ExampleOverviewScreen(), ExampleFoundationsScreen(), ExampleComponentsScreen()];

  int _index = _initialTabIndex;

  @override
  Widget build(BuildContext context) {
    const navigationMaxWidth = 440.0;
    const navigationPillRadius = 48.0;
    const navigationBlurSigma = 20.0;
    const navigationBackgroundOpacity = 0.9;
    const navigationHeightFactor = 1.0;
    const navigationElevation = 0.0;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(left: context.spacing.MD, right: context.spacing.MD, bottom: context.spacing.MD),
        child: Align(
          heightFactor: navigationHeightFactor,
          alignment: .bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: navigationMaxWidth),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(navigationPillRadius),
                boxShadow: context.elevation.MD,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(navigationPillRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: navigationBlurSigma, sigmaY: navigationBlurSigma),
                  child: NavigationBar(
                    backgroundColor: context.colours.background.dialogBackground.withValues(
                      alpha: MediaQuery.highContrastOf(context) ? context.opacity.opaque : navigationBackgroundOpacity,
                    ),
                    elevation: navigationElevation,
                    animationDuration: MediaQuery.disableAnimationsOf(context)
                        ? Duration.zero
                        : context.animation.standard,
                    selectedIndex: _index,
                    onDestinationSelected: (i) => setState(() => _index = i),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Overview',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.palette_outlined),
                        selectedIcon: Icon(Icons.palette),
                        label: 'Foundations',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.widgets_outlined),
                        selectedIcon: Icon(Icons.widgets),
                        label: 'Components',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
