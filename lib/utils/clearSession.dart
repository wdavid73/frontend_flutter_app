import 'package:flutter_session/flutter_session.dart';

clearSession() {
  var _session = FlutterSession();
  _session.set("token", "");
  _session.set("name", "");
  _session.set("username", "");
  _session.set("email", "");
  _session.set("position_user", "");
  _session.set("restaurantCode", "");
}
