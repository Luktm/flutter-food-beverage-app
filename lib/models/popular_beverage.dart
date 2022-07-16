import 'dart:convert';

PopularBeverage popularBeverageFromJson(String str) => PopularBeverage.fromJson(json.decode(str));

String popularBeverageToJson(PopularBeverage data) => json.encode(data.toJson());

class PopularBeverage {
    PopularBeverage({
        required this.drinks,
    });

    List<Drink> drinks;

    factory PopularBeverage.fromJson(Map<String, dynamic> json) => PopularBeverage(
        drinks: json["drinks"] == null ? [] : List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
    
}

class Drink {
    Drink({
        required this.idDrink,
        required this.strDrink,
        required this.strDrinkAlternate,
        required this.strTags,
        required this.strVideo,
        required this.strCategory,
        required this.strIba,
        required this.strAlcoholic,
        required this.strGlass,
        required this.strInstructions,
        required this.strInstructionsDe,
        required this.strInstructionsIt,
        required this.strDrinkThumb,
        required this.strIngredient1,
        required this.strIngredient2,
        required this.strIngredient3,
        required this.strIngredient4,
        required this.strImageSource,
        required this.strImageAttribution,
        required this.strCreativeCommonsConfirmed,
        required this.dateModified,
    });

    String idDrink;
    String strDrink;
    dynamic strDrinkAlternate;
    String? strTags;
    dynamic strVideo;
    String? strCategory;
    String? strIba;
    String? strAlcoholic;
    String? strGlass;
    String? strInstructions;
    String? strInstructionsDe;
    String? strInstructionsIt;
    String strDrinkThumb;
    String? strIngredient1;
    String? strIngredient2;
    String? strIngredient3;
    String? strIngredient4;
    String? strImageSource;
    String? strImageAttribution;
    String? strCreativeCommonsConfirmed;
    DateTime dateModified;

    factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        idDrink: json["idDrink"],
        strDrink: json["strDrink"],
        strDrinkAlternate: json["strDrinkAlternate"],
        strTags: json["strTags"],
        strVideo: json["strVideo"],
        strCategory: json["strCategory"],
        strIba: json["strIBA"],
        strAlcoholic: json["strAlcoholic"],
        strGlass: json["strGlass"],
        strInstructions: json["strInstructions"],
        strInstructionsDe: json["strInstructionsDE"],
        strInstructionsIt: json["strInstructionsIT"],
        strDrinkThumb: json["strDrinkThumb"],
        strIngredient1: json["strIngredient1"],
        strIngredient2: json["strIngredient2"],
        strIngredient3: json["strIngredient3"],
        strIngredient4: json["strIngredient4"],
        strImageSource: json["strImageSource"],
        strImageAttribution: json["strImageAttribution"],
        strCreativeCommonsConfirmed: json["strCreativeCommonsConfirmed"],
        dateModified: DateTime.parse(json["dateModified"]),
    );

    Map<String, dynamic> toJson() => {
        "idDrink": idDrink,
        "strDrink": strDrink,
        "strDrinkAlternate": strDrinkAlternate,
        "strTags": strTags,
        "strVideo": strVideo,
        "strCategory": strCategory,
        "strIBA": strIba,
        "strAlcoholic": strAlcoholic,
        "strGlass": strGlass,
        "strInstructions": strInstructions,
        "strInstructionsDE": strInstructionsDe,
        "strInstructionsIT": strInstructionsIt,
        "strDrinkThumb": strDrinkThumb,
        "strIngredient1": strIngredient1,
        "strIngredient2": strIngredient2,
        "strIngredient3": strIngredient3,
        "strIngredient4": strIngredient4,
        "strImageSource": strImageSource,
        "strImageAttribution": strImageAttribution,
        "strCreativeCommonsConfirmed": strCreativeCommonsConfirmed,
        "dateModified": dateModified.toIso8601String(),
    };
}
