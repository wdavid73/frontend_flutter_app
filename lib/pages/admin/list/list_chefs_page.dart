import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/user.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/list/list_waiters.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class ListChefPage extends StatefulWidget {
  const ListChefPage({Key? key}) : super(key: key);

  @override
  _ListChefPageState createState() => _ListChefPageState();
}

class _ListChefPageState extends State<ListChefPage> {
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();

  Future<List<User>> _getChefs() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/list_chefs/", token);
    return parseUsers(response.data, "chefs");
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "List Chefs",
      child: ListUsers(
        responsive: responsive,
        getUsers: _getChefs(),
      ),
    );
  }
}
