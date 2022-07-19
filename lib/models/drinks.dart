import 'drink.dart';

class Drinks {
  List<Drink>? drinks;

  Drinks({this.drinks});

  Drinks.fromJson(Map<String, dynamic> json) {
    if (json['drinks'] != null) {
      drinks = <Drink>[];
      json['drinks'].forEach((v) {
        drinks!.add(new Drink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drinks != null) {
      data['drinks'] = this.drinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
