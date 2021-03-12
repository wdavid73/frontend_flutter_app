import 'package:flutter/material.dart';
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

class _AdminPageHomeState extends State<AdminPageHome> {
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
        backgroundColor: MyColors.darkPrimaryColor,
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
      drawer: DrawerAdmin(),
      body: Center(
        child: Container(
          width: responsive.width * 0.95,
          child: GridView.count(
            padding: const EdgeInsets.all(4),
            shrinkWrap: true,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 2,
            children: [
              RaisedButton(
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
                color: MyColors.defaultPrimaryColor,
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AdminMenuItem(
                  iconUrl: 'assets/icons/waiter.svg',
                  text: "List of Waiters",
                  textColor: Colors.white,
                  sizeIcon: responsive.dp(15),
                ),
              ),
              RaisedButton(
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
                color: Colors.deepOrangeAccent,
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AdminMenuItem(
                  iconUrl: 'assets/icons/cooking.svg',
                  text: "List of Chefs",
                  textColor: Colors.white,
                  sizeIcon: responsive.dp(15),
                ),
              ),
              RaisedButton(
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
                color: Colors.redAccent,
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AdminMenuItem(
                  iconUrl: 'assets/icons/019-food_tray.svg',
                  text: "List of Dishes",
                  textColor: Colors.white,
                  sizeIcon: responsive.dp(15),
                ),
              ),
              RaisedButton(
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
                color: MyColors.accentColor,
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
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
    );
  }
}
