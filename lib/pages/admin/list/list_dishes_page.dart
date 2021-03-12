import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListDishesPage extends StatefulWidget {
  @override
  _ListDishesPageState createState() => _ListDishesPageState();
}

class _ListDishesPageState extends State<ListDishesPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "List Dishes",
      child: Text("List Dishes"),
    );
  }
}
