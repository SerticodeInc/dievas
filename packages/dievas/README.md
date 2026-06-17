# Dievas

The Dievas design system.

Flutter theme and component layer.

Built on [dievas_tokens](https://pub.dev/packages/dievas_tokens) for primitive and semantic design tokens.

## Features

- **Theme contract** — `DievasThemeData` interface with `DievasGlobalThemeData` sealed abstract base for brand themes
- **Default themes** — `DievasLightThemeData` and `DievasDarkThemeData`
- **35+ components** — buttons, form inputs, display, feedback, overlays, navigation, and utility widgets
- **InheritedModel** — efficient sub-system accessors (`context.colors`, `context.typography`, etc.)
- **Responsive grid** — `DievasGrid` with breakpoint-aware layout
- **Localization** — `DievasLocalizations` delegate with context extension

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
    final colors = context.colors;

    return MaterialApp(
      theme: context.theme.material,
      home: Scaffold(
        backgroundColor: colors.background.bgBase,
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
