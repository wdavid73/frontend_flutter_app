import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class RegisterIngredientPage extends StatefulWidget {
  @override
  _RegisterIngredientPageState createState() => _RegisterIngredientPageState();
}

class _RegisterIngredientPageState extends State<RegisterIngredientPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "Register Ingredient",
      child: Text("Register Ingredient"),
    );
  }
}
