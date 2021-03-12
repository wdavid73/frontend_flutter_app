import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class RegisterDishPage extends StatefulWidget {
  @override
  _RegisterDishPageState createState() => _RegisterDishPageState();
}

class _RegisterDishPageState extends State<RegisterDishPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "Register Dish",
      child: Text("Register Dish"),
    );
  }
}
