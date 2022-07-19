import 'package:astro_test/models/beverage_category.dart';
import 'package:astro_test/models/drink_detail.dart';
import 'package:astro_test/models/drinks.dart';
import 'package:astro_test/models/food_category.dart';
import 'package:astro_test/models/meal_detail.dart';
import 'package:astro_test/models/popular_beverage.dart';
import 'package:astro_test/models/popular_meal.dart';
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
    test('test meal category return food category payload', () async {
      final FoodCategory foodCategoryMock = FoodCategory(categories: [
        Category(
          idCategory: "1",
          strCategory: "1",
          strCategoryThumb: "thumbnail",
          strCategoryDescription: "description",
        )
      ]);
      
      when(() => mockRepository.fetchMealCategory()).thenAnswer((_) async => foodCategoryMock);
      expect(await mockRepository.fetchMealCategory(), foodCategoryMock);
    });
    test('test meal category return popular food by name', () async {
      final PopularMeal popularMealMock = PopularMeal(meals: [Meal(idMeal: "1", strMeal: "1", strMealThumb: "thumbnail")]);
      
      when(() => mockRepository.fetchMealByCategoryName(name: "name")).thenAnswer((_) async => popularMealMock);
      expect(await mockRepository.fetchMealByCategoryName(name: "name"), popularMealMock);
    });

    test('test meal detail return by id given', () async{
      final MealDetail mealDetailMock = MealDetail(meals: [Meals(idMeal: "")]);
      when(() => mockRepository.fetchMealDetailById(id: "")).thenAnswer((_) async => mealDetailMock);
      expect(await mockRepository.fetchMealDetailById(id: ""), mealDetailMock);
    });
  });

  group("Beverage section", () {
   test('test beverage category return food category payload', () async {
      final BeverageCategory beverageCategoryMock = BeverageCategory(drinks: [
        Drink(strCategory:""),
      ]);
      
      when(() => mockRepository.fetchBeverageCategory()).thenAnswer((_) async => beverageCategoryMock);
      expect(await mockRepository.fetchBeverageCategory(), beverageCategoryMock);
    });

    test('test beverage category return popular food by name', () async {
      final PopularBeverage popularBeverageMock = PopularBeverage(drinks: [
        Drinks(idDrink: "1")
      ]);
      
      when(() => mockRepository.fetchBeverageByCategoryName(name: "name")).thenAnswer((_) async => popularBeverageMock);
      expect(await mockRepository.fetchBeverageByCategoryName(name: "name"), popularBeverageMock);
    });

     test('test beverage detail return by id given', () async{
      final DrinkDetail drinkDetailMock = DrinkDetail(drinks: [Drinks()]);
      when(() => mockRepository.fetchDrinkDetailById(id: "")).thenAnswer((_) async => drinkDetailMock);
      expect(await mockRepository.fetchDrinkDetailById(id: ""), drinkDetailMock);
    });
  });
  
}
