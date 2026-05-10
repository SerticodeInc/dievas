import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'addons/component_boundary_addon.dart';
import 'addons/dievas_theme_addon.dart';

// Buttons
import 'components/buttons/dievas_filled_button.dart';
import 'components/buttons/dievas_icon_button.dart';
import 'components/buttons/dievas_outlined_button.dart';
import 'components/buttons/dievas_text_button.dart';

// Display
import 'components/display/dievas_avatar.dart';
import 'components/display/dievas_badge.dart';
import 'components/display/dievas_circular_progress.dart';
import 'components/display/dievas_divider.dart';
import 'components/display/dievas_icon.dart';
import 'components/display/dievas_linear_progress.dart';
import 'components/display/dievas_tag.dart';

// Form
import 'components/form/dievas_checkbox.dart';
import 'components/form/dievas_radio.dart';
import 'components/form/dievas_switch.dart';
import 'components/form/dievas_text_area.dart';
import 'components/form/dievas_text_input.dart';

void main() => runApp(const DievasGallery());

class DievasGallery extends StatelessWidget {
  const DievasGallery({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    directories: [
      WidgetbookCategory(
        name: 'Components',
        children: [
          WidgetbookFolder(
            name: 'Buttons',
            children: [
              filledButtonComponent,
              outlinedButtonComponent,
              textButtonComponent,
              iconButtonComponent,
            ],
          ),
          WidgetbookFolder(
            name: 'Display',
            children: [
              avatarComponent,
              badgeComponent,
              circularProgressComponent,
              dividerComponent,
              iconComponent,
              linearProgressComponent,
              tagComponent,
            ],
          ),
          WidgetbookFolder(
            name: 'Form',
            children: [
              checkboxComponent,
              radioComponent,
              switchComponent,
              textInputComponent,
              textAreaComponent,
            ],
          ),
        ],
      ),
    ],
    addons: [
      DievasThemeAddon(),
      ComponentBoundaryAddon(),
      GridAddon(10),
      ViewportAddon([Viewports.none, ...IosViewports.all, ...AndroidViewports.all]),
      TextScaleAddon(min: 0.75, max: 1.5, initialScale: 1),
      // ignore: experimental_member_use
      TimeDilationAddon(),
      InspectorAddon(),
    ],
  );
}
