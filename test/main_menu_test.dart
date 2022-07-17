import 'package:astro_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  // run `flutter test --update-goldens`
  testWidgets('Main menu screen snapshot', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async { await tester.pumpWidget(MyApp());});
    await expectLater(find.byType(MyApp), matchesGoldenFile('goldens/main.png'));
  });
}
