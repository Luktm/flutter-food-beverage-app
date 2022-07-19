import 'dart:convert';

import 'package:astro_test/models/beverage_category.dart';
import 'package:astro_test/models/drink_detail.dart';
import 'package:astro_test/models/food_category.dart';
import 'package:astro_test/models/meal_detail.dart';
import 'package:astro_test/models/popular_beverage.dart';
import 'package:astro_test/models/popular_meal.dart';
import 'package:http/http.dart' as http;

class FNBRepository {

  Future<FoodCategory> fetchMealCategory() async {
      try {
        final mealCategoryUri = Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php");
        final response  = await http.get(mealCategoryUri);

        if(response.statusCode != 200) {
          throw "Something went wrong";
        }
        
        
        return foodCategoryItemsFromJson(response.body);
        
      } catch(error) {
        rethrow;
      }
  }

  Future<PopularMeal> fetchMealByCategoryName({required String name}) async{
    try {
      final mealByNameUri = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=" + name);
      final response = await http.get(mealByNameUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }

      return popularMealItemsFromJson(response.body);

    } catch(error) {
      rethrow;
    }
  }


  Future<BeverageCategory> fetchBeverageCategory() async{
     try {
      final beverageCategoryUri = Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list");
      final response = await http.get(beverageCategoryUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }

      return beverageCategoryItemsFromJson(response.body);
    } catch(error) {
      rethrow;
    }
  }

  Future<PopularBeverage> fetchBeverageByCategoryName({required String name}) async{
    try {
      final beverageByNameUri = Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$name");
      final response = await http.get(beverageByNameUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }
      
      return PopularBeverage.fromJson(jsonDecode(response.body));
    } catch(error) {
      rethrow;
    }
  }
  
  Future<MealDetail> fetchMealDetailById({required String id}) async{
    try {
      final mealDetailUri = Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + id);
      final response = await http.get(mealDetailUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }
      
      return MealDetail.fromJson(jsonDecode(response.body));
    } catch(error) {
      rethrow;
    }
  }

  Future<DrinkDetail> fetchDrinkDetailById({required String id}) async{
    try {
      final drinkDetailUri = Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" + id);
      final response = await http.get(drinkDetailUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }
      
      return DrinkDetail.fromJson(jsonDecode(response.body));
    } catch(error) {
      rethrow;
    }
  }
}