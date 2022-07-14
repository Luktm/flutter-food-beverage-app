import 'dart:convert';

FoodCategory foodCategoryItemsFromJson(String str) => FoodCategory.fromJson(json.decode(str));

String foodCategoryItemsToJson(FoodCategory data) => json.encode(data.toJson());

class FoodCategory {
    FoodCategory({
        required this.categories,
    });

    List<Category> categories;

    factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        required this.idCategory,
        required this.strCategory,
        required this.strCategoryThumb,
        required this.strCategoryDescription,
    });

    String idCategory;
    String strCategory;
    String strCategoryThumb;
    String strCategoryDescription;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
    );

    Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
    };
}
