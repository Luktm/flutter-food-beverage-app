import 'package:astro_test/models/food_category.dart';
import 'package:astro_test/repository/fnb_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements FNBRepository {}

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockRepository mockRepository;
  // late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(
    () {
      mockRepository = MockRepository();
      // mockHttpClient = MockHttpClient();
    },
  );

  group("Meal Section", () {
    test('test meal category item return stuf', () async {
      final FoodCategory foodCategoryMock = FoodCategory(categories: [
        Category(
          idCategory: "",
          strCategory: "",
          strCategoryThumb: "",
          strCategoryDescription: "",
        )
      ]);
      
      when(() => mockRepository.fetchMealCategory()).thenAnswer((_) async => foodCategoryMock);
      expect(await mockRepository.fetchMealCategory(), foodCategoryMock);
    });
  });
}
