import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_restaurant_frontend_app/class/Positions.dart';

class RestClientServices {
  final _headers = {'Content-Type': 'application/json'};
  //String base = "http://10.0.2.2:8000/";
  String base = "https://my-resturant-api.herokuapp.com/";

  // GETS

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
        return PositionResponse.fromJson(
          null,
          1,
          "Consulte la conexión de datos o wifi de su dispositivo, no es posible conectarse con el servidor",
        );
      } else {
        return PositionResponse.fromJson(
          null,
          1,
          "Error interno. Contacte con los desarrolladores.",
        );
      }
    }
  }

  // POTS
  Future<GenericResponse> postUser(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await http.post(base + path,
          headers: _headers, body: jsonEncode(data));
      //var body = jsonDecode(response.body);
      print("try ${response.statusCode}");
      if (response.statusCode == 201) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        print("error 1");
        return _genericResponseFromJson(
            1,
            "Consulte la conexión de datos o wifi de su dispositivo, no es posible conectarse con el servidor.",
            null);
      } else {
        print(e);
        print("error 2");
        return _genericResponseFromJson(
          1,
          'Error interno. Contacte con los desarrolladores.',
          null,
        );
      }
    }
  }

  Future<GenericResponse> postUser2(
      String path, Map<String, dynamic> data) async {
    final response = await http.post(
      base + path,
      headers: _headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return _genericResponseFromJson(0, "", response.body);
    } else {
      print("try ${response.statusCode}");
      return _genericResponseFromJson(1, "", null);
    }
  }

  GenericResponse _genericResponseFromJson(
      int statusCode, String message, dynamic data) {
    var genericResponse = new GenericResponse();
    genericResponse.statusCode = statusCode;
    genericResponse.message = message;
    genericResponse.data = data;
    return genericResponse;
  }
}

class GenericResponse {
  int statusCode;
  String message;
  dynamic data;
  GenericResponse({this.statusCode, this.message, this.data});
}
