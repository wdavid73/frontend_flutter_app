import 'dart:io';

class DishUploadImage {
  String name, type;
  double price;
  File? photo;

  DishUploadImage({
    required this.name,
    required this.price,
    required this.type,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["price"] = price;
    data["type"] = type;
    data["photo"] = photo;
    return data;
  }
}
