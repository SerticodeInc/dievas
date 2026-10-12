part of '../example_foundations_screen.dart';

class _TypographyScale extends StatelessWidget {
  const _TypographyScale();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('displaySm: Display', style: typography.displaySm),
        SizedBox(height: context.spacing.md),
        Text('headingMd: Heading', style: typography.headingMd),
        SizedBox(height: context.spacing.md),
        Text('titleLg: Title', style: typography.titleLg),
        SizedBox(height: context.spacing.md),
        Text('bodyMd: Body copy', style: typography.bodyMd),
        SizedBox(height: context.spacing.md),
        Text('labelMd: Label', style: typography.labelMd),
        SizedBox(height: context.spacing.md),
        Text('codeMd: Inline code', style: typography.codeMd),
      ],
    );
  }
}
