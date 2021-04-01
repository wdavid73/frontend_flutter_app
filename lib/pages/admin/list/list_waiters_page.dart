import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/item_user.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListWaitersPage extends StatefulWidget {
  @override
  _ListWaitersPageState createState() => _ListWaitersPageState();
}

class _ListWaitersPageState extends State<ListWaitersPage> {
  var _session = FlutterSession();
  List<FullUser> oldUsers = [], newUsers = [];
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
    do {
      dynamic token = await _session.get("token");
      _restClientServices
          .getAuthorization("api_admin/list_waiters/", token)
          .then((response) {
        if (response.statusCode == 0) {
          newUsers = parseFullUsers(response.data, "waiters");
          if (oldUsers.length < newUsers.length) {
            setState(() {
              oldUsers = newUsers;
            });
          }
          newUsers = [];
        } else {
          print(response.message);
          return;
        }
      });
    } while (oldUsers.length < newUsers.length);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsDashboard(
      title: "Waiters",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: responsive.height * 0.85,
            child: (oldUsers.length == 0)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: List.generate(
                      oldUsers.length,
                      (index) {
                        return ItemUser(
                          user: oldUsers[index],
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
