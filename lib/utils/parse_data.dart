import 'dart:convert';

import 'package:my_restaurant_app/class/complement.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/class/drink.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/class/order.dart';
import 'package:my_restaurant_app/class/position.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/class/user.dart';

List<Position> parsePositions(String responseBody) {
  final parsed =
      jsonDecode(responseBody)["positions"].cast<Map<String, dynamic>>();
  return parsed.map<Position>((json) => Position.fromJson(json)).toList();
}

List<User> parseUsers(String responseBody, String type) {
  final parsed = json.decode(responseBody)[type].cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

List<Ingredient> parseIngredients(String responseBody) {
  String type = "ingredients";
  final parsed = json.decode(responseBody)[type].cast<Map<String, dynamic>>();
  return parsed.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
}

List<Dish> parseDishes(String responseBody, {String key = 'dish'}) {
  final parsed = json.decode(responseBody)[key].cast<Map<String, dynamic>>();
  return parsed.map<Dish>((json) => Dish.fromJson(json)).toList();
}

List<Complement> parseComplements(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Complement>((json) => Complement.fromJson(json)).toList();
}

List<Drink> parseDrinks(String responseBody, {String key = ''}) {
  final parsed = key == ''
      ? json.decode(responseBody).cast<Map<String, dynamic>>()
      : json.decode(responseBody)[key].cast<Map<String, dynamic>>();
  return parsed.map<Drink>((json) => Drink.fromJson(json)).toList();
}

List<TableApp> parseTables(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<TableApp>((json) => TableApp.fromJson(json)).toList();
}

List<Order> parseOrders(String responseBody) {
  final parsed =
      json.decode(responseBody)["order"].cast<Map<String, dynamic>>();
  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}

Order parseOrder(String responseBody, {String key = 'order'} ) {
  dynamic parsed = json.decode(responseBody)[key].cast<String, dynamic>();
  return Order.fromJson(parsed);
}
