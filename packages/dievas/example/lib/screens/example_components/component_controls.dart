part of '../example_components_screen.dart';

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .only(bottom: context.spacing.md),
    child: Text(
      text.toUpperCase(),
      style: context.typography.labelXs.copyWith(color: context.colours.text.textTertiary),
    ),
  );
}

class _ButtonRow extends StatelessWidget {
  const _ButtonRow();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: context.spacing.md,
    runSpacing: context.spacing.md,
    crossAxisAlignment: .center,
    children: [
      DievasFilledButton(label: 'Filled', onPressed: () {}),
      DievasFilledButton(label: 'Filled Loading', onPressed: () {}, state: .loading),
      DievasFilledButton(label: 'Filled Disabled', onPressed: () {}, state: .disabled),
      DievasOutlinedButton(label: 'Outlined', onPressed: () {}),
      DievasOutlinedButton(label: 'Outlined Loading', onPressed: () {}, state: .loading),
      DievasTextButton(label: 'Text Button', onPressed: () {}),
      DievasIconButton(icon: const Icon(Icons.favorite_outline), semanticLabel: 'Like Button', onPressed: () {}),
      DievasIconButton(
        icon: const Icon(Icons.favorite),
        style: .tinted,
        semanticLabel: 'Like Button, tinted',
        onPressed: () {},
      ),
    ],
  );
}
