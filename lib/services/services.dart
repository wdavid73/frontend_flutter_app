import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:my_restaurant_app/class/generic_response.dart';

class ApiProvider {
  final _headers = {"Content-Type": "application/json"};

  String api = "https://my-resturant-api.herokuapp.com/";
  int durationTimeOut = 30;

  Future<Response> get(String path, [String? token]) async {
    try {
      token != null && token != ""
          ? _headers["Authorization"] = "Token $token"
          : null;

      final response = await http
          .get(
            Uri.parse(api + path),
            headers: _headers,
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );

      if (response.statusCode == 200) {
        return _responseFromJson(
          true,
          "",
          response.statusCode,
          response.body,
        );
      }
      return _responseFromJson(
        false,
        response.body,
        response.statusCode,
        null,
      );
    } on TimeoutException catch (_) {
      return _responseFromJson(
        false,
        'The connection has timed out, Please try again!',
        500,
        null,
      );
    } catch (e) {
      Map<String, dynamic> error = errorResponse(e);
      return _responseFromJson(
        error["statusCode"],
        error["message"],
        500,
        error["data"],
      );
    }
  }

  Future<Response> post(String path, dynamic data, [String? token]) async {
    try {
      token != null && token != ""
          ? _headers["Authorization"] = "Token $token"
          : null;

      final response = await http
          .post(
            Uri.parse(api + path),
            headers: _headers,
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: durationTimeOut),
          );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return _responseFromJson(
          true,
          "",
          response.statusCode,
          response.body,
        );
      } else {
        return _responseFromJson(
          false,
          response.body,
          response.statusCode,
          null,
        );
      }
    } on TimeoutException catch (_) {
      return _responseFromJson(
        false,
        'The connection has timed out, Please try again!',
        500,
        null,
      );
    } catch (e) {
      Map<String, dynamic> error = errorResponse(e);
      return _responseFromJson(
        error["statusCode"],
        error["message"],
        500,
        error["data"],
      );
    }
  }

  Future<Response> postImage(String path, dynamic data, String filePath,
      [String? token]) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(api + path),
      );
      request.fields["name"] = data["name"];
      request.fields["price"] = data["price"].toString();
      request.fields["type"] = data["type"];
      request.headers["Authorization"] = "Token $token";
      var pic = await http.MultipartFile.fromPath("photo", filePath);
      request.files.add(pic);
      final response = await request.send().timeout(
            Duration(seconds: durationTimeOut),
          );

      var responseData = await response.stream.toBytes();
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _responseFromJson(
          true,
          "",
          response.statusCode,
          responseData,
        );
      } else {
        return _responseFromJson(
          false,
          String.fromCharCodes(responseData),
          response.statusCode,
          null,
        );
      }
    } on TimeoutException catch (_) {
      return _responseFromJson(
        false,
        'The connection has timed out, Please try again!',
        500,
        null,
      );
    } catch (e) {
      Map<String, dynamic> error = errorResponse(e);
      return _responseFromJson(
        error["statusCode"],
        error["message"],
        500,
        error["data"],
      );
    }
  }

  Map<String, dynamic> errorResponse(Object e) {
    if (e.toString().contains("No route to host") ||
        e.toString().contains("No address associated with hostname") ||
        e.toString().contains("Connection refused") ||
        e.toString().contains("Network is unreachable")) {
      return {
        "statusCode": false,
        "message": "Check your device's data or Wi-Fi connection.",
        "data": null,
      };
    } else {
      return {
        "statusCode": false,
        "message": 'Internal error. Contact support.',
        "data": null,
      };
    }
  }

  Response _responseFromJson(
    bool status,
    String message,
    int httpCode,
    dynamic data,
  ) {
    var response = Response(
      status,
      message,
      httpCode,
      data,
    );
    return response;
  }
}
