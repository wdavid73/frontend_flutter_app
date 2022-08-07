import 'package:my_restaurant_app/class/restaurant.dart';

class Dish {
  int id;
  String name, price, type, photo;
  Restaurant restaurant;

  Dish({
    required this.id,
    required this.price,
    required this.type,
    required this.name,
    required this.restaurant,
    required this.photo,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json["id"].toInt(),
      name: json["name"].toString(),
      price: json["price"].toString(),
      type: json["type"].toString(),
      photo: json["photo"].toString(),
      restaurant: Restaurant.fromJson(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["type"] = type;
    data["restaurant"] = restaurant.toJson();
    data["photo"] = photo;
    return data;
  }

  @override
  String toString() {
    return 'Dish: {\n'
        'id: $id,\n'
        'name: $name,\n'
        'price: $price,\n'
        'type: $type,\n'
        'photo:$photo\n'
        'restaurant_code: ${restaurant.code}\n'
        '}';
  }
}
