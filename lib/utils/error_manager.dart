import 'dart:convert';

import 'package:my_restaurant_app/class/generic_response.dart';

class ErrorManager {
  final Response _response;

  Response get response => _response;

  ErrorManager(this._response);

  static String manager(Response response) {
    if (response.httpCode == 500) {
      if (jsonDecode(response.message).containsKey('non_field_errors')) {
        dynamic error = jsonDecode(response.message)["non_field_errors"];
        return error[0];
      }
      return response.message;
    } else if (response.httpCode == 404) {
      return "Item no found";
    } else if (response.httpCode == 403) {
      return jsonDecode(response.message)["detail"];
    } else if (response.httpCode == 400) {
      if (jsonDecode(response.message).containsKey("errors")) {
        dynamic map = jsonDecode(response.message)["errors"];
        return "${map.keys.toList().first}: ${map[map.keys.toList().first][0]}";
      } else {
        dynamic map = jsonDecode(response.message);
        return "${map.keys.toList().first}: ${map[map.keys.toList().first][0]}";
      }
    } else {
      return jsonDecode(response.message);
    }
  }
}
