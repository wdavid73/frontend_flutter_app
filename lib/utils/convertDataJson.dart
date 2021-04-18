import 'dart:convert';

import 'package:my_restaurant_frontend_app/class/Dish.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';

convertDataJson(GenericResponse response) {
  String jsonDataString = response.data.toString();
  final jsonData = jsonDecode(jsonDataString);
  return jsonData;
}

List<Position> parsePositionList(String responseBody) {
  final parsed =
      jsonDecode(responseBody)["positions"].cast<Map<String, dynamic>>();
  return parsed.map<Position>((json) => Position.fromJson(json)).toList();
}

List<FullUser> parseFullUsers(String responseBody, String type) {
  final parsed = json.decode(responseBody)[type].cast<Map<String, dynamic>>();
  return parsed.map<FullUser>((json) => FullUser.fromJson(json)).toList();
}

List<Dish> parseDishes(String responseBody) {
  final parsed = json.decode(responseBody)["dish"].cast<Map<String, dynamic>>();
  return parsed.map<Dish>((json) => Dish.fromJson(json)).toList();
}

List<Ingredient> parseIngredients(String responseBody) {
  final parsed = json
      .decode(
        responseBody,
      )["ingredients"]
      .cast<Map<String, dynamic>>();
  return parsed.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
}

Position parsePosition(String responseBody) {
  return Position.fromJson(
    jsonDecode(responseBody)["position"],
  );
}
