import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Adds a visual section heading without introducing a query parameter.
extension KnobSections on BuildContext {
  void knobSection(String title) => knobs.onKnobAdded(_SectionKnob(title));
}

class _SectionKnob extends Knob<bool?> {
  _SectionKnob(String title) : super(label: title, initialValue: true);

  @override
  List<Field> get fields => const [];

  @override
  bool valueFromQueryGroup(Map<String, String> group) => true;

  @override
  Widget buildFields(BuildContext context) => _SectionHeading(title: label);
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 4),
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        const Divider(),
        Text(title, style: Theme.of(context).textTheme.titleSmall),
      ],
    ),
  );
}
