import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/utils/button_style.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/admin.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/admin_menu_item.dart';
import 'package:my_restaurant_app/widgets/alerts/message_dialog.dart';
import 'package:my_restaurant_app/widgets/background_circles.dart';
import 'package:my_restaurant_app/widgets/drawers/custom_drawer.dart';
import 'package:my_restaurant_app/widgets/drawers/menu_drawer_admin.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String _name = '', _email = '', _username = '';
  final _session = SessionManager();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    dynamic name = await _session.get("full_name");
    dynamic email = await _session.get("email");
    dynamic username = await _session.get("username");
    setState(() {
      _name = name;
      _email = email;
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return
        CustomDrawer(
          menuDrawer: MenuDrawer(
            name: _name,
            email: _email,
            username: _username,
          ),
          content: ContentAdmin(
            responsive: responsive,
          ),
    );
  }
}

class ContentAdmin extends StatelessWidget {
  const ContentAdmin({
    Key? key,
    required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return BackgroundCircles(
      responsive: responsive,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: responsive.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: IconContainer(
                    size: responsive.dp(15),
                    iconUrl: "restaurant.svg",
                    shadow: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dp(4),
                    ),
                  ),
                ),
                GridView.count(
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  crossAxisCount: 2,
                  children: [
                    ElevatedButton(
                      onPressed: () => NavigationAdmin.goToListWaiter(context),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              description:
                                  "View showing the list of users with waiter role registered in your restaurant.",
                              type: "info",
                              context: context,
                            );
                          },
                        );
                      },
                      style: buttonStyles(MyColors.defaultPrimaryColor),
                      child: AdminMenuItem(
                        text: "List of Waiters",
                        iconUrl: "assets/icons/waiter.svg",
                        sizeIcon: responsive.dp(15),
                        textColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => NavigationAdmin.goToListChef(context),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              description:
                                  "View showing the list of users with chef role registered in your restaurant.",
                              type: "info",
                              context: context,
                            );
                          },
                        );
                      },
                      style: buttonStyles(Colors.deepOrangeAccent),
                      child: AdminMenuItem(
                        text: "List of Chefs",
                        iconUrl: "assets/icons/cooking.svg",
                        sizeIcon: responsive.dp(15),
                        textColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => NavigationAdmin.goToListDishes(context),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              description:
                                  "View showing the list of dishes registered in your restaurant.",
                              type: "info",
                              context: context,
                            );
                          },
                        );
                      },
                      style: buttonStyles(Colors.redAccent),
                      child: AdminMenuItem(
                        text: "List of Dishes",
                        iconUrl: "assets/icons/food_tray.svg",
                        sizeIcon: responsive.dp(15),
                        textColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          NavigationAdmin.goToListIngredients(context),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              description:
                                  "View showing the list of ingredients registered in your restaurant.",
                              type: "info",
                              context: context,
                            );
                          },
                        );
                      },
                      style: buttonStyles(MyColors.accentColor),
                      child: AdminMenuItem(
                        text: "List of Ingredients",
                        iconUrl: "assets/icons/ingredients.svg",
                        sizeIcon: responsive.dp(15),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Swipe Right to open the menu 👉"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*Scaffold(
appBar: AppBar(
backgroundColor: MyColors.darkPrimaryColor,
centerTitle: true,
elevation: 0,
title: const TitleAppBar(
text: 'Dashboard Admin',
),
),
body:*/
