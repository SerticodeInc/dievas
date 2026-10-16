import 'package:dievas/dievas.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

final typographyScaleComponent = WidgetbookComponent(
  name: 'Typography Scale',
  useCases: [
    WidgetbookUseCase(name: 'Full Scale', builder: (ctx) => const _FullScale()),
    WidgetbookUseCase(name: 'Display & Heading', builder: (ctx) => const _DisplayHeading()),
    WidgetbookUseCase(name: 'Body & Label', builder: (ctx) => const _BodyLabel()),
    WidgetbookUseCase(name: 'Code', builder: (ctx) => const _Code()),
  ],
);

class _FullScale extends StatelessWidget {
  const _FullScale();

  @override
  Widget build(BuildContext context) {
    final t = DievasTheme.typographyOf(context);
    final colours = DievasTheme.coloursOf(context);

    final entries = [
      ('displayLG', t.displayLG),
      ('displayMD', t.displayMD),
      ('displaySM', t.displaySM),
      ('headingXL', t.headingXL),
      ('headingLG', t.headingLG),
      ('headingMD', t.headingMD),
      ('headingSM', t.headingSM),
      ('headingXS', t.headingXS),
      ('titleLG', t.titleLG),
      ('titleMD', t.titleMD),
      ('titleSM', t.titleSM),
      ('bodyLG', t.bodyLG),
      ('bodyMD', t.bodyMD),
      ('bodySM', t.bodySM),
      ('bodyXS', t.bodyXS),
      ('labelLG', t.labelLG),
      ('labelMD', t.labelMD),
      ('labelSM', t.labelSM),
      ('labelXS', t.labelXS),
      ('codeMD', t.codeMD),
      ('codeSM', t.codeSM),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.LG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, style) in entries) ...[
            _TypeRow(name: name, style: style),
            Container(
              height: 1,
              color: colours.border.borderDefault,
              margin: EdgeInsets.symmetric(vertical: context.spacing.SMPlus),
            ),
          ],
        ],
      ),
    );
  }
}

class _DisplayHeading extends StatelessWidget {
  const _DisplayHeading();

  @override
  Widget build(BuildContext context) {
    final t = DievasTheme.typographyOf(context);
    final colours = DievasTheme.coloursOf(context);

    final entries = [
      ('displayLG', t.displayLG),
      ('displayMD', t.displayMD),
      ('displaySM', t.displaySM),
      ('headingXL', t.headingXL),
      ('headingLG', t.headingLG),
      ('headingMD', t.headingMD),
      ('headingSM', t.headingSM),
      ('headingXS', t.headingXS),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.LG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, style) in entries) ...[
            _TypeRow(name: name, style: style),
            Container(
              height: 1,
              color: colours.border.borderDefault,
              margin: EdgeInsets.symmetric(vertical: context.spacing.SMPlus),
            ),
          ],
        ],
      ),
    );
  }
}

class _BodyLabel extends StatelessWidget {
  const _BodyLabel();

  @override
  Widget build(BuildContext context) {
    final t = DievasTheme.typographyOf(context);
    final colours = DievasTheme.coloursOf(context);

    final entries = [
      ('titleLG', t.titleLG),
      ('titleMD', t.titleMD),
      ('titleSM', t.titleSM),
      ('bodyLG', t.bodyLG),
      ('bodyMD', t.bodyMD),
      ('bodySM', t.bodySM),
      ('bodyXS', t.bodyXS),
      ('labelLG', t.labelLG),
      ('labelMD', t.labelMD),
      ('labelSM', t.labelSM),
      ('labelXS', t.labelXS),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.LG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, style) in entries) ...[
            _TypeRow(name: name, style: style),
            Container(
              height: 1,
              color: colours.border.borderDefault,
              margin: EdgeInsets.symmetric(vertical: context.spacing.SMPlus),
            ),
          ],
        ],
      ),
    );
  }
}

class _Code extends StatelessWidget {
  const _Code();

  @override
  Widget build(BuildContext context) {
    final t = DievasTheme.typographyOf(context);
    final colours = DievasTheme.coloursOf(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.LG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TypeRow(name: 'codeMD', style: t.codeMD, sample: 'final result = compute(value);'),
          Container(
            height: 1,
            color: colours.border.borderDefault,
            margin: EdgeInsets.symmetric(vertical: context.spacing.SMPlus),
          ),
          _TypeRow(name: 'codeSM', style: t.codeSM, sample: 'final result = compute(value);'),
        ],
      ),
    );
  }
}

class _TypeRow extends StatelessWidget {
  const _TypeRow({required this.name, required this.style, this.sample});

  final String name;
  final TextStyle style;
  final String? sample;

  @override
  Widget build(BuildContext context) {
    final labelStyle = DievasTheme.typographyOf(
      context,
    ).labelXS.copyWith(color: DievasTheme.coloursOf(context).text.textTertiary, fontFamily: 'monospace');

    final size = style.fontSize;
    final weight = style.fontWeight?.value ?? 3;
    final meta = size != null ? '${size.toStringAsFixed(0)}sp · w${(weight + 1) * 100}' : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 120, // type row label column — gallery-only fixed width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: labelStyle),
              if (meta.isNotEmpty) Text(meta, style: labelStyle),
            ],
          ),
        ),
        SizedBox(width: context.spacing.LG),
        Expanded(
          child: Text(sample ?? 'The quick brown fox', style: style, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
