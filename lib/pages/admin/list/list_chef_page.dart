import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/item_user.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListChefPage extends StatefulWidget {
  @override
  _ListChefPageState createState() => _ListChefPageState();
}

class _ListChefPageState extends State<ListChefPage> {
  var _session = FlutterSession();
  List<FullUser> users = [];
  RestClientServices _restClientServices = RestClientServices();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getChefs();
    super.initState();
  }

  Future<void> _getChefs() async {
    dynamic token = await _session.get("token");
    _restClientServices
        .getAuthorization("api_admin/list_chefs/", token)
        .then((response) {
      if (response.statusCode == 0) {
        setState(() {
          users = parseFullUsers(response.data, "chefs");
        });
      } else {
        print(response.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsDashboard(
      title: "Chefs",
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
                        return ItemUser(
                          user: users[index],
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
