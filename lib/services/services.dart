import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_restaurant_frontend_app/class/Positions.dart';

class RestClientServices {
  final _headers = {'Content-Type': 'application/json'};
  final _headersAuthorization = {
    'Authorization': 'Token ',
    'Content-Type': 'application/json',
  };

  //String base = "http://10.0.2.2:8000/";
  int durationTimeOut = 60;
  String base = "https://my-resturant-api.herokuapp.com/";

  // GETS
  Future<PositionResponse> getPositions(String path) async {
    try {
      final response = await http
          .get(
            Uri.parse(base + path),
            headers: _headers,
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      if (response.statusCode == 200) {
        return PositionResponse.fromJson(jsonDecode(response.body), 0, "");
      } else {
        return PositionResponse.fromJson(null, 1, response.body);
      }
    } on TimeoutException catch (_) {
      return PositionResponse.fromJson(
        null,
        1,
        'The connection has timed out, Please try again!',
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return PositionResponse.fromJson(
          null,
          1,
          "Check your device's data or Wi-Fi connection.",
        );
      } else {
        return PositionResponse.fromJson(
          null,
          1,
          'Internal error. Contact support.',
        );
      }
    }
  }

  Future<GenericResponse> getAuthorization(String path, String token) async {
    try {
      _headersAuthorization["Authorization"] = "Token $token";
      final response = await http
          .get(
            Uri.parse(base + path),
            headers: _headersAuthorization,
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      print("try ${response.statusCode}");

      if (response.statusCode == 200) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        print("error 1");
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        print("error 2 :  $e");
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
    }
  }

  Future<GenericResponse> get(String path) async {
    try {
      final response = await http
          .get(
            Uri.parse(base + path),
            headers: _headers,
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      print("try ${response.statusCode}");
      if (response.statusCode == 200) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        print("error 1");
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        print("error 2 :  $e");
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
    }
  }

  // POTS
  Future<GenericResponse> postGeneric(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
            Uri.parse(base + path),
            headers: _headers,
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      print("try ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
    }
  }

  Future<GenericResponse> postGenericToken(
      String path, Map<String, dynamic> data, String token) async {
    try {
      _headersAuthorization["Authorization"] = "Token $token";
      final response = await http
          .post(
            Uri.parse(base + path),
            headers: _headersAuthorization,
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      print("try ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
    }
  }

  Future<GenericResponse> postUploadImageGenericToken(String path,
      Map<String, dynamic> data, String token, String filePath) async {
    try {
      _headersAuthorization["Authorization"] = "Token $token";

      var request = http.MultipartRequest("POST", Uri.parse(base + path));
      request.fields["name"] = data["name"];
      request.fields["price"] = data["price"].toString();
      request.fields["type"] = data["type"];
      request.headers["Authorization"] = "Token $token";
      var pic = await http.MultipartFile.fromPath("photo", filePath);
      request.files.add(pic);
      var response = await request.send().timeout(
            Duration(
              seconds: durationTimeOut,
            ),
          );
      print("try ${response.statusCode}");
      var responseData = await response.stream.toBytes();
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _genericResponseFromJson(0, "", responseData);
      } else {
        var responseString = String.fromCharCodes(responseData);
        return _genericResponseFromJson(1, responseString, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
    }
  }

  Future<GenericResponse> postWithoutSlash(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
            Uri.parse(base + path),
            headers: _headers,
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      if (response.statusCode == 201) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
    }
  }

  Future<GenericResponse> logout(String path, String token) async {
    try {
      _headersAuthorization["Authorization"] = "Token $token";
      final response = await http
          .post(
            Uri.parse(base + path),
            headers: _headersAuthorization,
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );
      //var body = jsonDecode(response.body);
      print("try ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } on TimeoutException catch (_) {
      return _genericResponseFromJson(
        1,
        'The connection has timed out, Please try again!',
        null,
      );
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        print("error 1");
        return _genericResponseFromJson(
          1,
          "Check your device's data or Wi-Fi connection.",
          null,
        );
      } else {
        print("error 2");
        return _genericResponseFromJson(
          1,
          'Internal error. Contact support.',
          null,
        );
      }
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
