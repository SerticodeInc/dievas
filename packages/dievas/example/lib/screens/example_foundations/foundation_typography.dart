part of '../example_foundations_screen.dart';

class _TypographyScale extends StatelessWidget {
  const _TypographyScale();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('displaySM: Display', style: typography.displaySm),
        SizedBox(height: context.spacing.md),
        Text('headingMD: Heading', style: typography.headingMd),
        SizedBox(height: context.spacing.md),
        Text('titleLG: Title', style: typography.titleLg),
        SizedBox(height: context.spacing.md),
        Text('bodyMD: Body copy', style: typography.bodyMd),
        SizedBox(height: context.spacing.md),
        Text('labelMD: Label', style: typography.labelMd),
        SizedBox(height: context.spacing.md),
        Text('codeMD: Inline code', style: typography.codeMd),
      ],
    );
  }
}
