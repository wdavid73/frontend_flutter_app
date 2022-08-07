import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/button_style.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/waiter.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/utils.dart';
import 'package:my_restaurant_app/widgets/admin_menu_item.dart';
import 'package:my_restaurant_app/widgets/alerts/message_dialog.dart';
import 'package:my_restaurant_app/widgets/title_app_bar.dart';

class WaiterPage extends StatefulWidget {
  const WaiterPage({Key? key}) : super(key: key);

  @override
  _WaiterPageState createState() => _WaiterPageState();
}

class _WaiterPageState extends State<WaiterPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColors.darkPrimaryColor,
        title: const TitleAppBar(
          text: "Dashboard Waiter",
        ),
        actions: [
          IconButton(
            onPressed: () => Utils.logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: responsive.wp(95),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: responsive.wp(94),
                child: ElevatedButton(
                  onPressed: () => NavigationWaiter.goToMakeOrder(context),
                  style: buttonStyles(MyColors.darkPrimaryColor),
                  child: AdminMenuItem(
                    text: 'Make Order',
                    textColor: Colors.white,
                    sizeIcon: responsive.dp(15),
                    iconUrl: "assets/icons/food_tray.svg",
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
                    onPressed: () => NavigationWaiter.goToFindOrder(context),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            description:
                                "View showing the page to find a order.",
                            type: "info",
                            context: context,
                          );
                        },
                      );
                    },
                    style: buttonStyles(MyColors.defaultPrimaryColor),
                    child: AdminMenuItem(
                      text: "Find Order",
                      iconUrl: "assets/icons/find_order.svg",
                      sizeIcon: responsive.dp(15),
                      textColor: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => NavigationWaiter.goToListOrders(context),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialogBox(
                            description: "View showing the list of orders.",
                            type: "info",
                            context: context,
                          );
                        },
                      );
                    },
                    style: buttonStyles(Colors.deepOrangeAccent),
                    child: AdminMenuItem(
                      text: "List Orders",
                      iconUrl: "assets/icons/order_food.svg",
                      sizeIcon: responsive.dp(15),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
