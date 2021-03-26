import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Dish.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/item_dish.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListDishesPage extends StatefulWidget {
  @override
  _ListDishesPageState createState() => _ListDishesPageState();
}

class _ListDishesPageState extends State<ListDishesPage> {
  var _session = FlutterSession();
  List<Dish> dishes = [];
  RestClientServices _restClientServices = RestClientServices();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getDishes();
    super.initState();
  }

  Future<void> _getDishes() async {
    dynamic token = await _session.get("token");
    _restClientServices
        .getAuthorization("api_admin/dish/", token)
        .then((response) {
      if (response.statusCode == 0) {
        setState(() {
          dishes = parseDish(response.data);
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
      title: "List Dishes",
      child: Container(
        height: responsive.height,
        color: Colors.red,
        child: (dishes.length == 0)
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(MyColors.accentColor),
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (responsive.width / responsive.height) * 1.7,
                children: List.generate(
                  dishes.length,
                  (index) {
                    return ItemDish(dish: dishes[index]);
                  },
                ),
              ),
      ),
    );
  }
}
