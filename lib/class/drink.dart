import 'package:my_restaurant_app/class/restaurant.dart';

class Drink {
  int? id;
  String name, price;
  Restaurant? restaurant;

  Drink({
    this.id,
    required this.name,
    required this.price,
    this.restaurant,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json["id"].toInt(),
      name: json["name"].toString(),
      price: json["price"].toString(),
      restaurant: Restaurant.fromJson(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) {
      data["id"] = id;
    }
    if (restaurant != null) {
      data["restaurant"] = restaurant!.toJson();
    }
    data["name"] = name;
    data["price"] = price;
    return data;
  }

  @override
  String toString() {
    return 'Drink : {\n'
        'id : $id,\n'
        'name : $name,\n'
        'price : $price,\n'
        'restaurant_code : ${restaurant!.code}\n'
        '}';
  }
}
