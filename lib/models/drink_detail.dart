import 'drinks.dart';

class DrinkDetail {
  List<Drinks>? drinks;

  DrinkDetail({this.drinks});

  DrinkDetail.fromJson(Map<String, dynamic> json) {
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks!.add(new Drinks.fromJson(v));
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
