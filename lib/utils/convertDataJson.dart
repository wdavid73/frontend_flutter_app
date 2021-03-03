import 'dart:convert';

import 'package:my_restaurant_frontend_app/services/services.dart';

convertDataJson(GenericResponse response) {
  String jsonDataString = response.data.toString();
  final jsonData = jsonDecode(jsonDataString);
  return jsonData;
}
