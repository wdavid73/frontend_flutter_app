class Response {
  bool status;
  String message;
  int httpCode;
  dynamic data;

  Response(this.status, this.message, this.httpCode, this.data);

  @override
  String toString() {
    return "httpCode : $httpCode\n"
        "statusCode : $status\n"
        "message: $message\n"
        "data: $data";
  }
}
