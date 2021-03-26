import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/class/Restaurant.dart';

class User {
  int pk;
  String username, email, firstName, lastName, phone;

  User({
    this.pk,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pk: json['pk']?.toInt(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      firstName: json['first_name']?.toString(),
      lastName: json['last_name']?.toString(),
    );
  }
}

class FullUser {
  int id;
  String userName, firstName, lastName, email, phone, cellphone;
  Restaurant restaurant;
  Position position;

  FullUser({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.cellphone,
    this.restaurant,
    this.position,
  });

  factory FullUser.fromJson(Map<String, dynamic> json) {
    return FullUser(
      id: json["id"]?.toInt(),
      firstName: json["first_name"]?.toString(),
      lastName: json["last_name"]?.toString(),
      email: json["email"]?.toString(),
      phone: json["phone"]?.toString(),
      cellphone: json["cellphone"]?.toString(),
      userName: json["username"]?.toString(),
      position: (json["position"] != null)
          ? Position.fromJson(json["position"])
          : null,
      restaurant: (json["restaurant"] != null)
          ? Restaurant.fromJson(json["restaurant"])
          : null,
    );
  }

  @override
  String toString() {
    return 'User: {\n'
        'id: $id,\n'
        'username: $userName,\n'
        'email: $email,\n'
        'name: $firstName $lastName,\n'
        'phone: $phone,\n'
        'cellphone: $cellphone,\n'
        'restaurant: $restaurant,\n'
        'position: $position,\n'
        '}';
  }
}
