# Dievas Tokens

Design token primitives and semantic layers for the [Dievas](https://dievas.serticode.com) design system.

Pure Dart. No Flutter dependency.

## Usage

```dart
import 'package:dievas_tokens/dievas_tokens.dart';

void main() {
  print(DievasColourPrimitives.blue500); // 0xFF3B82F6
  print(DievasFontWeightPrimitives.medium); // 500
}
```

## Structure

- **Primitives** — raw values (colours, typography, spacing, sizing, radius, elevation, opacity, duration, offset)
- **Semantic tokens** — role based aliases (light/dark colour schemes, typography roles, spacing scale, etc.)

## License

MIT
