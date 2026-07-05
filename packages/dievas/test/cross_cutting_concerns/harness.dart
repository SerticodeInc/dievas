import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';

class Harness extends StatelessWidget {
  const Harness({super.key, required this.child, this.themeOverrides});

  final Widget child;
  final DievasThemeData Function(DievasThemeData theme)? themeOverrides;

  @override
  Widget build(BuildContext context) {
    final light = themeOverrides?.call(DievasLightThemeData()) ?? DievasLightThemeData();
    final dark = themeOverrides?.call(DievasDarkThemeData()) ?? DievasDarkThemeData();
    return DievasScope(
      lightTheme: light,
      darkTheme: dark,
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }
}
