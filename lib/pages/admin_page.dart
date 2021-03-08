import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/admin_menu_item.dart';
import 'package:my_restaurant_frontend_app/widgets/drawer_admin.dart';

class AdminPageHome extends StatefulWidget {
  @override
  _AdminPageHomeState createState() => _AdminPageHomeState();
}

class _AdminPageHomeState extends State<AdminPageHome> {
  dynamic _goToListWaiterPage() {
    print("goToListWaiterPage");
  }

  _goToListChefPage() {
    print("goToListChefPage");
  }

  _goToListDishPage() {
    print("goToListDishPage");
  }

  _goToListIngredientsPage() {
    print("goToListIngredientsPage");
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
