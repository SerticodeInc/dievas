part of '../example_overview_screen.dart';

class _ThemeModeControl extends StatelessWidget {
  const _ThemeModeControl();

  @override
  Widget build(BuildContext context) => DievasSegmentedControl<ThemeMode>(
    options: const [.system, .light, .dark],
    value: DievasScope.of(context).themeMode,
    onChanged: (mode) => DievasScope.of(context).setThemeMode(mode),
    labelBuilder: (mode) => switch (mode) {
      .system => 'System',
      .light => 'Light',
      .dark => 'Dark',
    },
  );
}
