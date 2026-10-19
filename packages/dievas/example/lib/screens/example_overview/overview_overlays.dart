part of '../example_overview_screen.dart';

class _OverlayControls extends StatelessWidget {
  const _OverlayControls();

  @override
  Widget build(BuildContext context) {
    final scope = DievasScope.of(context);

    return Wrap(
      spacing: context.spacing.md,
      runSpacing: context.spacing.md,
      children: [
        DievasFilledButton(
          label: 'Show banner',
          onPressed: () => _showDievasBanner(scope: scope),
        ),
        DievasOutlinedButton(
          label: 'Show snackbar',
          onPressed: () => _showDievasSnackbar(scope: scope),
        ),
      ],
    );
  }

  void _showDievasBanner({required DievasScopeController scope}) => scope.showBanner(
    (context, _) => DievasBanner(
      tone: .info,
      message: 'This banner is rendered by DievasScope.showBanner.',
      onDismiss: scope.hideBanner,
    ),
  );

  void _showDievasSnackbar({required DievasScopeController scope}) => scope.showSnackbar(
    (context, _) => DievasSnackbar(
      message: 'Snackbar rendered by DievasScope.showSnackbar.',
      action: DievasSnackbarAction(label: 'Dismiss', onPressed: scope.hideSnackbar),
    ),
  );
}
