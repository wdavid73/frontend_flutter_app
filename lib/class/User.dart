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
      pk: json['pk'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
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
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      cellphone: json["cellphone"],
      userName: json["username"],
      position: Position(
        id: json["position"]["id"],
        name: json["position"]["name"],
      ),
      restaurant: Restaurant(
        code: json["restaurant"]["code"],
        name: json["restaurant"]["name"],
        address: json["restaurant"]["address"],
        cellphone: json["restaurant"]["cellphone"],
        phone: json["restaurant"]["phone"],
      ),
    );
  }
}
