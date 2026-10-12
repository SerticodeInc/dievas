import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';

/// Shared reading width, safe area and scroll clearance for the floating tabs.
class ExamplePage extends StatelessWidget {
  const ExamplePage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const pageMaxWidth = 800.0;
    const floatingNavigationClearance = 120.0;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          context.spacing.lg,
          context.spacing.x2l,
          context.spacing.lg,
          floatingNavigationClearance + MediaQuery.paddingOf(context).bottom,
        ),
        child: Align(
          alignment: .topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: pageMaxWidth),
            child: child,
          ),
        ),
      ),
    );
  }
}
