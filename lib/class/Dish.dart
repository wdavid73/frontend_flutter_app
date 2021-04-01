import 'dart:io';

import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/class/Restaurant.dart';

class Dish {
  /*
{
  "id": 4,
  "name": "dish test 1",
  "price": "1234.00",
  "type": "BreakFast",
  "restaurant": {
    "code": "ABC123",
    "name": "test",
    "cellphone": "12345678",
    "phone": "123456",
    "address": "en tu corazon"
  },
  "photo": "http://localhost:8000/media/dishes/2021/hamburger.jpg"
}
*/

  int id;
  String name, price, type, photo;
  Restaurant restaurant;

  Dish({
    this.id,
    this.name,
    this.price,
    this.type,
    this.photo,
    this.restaurant,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json["id"]?.toInt(),
      name: json["name"]?.toString(),
      price: json["price"]?.toString(),
      type: json["type"]?.toString(),
      photo: json["photo"]?.toString(),
      restaurant: (json["restaurant"] != null)
          ? Restaurant.fromJson(json["restaurant"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["type"] = type;
    if (restaurant != null) {
      data["restaurant"] = restaurant.toJson();
    }
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
        'restaurant_code: ${restaurant.code}\n'
        '}';
  }
}

class DishUploadImage {
  String name, type;
  double price;
  File photo;

  DishUploadImage({
    this.name,
    this.price,
    this.type,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["price"] = price;
    data["type"] = type;
    data["photo"] = photo;
    return data;
  }
}

class DishIngredients {
/*
{
  "dish": {
    "id": 4,
    "name": "dish test 1",
    "price": "1234.00",
    "type": "BreakFast",
    "restaurant": {
      "code": "ABC123",
      "name": "test",
      "cellphone": "12345678",
      "phone": "123456",
      "address": "en tu corazon"
    },
    "photo": "http://localhost:8000/media/dishes/2021/hamburger.jpg"
  },
  "ingredients": [
    {
      "id": 1,
      "name": "arroz",
      "quantity": "20",
      "unit": "gr"
    }
  ]
}
*/

  Dish dish;
  List<Ingredient> ingredients;

  DishIngredients({
    this.dish,
    this.ingredients,
  });

  DishIngredients.fromJson(Map<String, dynamic> json) {
    dish = (json["dish"] != null) ? Dish.fromJson(json["dish"]) : null;
    if (json["ingredients"] != null) {
      final v = json["ingredients"];
      final arr0 = <Ingredient>[];
      v.forEach((v) {
        arr0.add(Ingredient.fromJson(v));
      });
      ingredients = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (dish != null) {
      data["dish"] = dish.toJson();
    }
    if (ingredients != null) {
      final v = ingredients;
      final arr0 = [];
      v.forEach((v) {
        arr0.add(v.toJson());
      });
      data["ingredients"] = arr0;
    }
    return data;
  }

  @override
  String toString() {
    return 'Dish: {\n'
        'id: ${dish.id},\n'
        'name: ${dish.name},\n'
        'price: ${dish.price},\n'
        'type: ${dish.type},\n'
        'restaurant_code: ${dish.restaurant.code},\n'
        'ingredients: \n $ingredients\n'
        '}';
  }
}
