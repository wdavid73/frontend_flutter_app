import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/admin.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/utils.dart';
import 'package:my_restaurant_app/widgets/drawers/submenu_item.dart';

import '../user_account_header.dart';
import 'menu_item.dart';

class MenuDrawer extends StatefulWidget {
  final String name, email, username;
  const MenuDrawer({
    Key? key,
    required this.name,
    required this.email,
    required this.username,
  }) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  int _selectedDestination = 0;

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        NavigationAdmin.goToRegisterNewUser(context, "Waiter");
        break;
      case 2:
        NavigationAdmin.goToRegisterNewUser(context, "Chef");
        break;
      case 3:
        NavigationAdmin.goToRegisterNewUser(context, "Admin");
        break;
      case 4:
        NavigationAdmin.goToRegisterDish(context);
        break;
      case 5:
        NavigationAdmin.goToRegisterTable(context);
        break;
      case 6:
        NavigationAdmin.goToRegisterDrink(context);
        break;
      case 7:
        NavigationAdmin.goToRegisterComplement(context);
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Column(
      children: [
        SizedBox(
          height: responsive.hp(25),
          child: DrawerHeader(
            child: UserAccountHeader(
              email: widget.email,
              name: widget.name,
              username: widget.username,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              MenuItem(
                icon: Icons.home,
                index: 0,
                onTap: () => selectDestination(0),
                selectedDestination: _selectedDestination,
                title: 'Home',
              ),
              SubMenuItem(
                title: "Register",
                icon: Icons.person,
                initExpanded: true,
                children: [
                  MenuItem(
                    icon: Icons.person_add,
                    index: 1,
                    title: "Waiter",
                    onTap: () => selectDestination(1),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                  MenuItem(
                    icon: Icons.person_add,
                    index: 2,
                    title: "Chef",
                    onTap: () => selectDestination(2),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                  MenuItem(
                    icon: Icons.person_add,
                    index: 3,
                    title: "Admin",
                    onTap: () => selectDestination(3),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                ],
              ),
              SubMenuItem(
                title: "Register",
                icon: Icons.add,
                children: [
                  MenuItem(
                    icon: Icons.add_sharp,
                    index: 4,
                    title: "Dish",
                    onTap: () => selectDestination(4),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                  MenuItem(
                    icon: Icons.add_box_outlined,
                    index: 5,
                    title: "Table",
                    onTap: () => selectDestination(5),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                  MenuItem(
                    icon: Icons.add_circle_outline,
                    index: 6,
                    title: "Drinks",
                    onTap: () => selectDestination(6),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                  MenuItem(
                    icon: Icons.add_circle_outline,
                    index: 7,
                    title: "Complements",
                    onTap: () => selectDestination(7),
                    selectedDestination: _selectedDestination,
                    padding: 10,
                  ),
                ],
              ),
              Divider(
                color: MyColors.dividerColor,
                height: responsive.hp(2.5),
                thickness: 1,
                indent: responsive.wp(5),
                endIndent: responsive.wp(5),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: MenuItem(
                  selectedDestination: _selectedDestination,
                  title: "Logout",
                  icon: Icons.logout,
                  index: 8,
                  onTap: () => Utils.logout(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
