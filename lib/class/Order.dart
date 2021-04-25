import 'package:my_restaurant_frontend_app/class/Restaurant.dart';

class Order {
/*
{
  "code": "8663KPD16",
  "date": "2020-12-11",
  "total": 0,
  "action": 1,
  "table": {
    "id": 1,
    "ref": "table n 1",
    "restaurant": {
      "code": "1NWC779",
      "name": "donde pepe",
      "cellphone": "123456789",
      "phone": "",
      "address": "cra 3c 34 ee 33"
    }
  }
}
*/

  String code;
  String date;
  int total;
  int action;
  Table table;

  Order({
    this.code,
    this.date,
    this.total,
    this.action,
    this.table,
  });
  Order.fromJson(Map<String, dynamic> json) {
    code = json["code"]?.toString();
    date = json["date"]?.toString();
    total = json["total"]?.toInt();
    action = json["action"]?.toInt();
    table = (json["table"] != null) ? Table.fromJson(json["table"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["code"] = code;
    data["date"] = date;
    data["total"] = total;
    data["action"] = action;
    if (table != null) {
      data["table"] = table.toJson();
    }
    return data;
  }
}

class Table {
/*
{
  "id": 1,
  "ref": "table n 1",
  "restaurant": {
    "code": "1NWC779",
    "name": "donde pepe",
    "cellphone": "123456789",
    "phone": "",
    "address": "cra 3c 34 ee 33"
  }
}
*/

  int id;
  String ref;
  Restaurant restaurant;

  Table({
    this.id,
    this.ref,
    this.restaurant,
  });
  Table.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    ref = json["ref"]?.toString();
    restaurant = (json["restaurant"] != null)
        ? Restaurant.fromJson(json["restaurant"])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["ref"] = ref;
    if (restaurant != null) {
      data["restaurant"] = restaurant.toJson();
    }
    return data;
  }
}
