import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListChefPage extends StatefulWidget {
  @override
  _ListChefPageState createState() => _ListChefPageState();
}

class _ListChefPageState extends State<ListChefPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "List Chefs",
      child: Text("List Chefs"),
    );
  }
}
