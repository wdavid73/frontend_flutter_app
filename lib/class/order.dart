import './dish.dart';
import './drink.dart';
import './table.dart';

class Order {
  String code, date;
  double total;
  int action;
  TableApp table;
  List<Dish>? dishes;
  List<Drink>? drinks;

  Order({
    required this.code,
    required this.date,
    required this.total,
    required this.action,
    required this.table,
    this.dishes,
    this.drinks,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      code: json["code"].toString(),
      date: json["date"].toString(),
      total: json["total"]?.toDouble(),
      action: json["action"]?.toInt(),
      table: TableApp.fromJson(json["table"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["date"] = date;
    data["total"] = total;
    data["action"] = action;
    data["table"] = table.toJson();
    return data;
  }

  @override
  String toString() {
    return '{code: $code\n'
        'date: $code\n'
        'total: $total\n'
        'action: $action\n'
        'table: $table\n'
        '}';
  }
}
