import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class RegisterNewUser extends StatefulWidget {
  final String position;

  // receive data from the FirstScreen as a parameter
  RegisterNewUser({Key key, @required this.position}) : super(key: key);

  @override
  _RegisterNewUserState createState() => _RegisterNewUserState();
}

class _RegisterNewUserState extends State<RegisterNewUser> {
  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "Register User",
      child: Text("Register User ${widget.position}"),
    );
  }
}
