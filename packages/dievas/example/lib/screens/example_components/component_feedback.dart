part of '../example_components_screen.dart';

class _FeedbackRow extends StatelessWidget {
  const _FeedbackRow();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: context.spacing.MD,
    runSpacing: context.spacing.MD,
    children: [
      const DievasAlert(tone: .info, title: 'Heads up', description: 'The system will update at 2am.'),
      const DievasAlert(tone: .success, title: 'Saved', description: 'Your changes are live.'),
      const DievasAlert(tone: .warning, title: 'Almost there', description: 'Complete your profile to unlock invites.'),
      const DievasAlert(tone: .error, title: 'Connection lost', description: 'Check your network and retry.'),
      DievasFilledButton(
        label: 'Bottom sheet',
        onPressed: () => showDievasBottomSheet<void>(
          context: context,
          builder: (context) => DievasBottomSheet(
            child: Padding(
              padding: .all(context.spacing.LG),
              child: Text('Bottom sheet content', style: context.typography.bodyMD),
            ),
          ),
        ),
      ),
      DievasOutlinedButton(
        label: 'Modal',
        onPressed: () => showDievasModal<void>(
          context: context,
          builder: (context) => DievasModal(
            title: 'Confirm',
            body: 'Do you want to continue?',
            actions: [DievasFilledButton(label: 'Confirm', onPressed: () => ExampleNavigation.dismiss(context))],
          ),
        ),
      ),
      DievasTooltip(
        message: 'Tooltips wrap their child.',
        child: DievasFilledButton(label: 'Hover me', onPressed: () {}),
      ),
    ],
  );
}
