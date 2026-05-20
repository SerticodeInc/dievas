import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'gallery_components.dart';

void main() => runApp(const DievasGallery());

class DievasGallery extends StatelessWidget {
  const DievasGallery({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    home: const DievasHomePage(),
    directories: [
      WidgetbookCategory(
        name: 'Foundations',
        children: [colorTokensComponent, typographyScaleComponent, spacingTokensComponent, elevationOpacityComponent],
      ),
      WidgetbookCategory(
        name: 'Components',
        children: [
          WidgetbookFolder(
            name: 'Buttons',
            children: [filledButtonComponent, outlinedButtonComponent, textButtonComponent, iconButtonComponent],
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
            children: [checkboxComponent, radioComponent, switchComponent, textInputComponent, textAreaComponent],
          ),
          WidgetbookFolder(name: 'Feedback', children: [alertComponent, bannerComponent, snackbarComponent]),
          WidgetbookFolder(name: 'Overlays', children: [bottomSheetComponent, modalComponent, tooltipComponent]),
          WidgetbookFolder(name: 'Utility', children: [loaderComponent, emptyStateComponent]),
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
