import 'package:device_frame/device_frame.dart' as device_frame;
import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Light/dark theme modes available in the Widgetbook addon panel.
enum DievasThemeMode {
  light,
  dark;

  /// Constructs the concrete [DievasThemeData] for this mode.
  DievasThemeData get themeData => switch (this) {
    .light => DievasLightThemeData(),
    .dark => DievasDarkThemeData(),
  };

  String get displayName => switch (this) {
    .light => 'Light',
    .dark => 'Dark',
  };
}

/// Widgetbook addon that wraps each use-case canvas in [DievasScope],
/// [DievasTheme], and the Material [Theme] bridge.
///
/// Mirrors the `GenesisThemeAddon` pattern from Warlock — the addon owns a
/// dropdown for Light / Dark and injects the selected [DievasThemeData] into
/// the widget tree so all Dievas components resolve tokens correctly.
///
/// The same theme data is passed to both [DievasScope.lightTheme] and
/// [DievasScope.darkTheme] so the scope's internal brightness detection is
/// bypassed — the addon dropdown is the single source of truth.
class DievasThemeAddon extends WidgetbookAddon<WidgetbookTheme<DievasThemeData>> {
  DievasThemeAddon({this.initialMode = .light}) : super(name: 'Dievas Theme');

  final DievasThemeMode initialMode;

  @override
  List<Field> get fields => [
    ObjectDropdownField<DievasThemeMode>(
      name: 'theme',
      values: DievasThemeMode.values,
      initialValue: initialMode,
      labelBuilder: (mode) => mode.displayName,
    ),
  ];

  @override
  WidgetbookTheme<DievasThemeData> valueFromQueryGroup(Map<String, String> group) {
    final mode = valueOf<DievasThemeMode>('theme', group) ?? initialMode;
    return WidgetbookTheme(name: mode.displayName, data: mode.themeData);
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, WidgetbookTheme<DievasThemeData> setting) {
    return device_frame.DeviceFrame(
      device: device_frame.Devices.ios.iPhone12ProMax,
      screen: DievasScope(
        lightTheme: setting.data,
        darkTheme: setting.data,
        global: false,
        child: DievasTheme(
          data: setting.data,
          child: Theme(
            data: setting.data.material,
            child: Scaffold(backgroundColor: setting.data.colors.background.bgBase, body: child),
          ),
        ),
      ),
    );
  }
}
