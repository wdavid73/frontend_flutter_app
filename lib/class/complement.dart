class Complement {
  int? id;
  int quantity;
  String name, unit;
  String price;

  Complement({
    this.id,
    required this.quantity,
    required this.name,
    required this.price,
    required this.unit,
  });

  factory Complement.fromJson(Map<String, dynamic> json) {
    return Complement(
      id: json["id"].toInt(),
      name: json["name"].toString(),
      price: json["price"].toString(),
      unit: json["unit"].toString(),
      quantity: json["quantity"]?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["price"] = price;
    data["unit"] = unit;
    data["quantity"] = quantity;
    return data;
  }

  @override
  String toString() {
    return 'Dish: {\n'
        'id: $id,\n'
        'name: $name,\n'
        'price: $price,\n'
        'type: $unit,\n'
        'photo:$quantity\n'
        '}';
  }
}
