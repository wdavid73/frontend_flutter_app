import 'dart:convert';

class Position {
  int id;
  String name;

  Position({required this.id, required this.name});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'].toInt(),
      name: json["name"].toString(),
    );
  }

  factory Position.parsePosition(String responseBody) {
    return Position.fromJson(
      jsonDecode(responseBody)["position"],
    );
  }

  @override
  String toString() {
    return 'Position: {\n'
        'id: $id,\n'
        'name: $name,\n'
        '}';
  }
}
