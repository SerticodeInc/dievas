import 'package:dievas/dievas.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../widgets/component_boundary.dart';

final authCodeComponent = WidgetbookComponent(
  name: 'AuthCode',
  useCases: [
    WidgetbookUseCase(name: 'Playground', builder: (ctx) => const _Playground()),
    WidgetbookUseCase(name: 'Configurations', builder: (ctx) => const _Configurations()),
  ],
);

class _Playground extends StatelessWidget {
  const _Playground();

  @override
  Widget build(BuildContext context) {
    final codeLength = context.knobs.double.slider(label: 'Code Length', initialValue: 4, min: 4, max: 6).round();
    final obscureText = context.knobs.boolean(label: 'Obscure text', initialValue: false);
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

    return Center(
      child: ComponentBoundary(
        child: DievasAuthCode(codeLength: codeLength, obscureText: obscureText, enabled: enabled, onCompleted: (_) {}),
      ),
    );
  }
}

class _Configurations extends StatelessWidget {
  const _Configurations();

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.lg),
      child: Column(
        mainAxisSize: .min,
        children: [
          _DemoBlock('4-digit — plain', child: DievasAuthCode(codeLength: 4, onCompleted: (_) {})),
          SizedBox(height: context.spacing.lg),
          _DemoBlock('6-digit — plain', child: DievasAuthCode(codeLength: 6, onCompleted: (_) {})),
          SizedBox(height: context.spacing.lg),
          _DemoBlock(
            '6-digit — obscured',
            child: DievasAuthCode(codeLength: 6, obscureText: true, onCompleted: (_) {}),
          ),
          SizedBox(height: context.spacing.lg),
          _DemoBlock('4-digit — disabled', child: DievasAuthCode(codeLength: 4, enabled: false, onCompleted: (_) {})),
        ],
      ),
    ),
  );
}

class _DemoBlock extends StatelessWidget {
  const _DemoBlock(this.name, {required this.child});
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      Text(name, style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary)),
      SizedBox(height: context.spacing.sm),
      ComponentBoundary(child: child),
    ],
  );
}
