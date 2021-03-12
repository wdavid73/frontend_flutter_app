import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';
import 'package:my_restaurant_frontend_app/widgets/user_item.dart';

class ListWaitersPage extends StatefulWidget {
  @override
  _ListWaitersPageState createState() => _ListWaitersPageState();
}

class _ListWaitersPageState extends State<ListWaitersPage> {
  var _session = FlutterSession();
  List<FullUser> users = [];
  RestClientServices _restClientServices = RestClientServices();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getWaiters();
    super.initState();
  }

  Future<void> _getWaiters() async {
    dynamic token = await _session.get("token");
    _restClientServices
        .getAuthorization("api_admin/register/waiter/", token)
        .then((response) {
      if (response.statusCode == 0) {
        setState(() {
          users = parseFullUsers(response.data);
        });
      } else {
        print(response.message);
      }
    });
  }

  List<FullUser> parseFullUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<FullUser>((json) => FullUser.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsDashboard(
      title: "List Waiters",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: responsive.height * 0.85,
            child: (users.length == 0)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: List.generate(
                      users.length,
                      (index) {
                        return ItemUser(user: users[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
