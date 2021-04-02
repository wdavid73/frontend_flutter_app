import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/clearSession.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';
import 'package:my_restaurant_frontend_app/widgets/userAccountHeader.dart';

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
    //showLoader(isModal: true);
    await _restClientServices
        .logout("dj-rest-auth/logout/", token)
        .then((response) {
      if (response.statusCode == 0) {
        clearSession();
        //print(context);
        //MyNavigator.goToLogin(context);
        exit(0);
      } else {
        print(response.message);
        mySnackBar(
          context,
          response.message.toString(),
        );
      }
    });
    //hideLoader();
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
    Navigator.pop(context);
    index != 0 ?? index == 1
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
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountHeader(name: widget.name, email: widget.email),
            Divider(
              color: MyColors.dividerColor,
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: _selectedDestination == 0
                    ? Colors.pinkAccent
                    : Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: _selectedDestination == 0
                      ? Colors.pinkAccent
                      : Colors.white,
                ),
              ),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              leading: Icon(
                Icons.person_add,
                color: _selectedDestination == 1
                    ? Colors.pinkAccent
                    : Colors.white,
              ),
              title: Text(
                'Register Waiter',
                style: TextStyle(
                  color: _selectedDestination == 1
                      ? Colors.pinkAccent
                      : Colors.white,
                ),
              ),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_alt_1,
                color: _selectedDestination == 2
                    ? Colors.pinkAccent
                    : Colors.white,
              ),
              title: Text(
                'Register Chef',
                style: TextStyle(
                  color: _selectedDestination == 2
                      ? Colors.pinkAccent
                      : Colors.white,
                ),
              ),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_alt_1_outlined,
                color: _selectedDestination == 3
                    ? Colors.pinkAccent
                    : Colors.white,
              ),
              title: Text(
                'Register Admin',
                style: TextStyle(
                  color: _selectedDestination == 3
                      ? Colors.pinkAccent
                      : Colors.white,
                ),
              ),
              selected: _selectedDestination == 3,
              onTap: () => selectDestination(3),
            ),
            ListTile(
              leading: Icon(
                Icons.add_sharp,
                color: _selectedDestination == 4
                    ? Colors.pinkAccent
                    : Colors.white,
              ),
              title: Text(
                'Register Dish',
                style: TextStyle(
                  color: _selectedDestination == 4
                      ? Colors.pinkAccent
                      : Colors.white,
                ),
              ),
              selected: _selectedDestination == 4,
              onTap: () => selectDestination(4),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.add_sharp,
            //     color: _selectedDestination == 5
            //         ? Colors.pinkAccent
            //         : Colors.white,
            //   ),
            //   title: Text(
            //     'Register Ingredient',
            //     style: TextStyle(
            //       color: _selectedDestination == 5
            //           ? Colors.pinkAccent
            //           : Colors.white,
            //     ),
            //   ),
            //   selected: _selectedDestination == 5,
            //   onTap: () => selectDestination(5),
            // ),
            Divider(
              color: MyColors.dividerColor,
              height: 1,
              thickness: 1,
            ),
            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: _selectedDestination == 5
                        ? Colors.pinkAccent
                        : Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: _selectedDestination == 5
                          ? Colors.pinkAccent
                          : Colors.white,
                    ),
                  ),
                  selected: _selectedDestination == 5,
                  onTap: () => selectDestination(5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
