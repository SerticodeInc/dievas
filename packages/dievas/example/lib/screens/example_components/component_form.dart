part of '../example_components_screen.dart';

class _FormExamples extends StatefulWidget {
  const _FormExamples();

  @override
  State<_FormExamples> createState() => _FormExamplesState();
}

enum _Density { compact, comfortable, spacious }

enum _Plan { personal, business, enterprise }

enum _RadioOption { one, two }

class _FormExamplesState extends State<_FormExamples> {
  final _inputController = TextEditingController();
  final _areaController = TextEditingController();
  DievasCheckboxValue _checkbox = .checked;
  bool _switchOn = true;
  _RadioOption _radioOption = .one;
  _Density _density = .compact;
  _Plan? _plan;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      DievasTextInput(
        controller: _inputController,
        label: 'Email',
        hint: 'you@example.com',
        helperText: 'We never share your email.',
      ),
      SizedBox(height: context.spacing.MD),
      DievasTextArea(controller: _areaController, label: 'Message', hint: 'Write something…'),
      SizedBox(height: context.spacing.MD),
      DievasCheckbox(
        value: _checkbox,
        onChanged: (value) => setState(() => _checkbox = value),
        label: 'Subscribe to updates',
      ),
      SizedBox(height: context.spacing.MD),
      DievasSwitch(value: _switchOn, onChanged: (value) => setState(() => _switchOn = value), label: 'Notifications'),
      SizedBox(height: context.spacing.MD),
      DievasRadio<_RadioOption>(
        value: .one,
        groupValue: _radioOption,
        onChanged: (value) => setState(() => _radioOption = value),
        label: 'Option one',
      ),
      DievasRadio<_RadioOption>(
        value: .two,
        groupValue: _radioOption,
        onChanged: (value) => setState(() => _radioOption = value),
        label: 'Option two',
      ),
      SizedBox(height: context.spacing.MD),
      SingleChildScrollView(
        scrollDirection: .horizontal,
        child: DievasSegmentedControl<_Density>(
          options: _Density.values,
          value: _density,
          onChanged: (value) => setState(() => _density = value),
          labelBuilder: (value) => switch (value) {
            .compact => 'Compact',
            .comfortable => 'Comfortable',
            .spacious => 'Spacious',
          },
        ),
      ),
      SizedBox(height: context.spacing.MD),
      DievasDropdown<_Plan>(
        options: _Plan.values,
        value: _plan,
        onChanged: (value) => setState(() => _plan = value),
        labelBuilder: (value) => switch (value) {
          .personal => 'Personal',
          .business => 'Business',
          .enterprise => 'Enterprise',
        },
        hint: 'Select a plan',
        label: 'Plan',
      ),
    ],
  );

  @override
  void dispose() {
    _inputController.dispose();
    _areaController.dispose();
    super.dispose();
  }
}
