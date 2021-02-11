class Position {
  int id;
  String name;

  Position({this.id, this.name});

  Position.fromJson2(List<dynamic> json) {
    List<Position> listPositions = [];
    for (final obj in json) {
      Map<String, dynamic> currentElement = obj;
      Position position = Position(
        id: currentElement['id'],
        name: currentElement["name"],
      );
      listPositions.add(position);
    }
  }
  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      name: json["name"],
    );
  }
}

class PositionResponse {
  List<Position> position;
  String msg;
  int statusCode;

  PositionResponse({this.position, this.msg, this.statusCode});

  factory PositionResponse.fromJson(
      Map<String, dynamic> json, int statusCode, String msg) {
    Position p;
    List<Position> positions = [];
    if (json != null) {
      for (dynamic position in json["positions"]) {
        p = Position(id: position["id"], name: position["name"]);
        positions.add(p);
      }
      return PositionResponse(
        position: positions,
        statusCode: statusCode,
        msg: msg,
      );
    } else {
      return PositionResponse(
        position: null,
        statusCode: statusCode,
        msg: msg,
      );
    }
  }
}
