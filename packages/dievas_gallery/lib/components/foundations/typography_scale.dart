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
    final colors = DievasTheme.colorsOf(context);

    final entries = [
      ('displayLg', t.displayLg),
      ('displayMd', t.displayMd),
      ('displaySm', t.displaySm),
      ('headingXl', t.headingXl),
      ('headingLg', t.headingLg),
      ('headingMd', t.headingMd),
      ('headingSm', t.headingSm),
      ('headingXs', t.headingXs),
      ('titleLg', t.titleLg),
      ('titleMd', t.titleMd),
      ('titleSm', t.titleSm),
      ('bodyLg', t.bodyLg),
      ('bodyMd', t.bodyMd),
      ('bodySm', t.bodySm),
      ('bodyXs', t.bodyXs),
      ('labelLg', t.labelLg),
      ('labelMd', t.labelMd),
      ('labelSm', t.labelSm),
      ('labelXs', t.labelXs),
      ('codeMd', t.codeMd),
      ('codeSm', t.codeSm),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, style) in entries) ...[
            _TypeRow(name: name, style: style),
            Container(
              height: 1,
              color: colors.border.borderDefault,
              margin: EdgeInsets.symmetric(vertical: context.spacing.smPlus),
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
    final colors = DievasTheme.colorsOf(context);

    final entries = [
      ('displayLg', t.displayLg),
      ('displayMd', t.displayMd),
      ('displaySm', t.displaySm),
      ('headingXl', t.headingXl),
      ('headingLg', t.headingLg),
      ('headingMd', t.headingMd),
      ('headingSm', t.headingSm),
      ('headingXs', t.headingXs),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, style) in entries) ...[
            _TypeRow(name: name, style: style),
            Container(
              height: 1,
              color: colors.border.borderDefault,
              margin: EdgeInsets.symmetric(vertical: context.spacing.smPlus),
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
    final colors = DievasTheme.colorsOf(context);

    final entries = [
      ('titleLg', t.titleLg),
      ('titleMd', t.titleMd),
      ('titleSm', t.titleSm),
      ('bodyLg', t.bodyLg),
      ('bodyMd', t.bodyMd),
      ('bodySm', t.bodySm),
      ('bodyXs', t.bodyXs),
      ('labelLg', t.labelLg),
      ('labelMd', t.labelMd),
      ('labelSm', t.labelSm),
      ('labelXs', t.labelXs),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, style) in entries) ...[
            _TypeRow(name: name, style: style),
            Container(
              height: 1,
              color: colors.border.borderDefault,
              margin: EdgeInsets.symmetric(vertical: context.spacing.smPlus),
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
    final colors = DievasTheme.colorsOf(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TypeRow(name: 'codeMd', style: t.codeMd, sample: 'final result = compute(value);'),
          Container(
            height: 1,
            color: colors.border.borderDefault,
            margin: EdgeInsets.symmetric(vertical: context.spacing.smPlus),
          ),
          _TypeRow(name: 'codeSm', style: t.codeSm, sample: 'final result = compute(value);'),
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
    ).labelXs.copyWith(color: DievasTheme.colorsOf(context).text.textTertiary, fontFamily: 'monospace');

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
        SizedBox(width: context.spacing.lg),
        Expanded(
          child: Text(sample ?? 'The quick brown fox', style: style, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
