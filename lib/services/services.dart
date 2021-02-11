import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_restaurant_frontend_app/class/Positions.dart';

class RestClientServices {
  final _headers = {'Content-Type': 'application/json'};
  String base = "https://my-resturant-api.herokuapp.com/";

  Future<PositionResponse> getPositions(String path) async {
    try {
      final response = await http.get(base + path, headers: _headers);
      if (response.statusCode == 200) {
        return PositionResponse.fromJson(jsonDecode(response.body), 0, "");
      } else {
        return PositionResponse.fromJson(null, 1, response.body);
      }
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return PositionResponse.fromJson(null, 1,
            "Consulte la conexión de datos o wifi de su dispositivo, no es posible conectarse con el servidor.");
      } else {
        return PositionResponse.fromJson(null, 1,
            'Error interno. Contacte con los desarrolladores. Detalles: ${e.toString()}');
      }
    }
  }
}
