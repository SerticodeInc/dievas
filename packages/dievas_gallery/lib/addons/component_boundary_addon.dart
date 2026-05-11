import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_boundary.dart';

/// Widgetbook addon that toggles a visible boundary around components.
///
/// When enabled, every [ComponentBoundary] in the use-case tree renders a
/// hot-pink 1dp border, making the component's exact footprint visible.
class ComponentBoundaryAddon extends WidgetbookAddon<bool> {
  ComponentBoundaryAddon() : super(name: 'Component Boundary');

  @override
  List<Field> get fields => [BooleanField(name: 'show_boundary', initialValue: false)];

  @override
  bool valueFromQueryGroup(Map<String, String> group) => valueOf('show_boundary', group) ?? false;

  @override
  Widget buildUseCase(BuildContext context, Widget child, bool setting) =>
      ComponentBoundaryScope(show: setting, child: child);
}
