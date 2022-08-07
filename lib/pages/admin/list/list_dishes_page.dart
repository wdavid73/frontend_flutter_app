import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/list/list_dishes.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class ListDishesPage extends StatefulWidget {
  const ListDishesPage({Key? key}) : super(key: key);

  @override
  _ListDishesPageState createState() => _ListDishesPageState();
}

class _ListDishesPageState extends State<ListDishesPage> {
  bool reloadList = false;
  final List<Dish> dishes = [];
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();

  Future<List<Dish>> _getDishes() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/dish/", token);
    return parseDishes(response.data);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "List Dishes",
      child: ListDishes(
        responsive: responsive,
        getDishes: _getDishes(),
      ),
    );
  }
}
