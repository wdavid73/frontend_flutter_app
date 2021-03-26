import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListIngredientsPage extends StatefulWidget {
  @override
  _ListIngredientsPageState createState() => _ListIngredientsPageState();
}

class _ListIngredientsPageState extends State<ListIngredientsPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "Ingredients",
      child: Text("List Ingredients"),
    );
  }
}
