import 'dart:convert';

import 'package:astro_test/models/drinks_category.dart';
import 'package:astro_test/models/drinks.dart';
import 'package:astro_test/models/meals_category.dart';
import 'package:astro_test/models/meals.dart';
import 'package:astro_test/models/meal.dart';
import 'package:http/http.dart' as http;

class FNBRepository {

  Future<MealsCategory> fetchMealCategory() async {
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

  Future<Meals> fetchMealByCategoryName({required String name}) async{
    try {
      final mealByNameUri = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=" + name);
      final response = await http.get(mealByNameUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }

      return Meals.fromJson(jsonDecode(response.body));

    } catch(error) {
      rethrow;
    }
  }


  Future<DrinksCategory> fetchBeverageCategory() async{
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

  Future<Drinks> fetchBeverageByCategoryName({required String name}) async{
    try {
      final beverageByNameUri = Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$name");
      final response = await http.get(beverageByNameUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }
      
      return Drinks.fromJson(jsonDecode(response.body));
    } catch(error) {
      rethrow;
    }
  }
  
  Future<Meals> fetchMealDetailById({required String id}) async{
    try {
      final mealDetailUri = Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + id);
      final response = await http.get(mealDetailUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }
      
      return Meals.fromJson(jsonDecode(response.body));
    } catch(error) {
      rethrow;
    }
  }

  Future<Drinks> fetchDrinkDetailById({required String id}) async{
    try {
      final drinkDetailUri = Uri.parse("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" + id);
      final response = await http.get(drinkDetailUri);

      if(response.statusCode != 200) {
        throw "Something went wrong";
      }
      
      return Drinks.fromJson(jsonDecode(response.body));
    } catch(error) {
      rethrow;
    }
  }
}