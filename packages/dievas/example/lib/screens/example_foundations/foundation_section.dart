part of '../example_foundations_screen.dart';

class _FoundationSection extends StatelessWidget {
  const _FoundationSection({required this.title, required this.description, required this.child});

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .symmetric(vertical: context.spacing.LG),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text(title, style: context.typography.titleLG),
        SizedBox(height: context.spacing.XS),
        Text(description, style: context.typography.bodySM.copyWith(color: context.colours.text.textSecondary)),
        SizedBox(height: context.spacing.LG),
        child,
      ],
    ),
  );
}
