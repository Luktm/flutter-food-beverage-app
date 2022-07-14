import 'dart:convert';

BeverageCategory beverageCategoryItemsFromJson(String str) => BeverageCategory.fromJson(json.decode(str));

String beverageCategoryToJson(BeverageCategory data) => json.encode(data.toJson());

class BeverageCategory {
    BeverageCategory({
        required this.drinks,
    });

    List<Drink> drinks;

    factory BeverageCategory.fromJson(Map<String, dynamic> json) => BeverageCategory(
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}

class Drink {
    Drink({
        required this.strCategory,
    });

    String strCategory;

    factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        strCategory: json["strCategory"],
    );

    Map<String, dynamic> toJson() => {
        "strCategory": strCategory,
    };
}
