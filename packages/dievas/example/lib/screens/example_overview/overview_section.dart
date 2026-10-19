part of '../example_overview_screen.dart';

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.description, required this.child});

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final colours = context.colours;

    return Container(
      width: .infinity,
      padding: .all(spacing.lg),
      decoration: BoxDecoration(
        color: colours.background.cardBackground,
        border: .all(color: colours.border.dividerColour),
        borderRadius: context.border.lg,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: context.typography.titleLg),
          SizedBox(height: spacing.xs),
          Text(description, style: context.typography.bodySm.copyWith(color: colours.text.textSecondary)),
          SizedBox(height: spacing.lg),
          child,
        ],
      ),
    );
  }
}
