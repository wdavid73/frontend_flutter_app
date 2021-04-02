class Ingredient {
/*
{
  "id": "1",
  "name": "rise",
  "quantity": "20",
  "unit": "gr"
}
*/

  String id;
  String name;
  String quantity;
  String unit;

  Ingredient({
    this.id,
    this.name,
    this.quantity,
    this.unit,
  });

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    quantity = json["quantity"]?.toString();
    unit = json["unit"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
