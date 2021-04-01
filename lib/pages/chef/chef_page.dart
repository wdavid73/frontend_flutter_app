import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class ChefPageHome extends StatefulWidget {
  @override
  _ChefPageHomeState createState() => _ChefPageHomeState();
}

class _ChefPageHomeState extends State<ChefPageHome> {
  var _session = FlutterSession();
  RestClientServices _restClientServices = RestClientServices();

  _logout() async {
    dynamic token = await _session.get("token");
    await _restClientServices
        .postGeneric("dj-rest-auth/logout/".endSlash(), token)
        .then((value) {
      if (value.statusCode == 0) {
        Navigator.pop(context);
      }
      print(value.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("chef page home"),
            TextButton(
              onPressed: () {
                this._logout();
              },
              child: Text("back"),
            )
          ],
        ),
      ),
    );
  }
}
