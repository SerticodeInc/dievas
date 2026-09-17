import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// Closing — soft brand glow that eases the page into the footer.
///
/// The install island was dropped; the hero now owns the install + gallery
/// actions. What remains is the island's radial brand glow, applied to the
/// section itself so the transition into the footer still breathes.
class Closing extends StatelessComponent {
  const Closing({super.key});

  @override
  Component build(BuildContext context) => section(classes: 'closing', []);
}