class Ingredient {
  int? _id;
  String _name = "";
  String _quantity = "";
  String _unit = "";

  String get name => _name;

  String get unit => _unit;

  String get quantity => _quantity;

  int? get id => _id;

  Ingredient({
    required String name,
    required String unit,
    required String quantity,
    int id = 0,
  }) {
    _id = id;
    _name = name;
    _quantity = quantity;
    _unit = unit;
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json["id"],
      name: json["name"].toString(),
      quantity: json["quantity"].toString(),
      unit: json["unit"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["name"] = name;
    data["quantity"] = quantity;
    data["unit"] = unit;
    return data;
  }

  @override
  String toString() {
    return 'Ingredient: {\n'
        'id: $id,\n'
        'name: $name,\n'
        'quantity: $quantity,\n'
        'unit: $unit,\n'
        '}';
  }
}
