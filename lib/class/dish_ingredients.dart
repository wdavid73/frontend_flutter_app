import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/class/ingredient.dart';

class DishIngredients {
  Dish dish;
  List<Ingredient> ingredients;

  DishIngredients({
    required this.dish,
    required this.ingredients,
  });

  factory DishIngredients.fromJson(Map<String, dynamic> json) {
    var dish = ((json["dish"] != null) ? Dish.fromJson(json["dish"]) : null)!;
    List<Ingredient> ingredients = [];
    if (json["ingredients"] != null) {
      final v = json["ingredients"];
      final arr0 = <Ingredient>[];
      v.forEach((v) {
        arr0.add(Ingredient.fromJson(v));
      });
      ingredients = arr0;
    }
    return DishIngredients(dish: dish, ingredients: ingredients);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dish"] = dish.toJson();
    final v = ingredients;
    final arr0 = [];
    for (var v in v) {
      arr0.add(v.toJson());
    }
    data["ingredients"] = arr0;
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
