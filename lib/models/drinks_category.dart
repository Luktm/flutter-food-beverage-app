import 'dart:convert';

import 'drink.dart';

DrinksCategory beverageCategoryItemsFromJson(String str) => DrinksCategory.fromJson(json.decode(str));

String beverageCategoryToJson(DrinksCategory data) => json.encode(data.toJson());

class DrinksCategory {
    DrinksCategory({
        required this.drinks,
    });

    List<Drink> drinks;

    factory DrinksCategory.fromJson(Map<String, dynamic> json) => DrinksCategory(
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}