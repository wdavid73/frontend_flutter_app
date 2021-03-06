import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/admin_menu_item.dart';
import 'package:my_restaurant_frontend_app/widgets/alert_dialog_custom.dart';
import 'package:my_restaurant_frontend_app/widgets/drawer_admin.dart';

class AdminPageHome extends StatefulWidget {
  @override
  _AdminPageHomeState createState() => _AdminPageHomeState();
}

class _AdminPageHomeState extends State<AdminPageHome>
    with TickerProviderStateMixin {
  String _name, _email, _username;

  var _session = FlutterSession();

  @override
  void initState() {
    _init();

    super.initState();
  }

  void _init() {
    this._getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    dynamic name = await _session.get("name");
    dynamic email = await _session.get("email");
    dynamic username = await _session.get("username");

    setState(() {
      _name = name;
      _email = email;
      _username = username;
    });

    print(_username);
  }

  _goToListWaiterPage() {
    print("goToListWaiterPage");
    MyNavigator.goToListWaiter(context);
  }

  _goToListChefPage() {
    print("goToListChefPage");
    MyNavigator.goToListChef(context);
  }

  _goToListDishPage() {
    print("goToListDishPage");
    MyNavigator.goToListDishes(context);
  }

  _goToListIngredientsPage() {
    print("goToListIngredientsPage");
    MyNavigator.goToListIngredients(context);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: MyColors.darkPrimaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Dashboard Admin",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(2),
          ),
        ),
      ),
      drawer: DrawerAdmin(
        name: _name,
        email: _email,
        username: _username,
      ),
      body: Container(
        child: Center(
          child: Container(
            width: responsive.width * 0.95,
            child: GridView.count(
              padding: const EdgeInsets.all(4),
              shrinkWrap: true,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              children: [
                ElevatedButton(
                  onPressed: () {
                    this._goToListWaiterPage();
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogCustom(
                          page: "waiters",
                        );
                      },
                    );
                  },
                  style: buttonStyles(MyColors.defaultPrimaryColor),
                  child: AdminMenuItem(
                    iconUrl: 'assets/icons/waiter.svg',
                    text: "List of Waiters",
                    textColor: Colors.white,
                    sizeIcon: responsive.dp(15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    this._goToListChefPage();
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogCustom(
                          page: "chefs",
                        );
                      },
                    );
                  },
                  style: buttonStyles(Colors.deepOrangeAccent),
                  child: AdminMenuItem(
                    iconUrl: 'assets/icons/cooking.svg',
                    text: "List of Chefs",
                    textColor: Colors.white,
                    sizeIcon: responsive.dp(15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    this._goToListDishPage();
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogCustom(
                          page: "dishes",
                        );
                      },
                    );
                  },
                  style: buttonStyles(Colors.redAccent),
                  child: AdminMenuItem(
                    iconUrl: 'assets/icons/019-food_tray.svg',
                    text: "List of Dishes",
                    textColor: Colors.white,
                    sizeIcon: responsive.dp(15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    this._goToListIngredientsPage();
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogCustom(
                          page: "ingredients",
                        );
                      },
                    );
                  },
                  style: buttonStyles(MyColors.accentColor),
                  child: AdminMenuItem(
                    iconUrl: 'assets/icons/ingredients.svg',
                    text: "List of Ingredients",
                    textColor: Colors.white,
                    sizeIcon: responsive.dp(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle buttonStyles(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        color,
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(5),
      ),
    );
  }
}
