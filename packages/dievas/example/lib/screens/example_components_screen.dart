import 'package:flutter/material.dart';

import 'package:dievas/dievas.dart';

/// Components — the Dievas widget library in action.
///
/// One section per component group. Every component reads its colours, sizes
/// and spacing from the theme — none of the values below are hardcoded.
class ExampleComponentsScreen extends StatefulWidget {
  const ExampleComponentsScreen({super.key});

  @override
  State<ExampleComponentsScreen> createState() => _ExampleComponentsScreenState();
}

class _ExampleComponentsScreenState extends State<ExampleComponentsScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  DievasCheckboxValue _checkbox = .checked;
  bool _switchOn = true;
  int _radioGroup = 1;
  String _segmented = 'Compact';
  String? _dropdown;

  @override
  void dispose() {
    _inputController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: .symmetric(horizontal: context.spacing.xl, vertical: context.spacing.x2l),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Text('Components', style: context.typography.displaySm),
        SizedBox(height: context.spacing.sm),
        Text(
          'All values come from context.* — nothing is hardcoded.',
          style: context.typography.bodyMd.copyWith(color: context.colours.text.textSecondary),
        ),
        SizedBox(height: context.spacing.x2l),

        const _GroupLabel('Buttons'),
        _ButtonRow(),
        SizedBox(height: context.spacing.x3l),

        const _GroupLabel('Form'),
        DievasTextInput(
          controller: _inputController,
          label: 'Email',
          hint: 'you@example.com',
          helperText: 'We never share your email.',
        ),
        SizedBox(height: context.spacing.md),
        DievasTextArea(controller: _areaController, label: 'Message', hint: 'Write something…'),
        SizedBox(height: context.spacing.md),
        DievasCheckbox(
          value: _checkbox,
          onChanged: (v) => setState(() => _checkbox = v),
          label: 'Subscribe to updates',
        ),
        SizedBox(height: context.spacing.md),
        DievasSwitch(value: _switchOn, onChanged: (v) => setState(() => _switchOn = v), label: 'Notifications'),
        SizedBox(height: context.spacing.md),
        DievasRadio<int>(
          value: 1,
          groupValue: _radioGroup,
          onChanged: (v) => setState(() => _radioGroup = v),
          label: 'Option one',
        ),
        DievasRadio<int>(
          value: 2,
          groupValue: _radioGroup,
          onChanged: (v) => setState(() => _radioGroup = v),
          label: 'Option two',
        ),
        SizedBox(height: context.spacing.md),
        DievasSegmentedControl<String>(
          options: const ['Compact', 'Comfortable', 'Spacious'],
          value: _segmented,
          onChanged: (v) => setState(() => _segmented = v),
        ),
        SizedBox(height: context.spacing.md),
        DievasDropdown<String>(
          options: const ['Personal', 'Business', 'Enterprise'],
          value: _dropdown,
          onChanged: (v) => setState(() => _dropdown = v),
          hint: 'Select a plan',
          label: 'Plan',
        ),
        SizedBox(height: context.spacing.x3l),

        const _GroupLabel('Display'),
        const _DisplayRow(),
        SizedBox(height: context.spacing.lg),
        const _ProgressRow(),
        SizedBox(height: context.spacing.x3l),

        const _GroupLabel('Feedback & overlays'),
        _FeedbackRow(),
        SizedBox(height: context.spacing.lg),
        const DievasLoader(label: 'Loading…'),
        SizedBox(height: context.spacing.x3l),

        const _GroupLabel('Empty state'),
        const DievasEmptyState(title: 'No projects yet', description: 'Create your first project to get started.'),
        SizedBox(height: context.spacing.x3l),
      ],
    ),
  );
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .only(bottom: context.spacing.md),
    child: Text(
      text.toUpperCase(),
      style: context.typography.labelXs.copyWith(letterSpacing: 1.8, color: context.colours.text.textTertiary),
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
      DievasOutlinedButton(label: 'Outlined', onPressed: () {}),
      DievasTextButton(label: 'Text', onPressed: () {}),
      DievasIconButton(icon: const Icon(Icons.favorite_outline), semanticLabel: 'Like', onPressed: () {}),
      DievasFilledButton(label: 'Disabled', onPressed: () {}, state: .disabled),
      DievasOutlinedButton(label: 'Loading', onPressed: () {}, state: .loading),
    ],
  );
}

class _DisplayRow extends StatelessWidget {
  const _DisplayRow();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: context.spacing.md,
    runSpacing: context.spacing.md,
    crossAxisAlignment: .center,
    children: [
      // Per-instance colour overrides (added for per-component customization).
      const DievasAvatar(initials: 'DX'),
      DievasAvatar(
        initials: 'DX',
        backgroundColour: context.colours.action.actionPrimary,
        initialsColour: context.colours.core.onBrand,
      ),
      const DievasBadge(label: 'New', tone: .primary),
      const DievasBadge(label: 'Shipped', tone: .success),
      const DievasTag(label: 'Flutter'),
      DievasTag(label: 'Removable', onRemove: () {}, backgroundColor: context.colours.action.actionSecondary),
      const DievasIcon(Icons.bolt, size: .lg, semanticLabel: 'Bolt'),
      const DievasDivider(),
    ],
  );
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: context.spacing.md,
    runSpacing: context.spacing.md,
    crossAxisAlignment: .center,
    children: [
      SizedBox(width: 160, child: DievasLinearProgress(value: 0.65)),
      SizedBox(width: 160, child: DievasLinearProgress(value: null)),
      const DievasCircularProgress(value: 0.65),
      const DievasCircularProgress(value: null),
    ],
  );
}

class _FeedbackRow extends StatelessWidget {
  const _FeedbackRow();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: context.spacing.md,
    runSpacing: context.spacing.md,
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
              padding: .all(context.spacing.lg),
              child: Text('Bottom sheet content', style: context.typography.bodyMd),
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
            actions: [DievasFilledButton(label: 'Confirm', onPressed: () => Navigator.of(context).pop())],
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
