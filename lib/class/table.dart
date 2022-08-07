import 'package:my_restaurant_app/class/restaurant.dart';

class TableApp {
  int? id;
  String ref;
  int? state;
  Restaurant? restaurant;

  TableApp({
    this.id,
    required this.ref,
    this.restaurant,
    this.state,
  });

  factory TableApp.fromJson(Map<String, dynamic> json) {
    return TableApp(
      id: json["id"].toInt(),
      ref: json["ref"].toString(),
      state: json["state"].toInt(),
      restaurant: Restaurant.fromJson(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ref"] = ref;
    return data;
  }

  factory TableApp.clone(TableApp table) {
    return TableApp(
      id: table.id,
      ref: table.ref,
      state: table.state,
      restaurant: table.restaurant,
    );
  }

  @override
  String toString() {
    return '{id: $id\n'
        'ref: $ref\n'
        'restaurant: $restaurant\n'
        '}';
  }
}
