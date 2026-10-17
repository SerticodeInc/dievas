import 'package:flutter_test/flutter_test.dart';

import 'package:dievas_gallery/main.dart';
import 'package:dievas_gallery/widgets/dievas_logo.dart';

void main() {
  testWidgets('DievasGallery renders without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(const DievasGallery());
    await tester.pumpAndSettle();
    expect(find.byType(DievasLogo), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
