import 'package:flutter/material.dart';
import 'package:dievas/dievas.dart';

void main() => runApp(
  DievasScope(lightTheme: DievasLightThemeData(), darkTheme: DievasDarkThemeData(), child: const DievasExampleApp()),
);

class DievasExampleApp extends StatelessWidget {
  const DievasExampleApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(debugShowCheckedModeBanner: false, home: ExampleScreen());
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Scaffold(
      backgroundColor: context.colours.background.bgBase,
      appBar: AppBar(title: const Text('Dievas Example')),
      body: Center(
        child: Padding(
          padding: .all(spacing.md),
          child: Column(
            mainAxisSize: .min,
            children: [
              Text('Dievas Design System', style: context.typography.titleLg),
              SizedBox(height: spacing.lg),
              DievasFilledButton(label: 'Get Started', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
