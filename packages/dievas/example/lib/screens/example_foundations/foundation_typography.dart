part of '../example_foundations_screen.dart';

class _TypographyScale extends StatelessWidget {
  const _TypographyScale();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('displaySM: Display', style: typography.displaySM),
        SizedBox(height: context.spacing.MD),
        Text('headingMD: Heading', style: typography.headingMD),
        SizedBox(height: context.spacing.MD),
        Text('titleLG: Title', style: typography.titleLG),
        SizedBox(height: context.spacing.MD),
        Text('bodyMD: Body copy', style: typography.bodyMD),
        SizedBox(height: context.spacing.MD),
        Text('labelMD: Label', style: typography.labelMD),
        SizedBox(height: context.spacing.MD),
        Text('codeMD: Inline code', style: typography.codeMD),
      ],
    );
  }
}
