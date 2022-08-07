import 'package:my_restaurant_app/class/position.dart';
import 'package:my_restaurant_app/class/restaurant.dart';

class SimpleUser {
  String username, email, firstName, lastName, position, restaurantCode;

  SimpleUser(
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.position,
    this.restaurantCode,
  );

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      json["user"],
      json["email"],
      json["first_name"],
      json["last_name"],
      json["position"],
      json["restaurant_code"],
    );
  }
}

class User {
  late int _id;
  late String _username;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late Restaurant _restaurant;
  late Position _position;

  int get id => _id;

  String get username => _username;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get email => _email;

  String get phone => _phone;

  Restaurant get restaurant => _restaurant;

  Position get position => _position;

  User({
    id,
    username,
    firstName,
    lastName,
    email,
    phone,
    position,
    restaurant,
  }) {
    _id = id;
    _username = username;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _restaurant = restaurant;
    _position = position;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      restaurant: Restaurant.fromJson(json["restaurant"]),
      position: Position.fromJson(json["position"]),
    );
  }
}
