import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'types/dievas_button_state.dart';

/// Switches between [content] and [loader] based on [state].
///
/// The loader occupies exactly the same footprint as the content — the content
/// drives the layout, the loader is overlaid and painted when loading is active.
/// This prevents any layout shift when the state transitions.
@internal
class DievasButtonStateSwitcher extends StatelessWidget {
  const DievasButtonStateSwitcher({super.key, required this.state, required this.content, required this.loader});

  final DievasButtonState state;
  final Widget content;
  final Widget loader;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: .center,
    children: [
      /// Content is always laid out to preserve button dimensions.
      Opacity(opacity: state == .loading ? 0 : 1, child: content),
      if (state == .loading) loader,
    ],
  );
}
