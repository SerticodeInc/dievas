import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Displays the approved Dievas SVG without changing its brand colours.
class DievasLogo extends StatelessWidget {
  const DievasLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) =>
      SvgPicture.asset('assets/branding/dievas-logo.svg', width: size, height: size, semanticsLabel: 'Dievas logo');
}
