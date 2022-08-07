import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/user.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/list/list_waiters.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class ListWaitersPage extends StatefulWidget {
  const ListWaitersPage({Key? key}) : super(key: key);

  @override
  _ListWaitersPageState createState() => _ListWaitersPageState();
}

class _ListWaitersPageState extends State<ListWaitersPage> {
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();

  Future<List<User>> _getWaiters() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/list_waiters/", token);
    return parseUsers(response.data, "waiters");
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "List Waiters",
      child: ListUsers(
        responsive: responsive,
        getUsers: _getWaiters(),
      ),
    );
  }
}
