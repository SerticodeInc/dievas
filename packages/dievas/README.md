# Dievas

The Dievas design system.

Flutter theme and component layer.

Built on [dievas_tokens](https://pub.dev/packages/dievas_tokens) for primitive and semantic design tokens.

## Features

- **Theme contract** — `DievasThemeData` interface with `DievasGlobalThemeData` as the base for brand themes.
- **Default themes** — `DievasLightThemeData` and `DievasDarkThemeData`.
- **Components** — buttons, form inputs, display, feedback, overlays, navigation, and utility widgets.
- **InheritedModel** — access theme subsystems through `context.colours`, `context.typography`, and other context extensions.
- **Responsive grid** — `DievasGrid` with layouts that adapt to breakpoints.
- **Localization** — `DievasLocalizations` delegate with a context extension.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:dievas/dievas.dart';

void main() => runApp(
    DievasScope(
      lightTheme: DievasLightThemeData(),
      darkTheme: DievasDarkThemeData(),
      child: const MyApp(),
    ),
  );


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;

    return MaterialApp(
      theme: DievasTheme.materialOf(context),
      home: Scaffold(
        backgroundColor: colours.background.bgBase,
        body: Center(
          child: DievasFilledButton(
            label: 'Hello Dievas',
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
```

## License

MIT
