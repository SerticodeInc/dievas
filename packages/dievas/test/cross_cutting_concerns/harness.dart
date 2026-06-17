import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Harness extends StatelessWidget {
  const Harness({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => DievasScope(
    lightTheme: DievasLightThemeData(),
    darkTheme: DievasDarkThemeData(),
    child: MaterialApp(home: Scaffold(body: child)),
  );
}
