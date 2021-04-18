import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/clearSession.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/menu_item.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';
import 'package:my_restaurant_frontend_app/widgets/userAccountHeader.dart';
import 'package:ots/ots.dart';

class DrawerAdmin extends StatefulWidget {
  final String name, email, username;

  const DrawerAdmin({
    Key key,
    this.name,
    this.email,
    this.username,
  }) : super(key: key);

  @override
  _DrawerAdminState createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  var _session = FlutterSession();
  int _selectedDestination = 0;
  DateTime currentBackPressTime;
  RestClientServices _restClientServices = RestClientServices();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      Fluttertoast.showToast(msg: "Press again to close app");
    }
    exit(0);
  }

  _logout() async {
    dynamic token = await _session.get("token");
    showLoader(isModal: true);
    await _restClientServices
        .logout("dj-rest-auth/logout/", token)
        .then((response) {
      if (response.statusCode == 0) {
        clearSession();
        //print(context);
        MyNavigator.goToHome(context);
        //exit(0);
      } else {
        print(response.message);
        hideLoader();
        mySnackBar(
          context,
          response.message.toString(),
        );
      }
    });
    hideLoader();
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
    // Navigator.pop(context);
    index == 0
        ? Navigator.pop(context)
        : index == 1
            ? MyNavigator.goToRegisterNewUser(context, "Waiter")
            : index == 2
                ? MyNavigator.goToRegisterNewUser(context, "Chef")
                : index == 3
                    ? MyNavigator.goToRegisterNewUser(context, "Admin")
                    : index == 4
                        ? MyNavigator.goToRegisterDish(context)
                        : index == 5
                            ? _logout()
                            : Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountHeader(name: widget.name, email: widget.email),
            Divider(
              color: MyColors.dividerColor,
              height: responsive.height * 0.05,
              thickness: 1,
              indent: responsive.width * 0.1,
              endIndent: responsive.width * 0.1,
            ),
            MenuItem(
              icon: Icons.home,
              index: 0,
              onTap: () => selectDestination(0),
              selectedDestination: _selectedDestination,
              title: 'Home',
            ),
            MenuItem(
              icon: Icons.person_add,
              index: 1,
              title: "Register Waiter",
              onTap: () => selectDestination(1),
              selectedDestination: _selectedDestination,
            ),
            MenuItem(
              icon: Icons.person_add,
              index: 2,
              title: "Register Chef",
              onTap: () => selectDestination(2),
              selectedDestination: _selectedDestination,
            ),
            MenuItem(
              icon: Icons.person_add,
              index: 3,
              title: "Register Admin",
              onTap: () => selectDestination(3),
              selectedDestination: _selectedDestination,
            ),
            MenuItem(
              icon: Icons.add_sharp,
              index: 4,
              title: "Register Dish",
              onTap: () => selectDestination(4),
              selectedDestination: _selectedDestination,
            ),
            Divider(
              color: MyColors.dividerColor,
              height: responsive.height * 0.05,
              thickness: 1,
              indent: responsive.width * 0.1,
              endIndent: responsive.width * 0.1,
            ),
            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: MenuItem(
                  selectedDestination: _selectedDestination,
                  title: "Logout",
                  icon: Icons.logout,
                  index: 5,
                  onTap: () => selectDestination(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
